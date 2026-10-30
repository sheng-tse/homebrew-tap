class ArgonautsCode < Formula
  desc "Orchestrate any mix of coding agents and models, from Claude Code and Codex to open-weight models on your own machine."
  homepage "https://github.com/sheng-tse/argonauts-code"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sheng-tse/argonauts-code/releases/download/v0.2.0/argonauts-code-aarch64-apple-darwin.tar.xz"
      sha256 "c71da1983ff682948053db0635d228f822ec5c8a82ff77a8a5f1bec1911a2bb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sheng-tse/argonauts-code/releases/download/v0.2.0/argonauts-code-x86_64-apple-darwin.tar.xz"
      sha256 "09e62ea41b826779525c1c817cdc7f8897cb51c96c39f922f9707668b8cc1a88"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sheng-tse/argonauts-code/releases/download/v0.2.0/argonauts-code-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0687d8a187b4f859539a05025ba08f366c941dc3dc1a5ac0d10ce04c700079eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sheng-tse/argonauts-code/releases/download/v0.2.0/argonauts-code-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a45ef016013f61f68dfd05789eaa1a12d6a6e123c19937ecf776805c61b61edb"
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
