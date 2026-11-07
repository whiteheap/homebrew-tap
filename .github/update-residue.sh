#!/bin/sh
# Points Formula/residue.rb at the latest whiteheap/residue release, when that
# release is newer than the formula. Rewrites only the four url lines and the
# four sha256 lines; Homebrew reads the version from the url.
#
#   sh .github/update-residue.sh            # the latest release
#   sh .github/update-residue.sh v0.0.7     # a given tag
#
# Each checksum comes from the release's SHA256SUMS, and each archive is
# downloaded, checked against it and against its build-provenance attestation
# before the formula names it. Needs gh with a token (GH_TOKEN).
# Prints "updated=true" or "updated=false" last, for $GITHUB_OUTPUT.
set -eu

repo=whiteheap/residue
formula=Formula/residue.rb
targets="aarch64-apple-darwin x86_64-apple-darwin aarch64-unknown-linux-musl x86_64-unknown-linux-musl"

latest=${1:-$(gh release view -R "$repo" --json tagName --jq .tagName)}
current=$(sed -n 's|.*/releases/download/\(v[0-9][^/]*\)/.*|\1|p' "$formula" | sort -u)
case $latest in v[0-9]*.[0-9]*.[0-9]*) ;; *) echo "not a release tag: $latest" >&2; exit 1 ;; esac
[ "$(printf '%s\n' "$current" | wc -l | tr -d ' ')" = 1 ] || { echo "$formula names more than one release: $current" >&2; exit 1; }
echo "formula: $current, latest release: $latest"

if [ "$current" = "$latest" ]; then
  echo "the formula is current"
  echo updated=false
  exit 0
fi
newest=$(printf '%s\n%s\n' "${current#v}" "${latest#v}" | sort -t. -k1,1n -k2,2n -k3,3n | tail -n1)
if [ "$newest" != "${latest#v}" ]; then
  echo "the formula ($current) is newer than $latest; leaving it"
  echo updated=false
  exit 0
fi

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
gh release download "$latest" -R "$repo" -p SHA256SUMS -D "$work"
for target in $targets; do
  name=residue-$latest-$target.tar.gz
  sum=$(awk -v f="$name" '$2 == f { print $1 }' "$work/SHA256SUMS")
  [ "${#sum}" = 64 ] || { echo "SHA256SUMS of $latest has no line for $name" >&2; exit 1; }
  gh release download "$latest" -R "$repo" -p "$name" -D "$work"
  (cd "$work" && printf '%s  %s\n' "$sum" "$name" | shasum -a 256 -c)
  gh attestation verify "$work/$name" --repo "$repo"
  # The url line naming this target gets the new tag; the sha256 line after
  # it gets the new checksum. Nothing else in the file changes.
  awk -v target="$target" -v tag="$latest" -v sum="$sum" '
    $1 == "url" && index($0, "-" target ".tar.gz\"") {
      sub(/download\/v[0-9][^\/]*\/residue-v[0-9][^-]*-/, "download/" tag "/residue-" tag "-")
      hit = 1
    }
    hit && $1 == "sha256" { sub(/"[0-9a-f]+"/, "\"" sum "\""); hit = 0 }
    { print }
  ' "$formula" >"$work/residue.rb"
  cat "$work/residue.rb" >"$formula"
done

# Exactly four url lines and four sha256 lines changed, and no old tag is left.
changed=$(git diff --numstat -- "$formula" | awk '{ print $1 " " $2 }')
[ "$changed" = "8 8" ] || { git diff -- "$formula"; echo "expected 8 changed lines, got: $changed" >&2; exit 1; }
! grep -q "$current" "$formula" || { echo "$formula still names $current" >&2; exit 1; }
git diff -- "$formula"
echo updated=true
