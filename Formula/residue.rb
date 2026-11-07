# residue: release binaries from https://github.com/whiteheap/residue/releases
class Residue < Formula
  desc "Reclaim disk from coding-agent Git worktrees without losing work"
  homepage "https://github.com/whiteheap/residue"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.5/residue-v0.0.5-aarch64-apple-darwin.tar.gz"
      sha256 "96244df30fbabc5c60cfd3440f90f2a3767c9d774936abaf5b33df551295b911"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.5/residue-v0.0.5-x86_64-apple-darwin.tar.gz"
      sha256 "4ca9815996d9e0590712f0f800af9ba6012d3b53633495759e42dc46347fe770"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.5/residue-v0.0.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "22a6caaf5a9e739d9f6d7f830badf6d2abb2c6ed8aba08caa71f96db0e7529db"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.5/residue-v0.0.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ad954c68cab79bb275a4981b7b2cb4d0f740807ea356bbce4d6a94af025d36f5"
    end
  end

  def install
    bin.install "residue"
  end

  def caveats
    <<~EOS
      residue needs git 2.36 or later on PATH.
      `residue scan` only reads. `residue remove` asks before it deletes.
      To sweep idle worktrees on a schedule (launchd or systemd), see
        https://github.com/whiteheap/residue#run-it-on-a-schedule
    EOS
  end

  test do
    assert_match "residue #{version}", shell_output("#{bin}/residue --version")
  end
end
