class WasmPack < Formula
  desc "Your favorite rust -> wasm workflow tool!"
  homepage "https://rustwasm.github.io/wasm-pack/"
  url "https://github.com/rustwasm/wasm-pack/archive/v0.10.1.tar.gz"
  sha256 "d8242567e85f4e9f6e8ce4c8a6c56585c2f4aa5f65f3cf92a878515bf75ce686"
  license "Apache-2.0"
  head "https://github.com/rustwasm/wasm-pack.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "56ee4bb666eb8f2e4ceffeb98ec1fa03d9330cde887c8ed41795a40ef7561c2c"
    sha256 cellar: :any_skip_relocation, catalina:     "fbf74ad3f901a30d0c8d503f033893c5f511aecd460a72ef765f0fe1b6d10d06"
    sha256 cellar: :any_skip_relocation, mojave:       "c24a9c03bdae1f6d6d03a73c4d89ab1c7cf2f2a17df1b01a87fb96ae891e23d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6130fc64eff5866aecde67811b901660214b2f3242f1920a7f74b9f593fa0e97" # linuxbrew-core
  end

  depends_on "rust" => :build
  depends_on "rustup-init"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "wasm-pack #{version}", shell_output("#{bin}/wasm-pack --version")

    system "#{Formula["rustup-init"].bin}/rustup-init", "-y", "--no-modify-path"
    ENV.prepend_path "PATH", HOMEBREW_CACHE/"cargo_cache/bin"

    system bin/"wasm-pack", "new", "hello-wasm"
    system bin/"wasm-pack", "build", "hello-wasm"
    assert_predicate testpath/"hello-wasm/pkg/hello_wasm_bg.wasm", :exist?
  end
end
