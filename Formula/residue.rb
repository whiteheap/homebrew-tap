# residue: release binaries from https://github.com/whiteheap/residue/releases
class Residue < Formula
  desc "Reclaim disk from coding-agent Git worktrees without losing work"
  homepage "https://github.com/whiteheap/residue"
  version "0.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.1/residue-v0.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "60515266b3cf9184c305991b9821502535547a69e1eb979c53f82e8730879e3d"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.1/residue-v0.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "fefd4056e6052ed291b7115369f6cc6c69ec8890e9e81ab7aebadcf5cc53eae5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.1/residue-v0.0.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0c48d3430ccce947f7d0fb29024e1047bd778e53920c0195de24b95aa2d6560a"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.1/residue-v0.0.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f6822b42b71419a16ee628cda96fc6b2346c319c2e00bedb2dd05bdf01025dfa"
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
