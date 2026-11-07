# residue: release binaries from https://github.com/whiteheap/residue/releases
class Residue < Formula
  desc "Reclaim disk from coding-agent Git worktrees without losing work"
  homepage "https://residue.whiteheap.com"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.6/residue-v0.0.6-aarch64-apple-darwin.tar.gz"
      sha256 "eed079e7d4620469ef14ab52ffc33e30034544a3960e6e8f2a4d7e56d5dc5bd6"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.6/residue-v0.0.6-x86_64-apple-darwin.tar.gz"
      sha256 "727a6a403688d291dec00ae5294b5f5fe0a109a7ebd1e40b6b1468c299ce5ee6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.6/residue-v0.0.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ab65efc199c07ffac1d3bd0968e1589dccb7825e36ba24ae6cfc2fc5dc07dbdb"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.6/residue-v0.0.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "55192753119c30c9cda98cd015813cac4902aca161a80a3e20b5fdeefb99f071"
    end
  end

  def install
    bin.install "residue"
  end

  def caveats
    <<~EOS
      residue needs git 2.36 or later on PATH.
      `residue scan` only reads. `residue remove` asks before it deletes.
      To clean up automatically, run `residue watch` from login (launchd,
      systemd) on the folder that holds your repositories:
        residue service install ~/src
      https://github.com/whiteheap/residue#automate-cleanup
    EOS
  end

  test do
    assert_match "residue #{version}", shell_output("#{bin}/residue --version")
  end
end
