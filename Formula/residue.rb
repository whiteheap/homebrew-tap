# residue: release binaries from https://github.com/whiteheap/residue/releases
class Residue < Formula
  desc "Reclaim disk from coding-agent Git worktrees without losing work"
  homepage "https://residue.whiteheap.com"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.9/residue-v0.0.9-aarch64-apple-darwin.tar.gz"
      sha256 "9bb6a365d72c4b5caac4a455d2a59040d8c19092c9cc7633f1b87c9becf550c4"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.9/residue-v0.0.9-x86_64-apple-darwin.tar.gz"
      sha256 "6625e2944487802116652b22a902cf1ce0846a893d50ee59fd8a91c316168c1d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.9/residue-v0.0.9-aarch64-unknown-linux-musl.tar.gz"
      sha256 "99ddf7d2f70b31a133a6f0b6249f6c98716b7c97004f4ee700c4c0a351006110"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.9/residue-v0.0.9-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a9e6a4ce24010da9b7259c38569d51e9b793c351195a36caaca5e5612dcb3597"
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
