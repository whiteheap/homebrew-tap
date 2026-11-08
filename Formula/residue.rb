# residue: release binaries from https://github.com/whiteheap/residue/releases
class Residue < Formula
  desc "Reclaim disk from coding-agent Git worktrees without losing work"
  homepage "https://residue.whiteheap.com"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.8/residue-v0.0.8-aarch64-apple-darwin.tar.gz"
      sha256 "4d274813034c240c7ba3dd1bb64f937bd4ec0e2054169e9d0bbb3158f525ae6c"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.8/residue-v0.0.8-x86_64-apple-darwin.tar.gz"
      sha256 "e49f99d58f9a9d6df3ceae5a6159d29d0b52def76d2ff460339257bc2fa23911"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.8/residue-v0.0.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "87a9c44bbf1dbb1b27e9887942965db8a1e54fd0528078b3ceb490919e1d7639"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.8/residue-v0.0.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "24176cda4fd5b2b2da60a049c96c87afd200b64565e982df1fc1dccc94451c7f"
    end
  end

  def install
    bin.install "residue"
  end

  def caveats
    <<~EOS
      residue needs git 2.36 or later on PATH.
      `residue scan` only reads. `residue remove` asks before it deletes.
      To clean up automatically, run this once. It starts `residue watch` now
      and at every login, on the usual code folders in your home folder:
        residue service install
      https://github.com/whiteheap/residue#automate-cleanup
    EOS
  end

  test do
    assert_match "residue #{version}", shell_output("#{bin}/residue --version")
  end
end
