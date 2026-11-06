# residue: release binaries from https://github.com/whiteheap/residue/releases
class Residue < Formula
  desc "Reclaim disk from coding-agent Git worktrees without losing work"
  homepage "https://github.com/whiteheap/residue"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.2/residue-v0.0.2-aarch64-apple-darwin.tar.gz"
      sha256 "5091bd321f5f689cc46e0146dc87584d234a69d6363abc94ada79ec84eb66380"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.2/residue-v0.0.2-x86_64-apple-darwin.tar.gz"
      sha256 "949dc38a8f5c0b42cf78a233a2f2f36643d23f5978cc9ce7fc5bd8f74c0bf39a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.2/residue-v0.0.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "72999412c0cec6149ad2f6f04cca7329a46df7ab97d5e6a7a59b424252b083cd"
    end
    on_intel do
      url "https://github.com/whiteheap/residue/releases/download/v0.0.2/residue-v0.0.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9aac0a60a249d4bdd129cd1615566f2b6439186a6b6bd3b702e989b5aded0930"
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
