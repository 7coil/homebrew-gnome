# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Grilo < Formula
  desc ""
  homepage ""
  url "https://download.gnome.org/sources/grilo/0.3/grilo-0.3.5.tar.xz"
  sha256 "49ffc8854ef25b4f038bbbcf734ea060a8dc681fdff5ec5e9a1cbaa002fc373a"
  revision 3

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "intltool" => :build
  depends_on "glib"
  depends_on "libsoup"
  depends_on "totem-pl-parser"
  depends_on "gtk+3"

  def install
    mkdir "build" do
      system "meson", "--prefix=#{prefix}", ".."

      inreplace "build.ninja" do |s|
        s.gsub! "--no-undefined", ""
        # Odd issue involving loading of dyld libraries.
        # liblzma.5.dylib, provided by xz as version 8.0.0 and higher,
        # is loaded with the system version, 6.0.0, and libarchive requires 8.x.x+
        # So remove system libraries from build instead.

        # We're safe to do explicitly mention just /usr/lib due to no other
        # build components using this.
        s.gsub! "-L/usr/lib", ""

        # rpath just won't work for typelibs.
        s.gsub! "@rpath", "#{prefix}/lib"
      end

      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test grilo`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
