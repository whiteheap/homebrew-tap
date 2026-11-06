# residue: release binaries from https://github.com/whiteheap/residue/releases
class Residue < Formula
  desc "Reclaim disk from coding-agent Git worktrees without losing work"
  homepage "https://github.com/whiteheap/residue"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.3/residue-v0.0.3-aarch64-apple-darwin.tar.gz"
      sha256 "e60877300a1b91df3eb34f1fdb798018aca6523d6bb3d79b4171133e7aa57098"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.3/residue-v0.0.3-x86_64-apple-darwin.tar.gz"
      sha256 "7191b6690a4b52801f16dfcbd7434fe2d98b31773f37bbe133229627de66b812"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.3/residue-v0.0.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1dd2989e67ce77589bbc4b92d9368741bd7a3515cdd8462e874ea807e02b0d4d"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.3/residue-v0.0.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "88fb6210cc0506e4811f4672361208440eb47ce197a208935a7d304449874f13"
    end
  end

  def install
    bin.install "residue"
  end

  def caveats
    <<~EOS
      residue needs git 2.36 or later on PATH.
      `residue scan` only reads. `residue remove` asks before it deletes.
    EOS
  end

  test do
    assert_match "residue #{version}", shell_output("#{bin}/residue --version")
  end
end
