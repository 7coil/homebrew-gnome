# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Gcr < Formula
  desc ""
  homepage ""
  url "https://download.gnome.org/sources/gcr/3.28/gcr-3.28.0.tar.xz"
  sha256 "15e175d1da7ec486d59749ba34906241c442898118ce224a7b70bf2e849faf0b"
  depends_on "intltool"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "pango"
  depends_on "p11-kit"
  depends_on "libgcrypt"
  depends_on "gdk-pixbuf"
  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  patch :DATA

  def install
    # Remove X11 dependency
    inreplace 'configure.ac' do |s|
      s.gsub! ' gtk+-x11-3.0 >= $GTK_REQ', ""
    end

    system "autoreconf", "-fi"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
                          "--disable-schemas-compile"

    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "-f", "-t", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test gcr`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
