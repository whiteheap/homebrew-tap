# residue: release binaries from https://github.com/whiteheap/residue/releases
class Residue < Formula
  desc "Reclaim disk from coding-agent Git worktrees without losing work"
  homepage "https://github.com/whiteheap/residue"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.4/residue-v0.0.4-aarch64-apple-darwin.tar.gz"
      sha256 "4476a27bf6988798326caae17d1f076d191197df910184ca14ac25ca06310a20"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.4/residue-v0.0.4-x86_64-apple-darwin.tar.gz"
      sha256 "4ab9c66a76ca3c1221c5b20f7470d84cdb26aac83d4699033eac7664740e1b98"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.4/residue-v0.0.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "94e370e0eba8e60fbf8e9f7016b5c98b3b78a7ae6dd2da3b2ca82a74c8028625"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.4/residue-v0.0.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "521fb8250b7373c25810e655855eb25169e5b83c0b843b4a7750fd7a034103fe"
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
