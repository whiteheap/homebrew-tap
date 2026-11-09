# residue: release binaries from https://github.com/whiteheap/residue-cli/releases
class Residue < Formula
  desc "Reclaim storage from Git worktrees without losing work"
  homepage "https://residue.whiteheap.com"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.12/residue-v0.0.12-aarch64-apple-darwin.tar.gz"
      sha256 "2989452ef10e1a0ae10ca34cde40dafbb66a00c5f922269b6af84617ed65bf34"
    end
    on_intel do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.12/residue-v0.0.12-x86_64-apple-darwin.tar.gz"
      sha256 "bc67c55feb39f5eeba6059cf80cd3714547188c679e18255726b2327a9074728"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.12/residue-v0.0.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d2767198dfb27d970979ab725738ca53fbaa52420d0cf0bde0dbb6c7b543f194"
    end
    on_intel do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.12/residue-v0.0.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "329ad180abda47dbed50d85ddd560af4fc2c35d8e160ef74606fb40c3d4af88b"
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
