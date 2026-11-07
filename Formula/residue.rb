# residue: release binaries from https://github.com/whiteheap/residue/releases
class Residue < Formula
  desc "Reclaim disk from coding-agent Git worktrees without losing work"
  homepage "https://residue.whiteheap.com"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.7/residue-v0.0.7-aarch64-apple-darwin.tar.gz"
      sha256 "686685552f13056e1467fd3094aacd35d997bfacfd86bc6be6415528cb1226e5"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.7/residue-v0.0.7-x86_64-apple-darwin.tar.gz"
      sha256 "73242ff8dbc276dc1fdc95dfef863bce99dd75a380f249251cd3408800c98b1d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.7/residue-v0.0.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "589a22202d8123fd3bb0af6d51c8e8ff47810f6b03c2f697ecb6077093524b4b"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.7/residue-v0.0.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "11ed8b5f6974a5d7e170c74f9747c9a99a2c810120adc63f17a55e297ef648f3"
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
