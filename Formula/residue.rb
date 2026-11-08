# residue: release binaries from https://github.com/whiteheap/residue-cli/releases
class Residue < Formula
  desc "Reclaim disk from coding-agent Git worktrees without losing work"
  homepage "https://residue.whiteheap.com"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.10/residue-v0.0.10-aarch64-apple-darwin.tar.gz"
      sha256 "271a70f5b161561e0800a8a11611bea829c850fb8c1a1dc14e98f67d05a698da"
    end
    on_intel do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.10/residue-v0.0.10-x86_64-apple-darwin.tar.gz"
      sha256 "f6a29012c53bf5ab52dd0b94dff5e33ae39b0ae7d38bd6e36bd7f62859ecc258"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.10/residue-v0.0.10-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d5046fb57c8b85ff2ef0c4e648b36c37652d4bbc1d72648ae3476a5827d5d7be"
    end
    on_intel do
      url "https://github.com/whiteheap/residue-cli/releases/download/v0.0.10/residue-v0.0.10-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fc97ec5adc64c76991d46bcb5918329ddbfa843541f76cb2e036c4af8b503830"
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
      https://github.com/whiteheap/residue-cli#automate-cleanup
    EOS
  end

  test do
    assert_match "residue #{version}", shell_output("#{bin}/residue --version")
  end
end
