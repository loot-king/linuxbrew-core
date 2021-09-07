class GrinWallet < Formula
  desc "Official wallet for the cryptocurrency Grin"
  homepage "https://grin.mw"
  url "https://github.com/mimblewimble/grin-wallet/archive/v5.0.3.tar.gz"
  sha256 "943eed3d7b5d54298af7de3bfd6a746273dcfc0909f0efc191b4916e80f1ecf3"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "a0dfda70b5c6cf1ed883e5af6b61c01aea7ddf18f6f22038aab71e06b5b9801a"
    sha256 cellar: :any_skip_relocation, catalina:     "4b43f745f1b82d9390cdaf4055c9d65e6bea850fe9ad7ebd2818789c33c45dbc"
    sha256 cellar: :any_skip_relocation, mojave:       "3ce2c42866c3d02c527fac13c2393af01eabb9c9591ef25d5503aca073863f50"
  end

  depends_on "rust" => :build

  uses_from_macos "llvm" => :build # for libclang
  uses_from_macos "openssl@1.1"

  on_linux do
    depends_on "pkg-config" => :build
  end

  # Fix build on Rust 1.53.0+. Remove in the next release.
  # Backport of https://github.com/mimblewimble/grin-wallet/pull/621
  patch :DATA

  def install
    ENV["CLANG_PATH"] = Formula["llvm"].opt_bin/"clang" if OS.linux?
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "yes | #{bin}/grin-wallet init"
    assert_predicate testpath/".grin/main/wallet_data/wallet.seed", :exist?
  end
end

__END__
diff --git a/Cargo.lock b/Cargo.lock
index 78e4c51..e924625 100644
--- a/Cargo.lock
+++ b/Cargo.lock
@@ -1,5 +1,7 @@
 # This file is automatically @generated by Cargo.
 # It is not intended for manual editing.
+version = 3
+
 [[package]]
 name = "addr2line"
 version = "0.13.0"
@@ -218,7 +220,7 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "46254cf2fdcdf1badb5934448c1bcbe046a56537b3987d96c51a7afc5d03f293"
 dependencies = [
  "addr2line",
- "cfg-if",
+ "cfg-if 0.1.10",
  "libc",
  "miniz_oxide",
  "object",
@@ -275,7 +277,7 @@ checksum = "f1c85344eb535a31b62f0af37be84441ba9e7f0f4111eb0530f43d15e513fe57"
 dependencies = [
  "bitflags 1.2.1",
  "cexpr",
- "cfg-if",
+ "cfg-if 0.1.10",
  "clang-sys",
  "clap",
  "env_logger",
@@ -496,6 +498,12 @@ version = "0.1.10"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "4785bdd1c96b2a846b2bd7cc02e86b6b3dbf14e7e53446c4f54c92a361040822"
 
+[[package]]
+name = "cfg-if"
+version = "1.0.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+
 [[package]]
 name = "chacha20poly1305"
 version = "0.4.1"
@@ -590,7 +598,7 @@ version = "1.2.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "ba125de2af0df55319f41944744ad91c71113bf74a4646efff39afe1f6842db1"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
 ]
 
 [[package]]
@@ -633,7 +641,7 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "058ed274caafc1f60c4997b5fc07bf7dc7cca454af7c6e81edffe5f33f70dace"
 dependencies = [
  "autocfg 1.0.0",
- "cfg-if",
+ "cfg-if 0.1.10",
  "crossbeam-utils",
  "lazy_static",
  "maybe-uninit",
@@ -647,7 +655,7 @@ version = "0.2.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "774ba60a54c213d409d5353bda12d49cd68d14e45036a285234c8d6f91f92570"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "crossbeam-utils",
  "maybe-uninit",
 ]
@@ -659,7 +667,7 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "c3c7c73a2d1e9fc0886a08b93e98eb643461230d5f1925e4036204d5f2e261a8"
 dependencies = [
  "autocfg 1.0.0",
- "cfg-if",
+ "cfg-if 0.1.10",
  "lazy_static",
 ]
 
@@ -794,7 +802,7 @@ version = "2.0.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "13aea89a5c93364a98e9b37b2fa237effbb694d5cfe01c5b70941f7eb087d5e3"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "dirs-sys",
 ]
 
@@ -804,7 +812,7 @@ version = "1.0.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "1cbcf9241d9e8d106295bd496bbe2e9cffd5fa098f2a8c9e2bbcbf09773c11a8"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "dirs-sys-next",
 ]
 
