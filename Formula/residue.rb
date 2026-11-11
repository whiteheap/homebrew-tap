# residue: release binaries from https://github.com/whiteheap/residue-cli/releases
class Residue < Formula
  desc "Reclaim storage from Git worktrees without losing work"
  homepage "https://residue.whiteheap.com"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.14/residue-v0.0.14-aarch64-apple-darwin.tar.gz"
      sha256 "08736d184a9329943a7714cd669f6bf5df74d93e084aa482a39a3feffe1ba12d"
    end
    on_intel do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.14/residue-v0.0.14-x86_64-apple-darwin.tar.gz"
      sha256 "4ad48c13318f3f90f4b7796fc9d45170c572a47b9663314453e2f0772978f5b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.14/residue-v0.0.14-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3ba9f7e06e25ed401278dba7093f986bda41d01f99fbf049d0cd8dee11c67ec3"
    end
    on_intel do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.14/residue-v0.0.14-x86_64-unknown-linux-musl.tar.gz"
      sha256 "000ac9af912e09be6e3ba8eca71ee4c8343b26e46e01873b2e0b6e243ead612b"
    end
  end

  def install
    bin.install "residue"
  end

  def caveats
    <<~EOS
      residue needs git 2.36 or later on PATH.
      `residue scan` deletes nothing. `residue remove` asks before it deletes.
      To clean up automatically, run this once. It starts `residue watch` now
      and at every login, on the usual code folders in your home folder, and
      deletes worktrees that pass every check, without asking:
        residue service install
      https://github.com/whiteheap/residue-cli#automate-cleanup
      Turn it off before you uninstall residue:
        residue service uninstall
    EOS
  end

  test do
    assert_match "residue #{version}", shell_output("#{bin}/residue --version")
  end
end
