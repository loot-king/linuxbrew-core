class Serve < Formula
  desc "Static http server anywhere you need one"
  homepage "https://github.com/syntaqx/serve"
  url "https://github.com/syntaqx/serve/archive/v0.5.0.tar.gz"
  sha256 "fab576aa29b14dcfc45ba6e0e7e6b5284a83e873b75992399b3f5ef8d415d6ae"
  license "MIT"
  head "https://github.com/syntaqx/serve.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "99f115fe9c19d946db2604146c1bc1f1b85b5d2bb840951f0d105e031e4b0f0d"
    sha256 cellar: :any_skip_relocation, big_sur:       "b56e69171f148421442997d819297a608316565d3664d04b771f1c7b67f8c4fa"
    sha256 cellar: :any_skip_relocation, catalina:      "b6358efb493acb673bf7513a252f9f48e9ebb2c6a7824208d89ae631cfad9439"
    sha256 cellar: :any_skip_relocation, mojave:        "9521fba08dd7bcfd843464b3c12a4f841007f28052104072768e052c194de6aa"
    sha256 cellar: :any_skip_relocation, high_sierra:   "0735a5f8002970bc5d1cb1ca68681713de9dfcffc7eeb30bcdcb7fc33bc58551"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "26a725409826cf578d5a33942786175a359da5ba43163e6a34cabe0670b6375c" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=#{version}", *std_go_args, "./cmd/serve"
  end

  test do
    port = free_port
    pid = fork do
      exec "#{bin}/serve -port #{port}"
    end
    sleep 1
    output = shell_output("curl -sI http://localhost:#{port}")
    assert_match(/200 OK/m, output)
  ensure
    Process.kill("HUP", pid)
  end
end