@@ -958,7 +966,7 @@ version = "1.0.16"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "68c90b0fc46cf89d227cc78b40e494ff81287a92dd07631e5af0d06fe3cf885e"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "crc32fast",
  "libc",
  "miniz_oxide",
@@ -1138,7 +1146,7 @@ version = "0.1.14"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "7abc8dd8451921606d809ba32e95b6111925cd2906060d2dcc29c070220503eb"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "libc",
  "wasi",
 ]
@@ -1851,13 +1859,13 @@ checksum = "b294d6fa9ee409a054354afc4352b0b9ef7ca222c69b8812cbea9e7d2bf3783f"
 
 [[package]]
 name = "lexical-core"
-version = "0.7.4"
+version = "0.7.6"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "db65c6da02e61f55dae90a0ae427b2a5f6b3e8db09f58d10efab23af92592616"
+checksum = "6607c62aa161d23d17a9072cc5da0be67cdfc89d3afb1e8d9c842bebc2525ffe"
 dependencies = [
  "arrayvec 0.5.1",
  "bitflags 1.2.1",
- "cfg-if",
+ "cfg-if 1.0.0",
  "ryu",
  "static_assertions",
 ]
@@ -1956,7 +1964,7 @@ version = "0.4.11"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "4fabed175da42fed1fa0746b0ea71f412aa9d35e76e95e59b192c64b9dc2bf8b"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "serde",
 ]
 
@@ -2052,7 +2060,7 @@ version = "0.6.22"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "fce347092656428bc8eaf6201042cb551b8d67855af7374542a92a0fbfcac430"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "fuchsia-zircon",
  "fuchsia-zircon-sys",
  "iovec",
@@ -2150,7 +2158,7 @@ version = "0.2.34"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "2ba7c918ac76704fb42afcbbb43891e72731f3dcca3bef2a19786297baf14af7"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "libc",
  "winapi 0.3.9",
 ]
@@ -2163,7 +2171,7 @@ checksum = "50e4785f2c3b7589a0d0c1dd60285e1188adac4006e8abd6dd578e1567027363"
 dependencies = [
  "bitflags 1.2.1",
  "cc",
- "cfg-if",
+ "cfg-if 0.1.10",
  "libc",
  "void",
 ]
@@ -2331,7 +2339,7 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "8d575eff3665419f9b83678ff2815858ad9d11567e082f5ac1814baba4e2bcb4"
 dependencies = [
  "bitflags 1.2.1",
- "cfg-if",
+ "cfg-if 0.1.10",
  "foreign-types",
  "lazy_static",
  "libc",
@@ -2391,7 +2399,7 @@ version = "0.7.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "d58c7c768d4ba344e3e8d72518ac13e259d7c7ade24167003b8488e10b6740a3"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "cloudabi",
  "libc",
  "redox_syscall",
@@ -2621,7 +2629,7 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "999718fa65c3be3a74f3f6dae5a98526ff436ea58a82a574f0de89eecd342bee"
 dependencies = [
  "arrayref",
- "cfg-if",
+ "cfg-if 0.1.10",
 ]
 
 [[package]]
@@ -2978,7 +2986,7 @@ version = "6.2.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "3358c21cbbc1a751892528db4e1de4b7a2b6a73f001e215aaba97d712cfa9777"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "dirs-next",
  "libc",
  "log",
@@ -3253,7 +3261,7 @@ version = "0.3.12"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "03088793f677dce356f3ccc2edb1b314ad191ab702a5de3faf49304f7e104918"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "libc",
  "redox_syscall",
  "winapi 0.3.9",
@@ -3374,7 +3382,7 @@ version = "0.14.15"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "2983daff11a197c7c406b130579bc362177aa54cf2cc1f34d6ac88fccaa6a5e1"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "doc-comment",
  "libc",
  "ntapi",
@@ -3389,7 +3397,7 @@ version = "3.1.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "7a6e24d9338a0a5be79593e2fa15a648add6138caa803e2d5bc782c371732ca9"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "libc",
  "rand 0.7.3",
  "redox_syscall",
@@ -3616,7 +3624,7 @@ version = "0.1.18"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "f0aae59226cf195d8e74d4b34beae1859257efb4e5fed3f147d2dc2c7d372178"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "log",
  "tracing-core",
 ]
@@ -3814,7 +3822,7 @@ version = "0.2.67"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "f0563a9a4b071746dd5aedbc3a28c6fe9be4586fb3fbadb67c400d4f53c6b16c"
 dependencies = [
- "cfg-if",
+ "cfg-if 0.1.10",
  "wasm-bindgen-macro",
 ]
 
