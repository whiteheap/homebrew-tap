# residue: release binaries from https://github.com/whiteheap/residue-cli/releases
class Residue < Formula
  desc "Reclaim storage from Git worktrees without losing work"
  homepage "https://residue.whiteheap.com"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.13/residue-v0.0.13-aarch64-apple-darwin.tar.gz"
      sha256 "60bb83c6cc9b9fddaa0184267bf938f75aae99bee9d965e177be50fc2c08316b"
    end
    on_intel do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.13/residue-v0.0.13-x86_64-apple-darwin.tar.gz"
      sha256 "45d0f382bf071630d42d272be9fc3aea1a3881de1b59d6d67f7665f9a0c4214d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.13/residue-v0.0.13-aarch64-unknown-linux-musl.tar.gz"
      sha256 "800cd6ace1d902e9f0b96242e51ecf56176d6c7a5441a9ce6703108b73ba84fe"
    end
    on_intel do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.13/residue-v0.0.13-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d96de6d18327fcaa9b160c382c2f780e4c2a3836a5cef51d11c0ed9435c070c8"
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
