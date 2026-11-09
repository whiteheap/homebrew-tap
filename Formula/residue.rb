# residue: release binaries from https://github.com/whiteheap/residue-cli/releases
class Residue < Formula
  desc "Reclaim storage from Git worktrees without losing work"
  homepage "https://residue.whiteheap.com"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.11/residue-v0.0.11-aarch64-apple-darwin.tar.gz"
      sha256 "7adb436af9ae8937561dd9d46b2a7a133e3c6f6701b6963ad6a6da91fac37fb3"
    end
    on_intel do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.11/residue-v0.0.11-x86_64-apple-darwin.tar.gz"
      sha256 "deee6f3d630f21fb6154760c61192ef057f22b948243ca2a76c4f36115b75e60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.11/residue-v0.0.11-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1aeab8d217ef7c0541dfed3bb8d99703e93eb455994b7ef37e049075b96fa2c8"
    end
    on_intel do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.11/residue-v0.0.11-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6a017b723bcc6c78f58a7883b990a92e2f76b3944c00d354897ee58200e8568b"
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
