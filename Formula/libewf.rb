class Libewf < Formula
  desc "Library for support of the Expert Witness Compression Format"
  homepage "https://github.com/libyal/libewf"
  # The main libewf repository is currently "experimental".
  url "https://github.com/libyal/libewf-legacy/releases/download/20140812/libewf-20140812.tar.gz"
  sha256 "be90b7af2a63cc3f15d32ce722a19fbd5bbb0173ce20995ba2b27cc9072d6f25"
  license "LGPL-3.0-or-later"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "a86d3ab0f59dcb04fbf49ce271c79817694b4890a3f041ad297847b26117b968"
    sha256 cellar: :any,                 big_sur:       "01223ea80696527795667054cf517c08160e5beb015ed9d7098639f3786d540c"
    sha256 cellar: :any,                 catalina:      "16f6fe5bc2d8a30f216241ecc70ef23b3122043e4e75992d166fda26dad1463c"
    sha256 cellar: :any,                 mojave:        "5669d19089228d1702a8b6469189d0fff7af625514fcd5a56b08f1f98ff81a33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "54caa34a84e142b5da8c6e26b4783990088afa154cc909b70cd5fb379c84274e" # linuxbrew-core
  end

  head do
    url "https://github.com/libyal/libewf.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "openssl@1.1"

  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  def install
    if build.head?
      system "./synclibs.sh"
      system "./autogen.sh"
    end

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-libfuse=no
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ewfinfo -V")
  end
end
