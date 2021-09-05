class Parallel < Formula
  desc "Shell command parallelization utility"
  homepage "https://savannah.gnu.org/projects/parallel/"
  url "https://ftp.gnu.org/gnu/parallel/parallel-20210822.tar.bz2"
  mirror "https://ftpmirror.gnu.org/parallel/parallel-20210822.tar.bz2"
  sha256 "781659ed2726ef8eafda7e7da898b2488b0c6d3f9251786d218a5c81b1e83822"
  license "GPL-3.0-or-later"
  version_scheme 1
  head "https://git.savannah.gnu.org/git/parallel.git", branch: "master"

  livecheck do
    url :homepage
    regex(/GNU Parallel v?(\d{6,8}).*? released \[stable\]/i)
  end

  conflicts_with "moreutils", because: "both install a `parallel` executable"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"

    inreplace_files = [
      bin/"parallel",
      doc/"parallel.texi",
      doc/"parallel_design.texi",
      man1/"parallel.1",
      man7/"parallel_design.7",
    ]
    inreplace inreplace_files, "/usr/local", HOMEBREW_PREFIX
  end

  test do
    assert_equal "test\ntest\n",
                 shell_output("#{bin}/parallel --will-cite echo ::: test test")
  end
end
