class ArgonautsCode < Formula
  desc "Orchestrate any mix of coding agents and models, from Claude Code and Codex to open-weight models on your own machine."
  homepage "https://github.com/sheng-tse/argonauts-code"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sheng-tse/argonauts-code/releases/download/v0.1.0/argonauts-code-aarch64-apple-darwin.tar.xz"
      sha256 "3a5d7c5100820068a6a35c14b455b67217762cdfe4ed3dda181b50174e5d7ec2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sheng-tse/argonauts-code/releases/download/v0.1.0/argonauts-code-x86_64-apple-darwin.tar.xz"
      sha256 "255f2237dd01478638b72e90284d4ef0fa077e8fb17080a9ab876bfeacd88e7f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sheng-tse/argonauts-code/releases/download/v0.1.0/argonauts-code-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "50ef14257ef2ffc6d23b827972ca78ed547b6dd8182b8df4f70079596a4ab955"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sheng-tse/argonauts-code/releases/download/v0.1.0/argonauts-code-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "193001627eeb53c54d2143cb8e22944a96dcd46e3f56bca8ff3e2b9cc287a1db"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "argonauts"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "argonauts"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "argonauts"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "argonauts"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  def caveats
    <<~EOS
      Next: cd into a project and run argonauts. argonauts doctor checks your agent CLIs.
    EOS
  end
end
