class TotemPlParser < Formula
  desc ""
  homepage ""
  url "https://download.gnome.org/sources/totem-pl-parser/3.26/totem-pl-parser-3.26.1.tar.xz"
  sha256 "6ae2c4b8acaf052af21b8db256b6314385de031ba721a2dbdb361e90d4b4b74c"
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "glib"
  depends_on "libquvi"
  depends_on "libarchive"
  depends_on "xz" => "without-xz"
  depends_on "gmime"
  depends_on "gobject-introspection"

  def install
    mkdir "build" do
      system "meson", "--prefix=#{prefix}", ".."

      # Darwin's ld doesn't support --version-script. Nix it.
      inreplace "build.ninja" do |s|
        s.gsub! "-Wl,--version-script,#{buildpath}/plparse/plparser-mini.map", ""
        s.gsub! "-Wl,--version-script,#{buildpath}/plparse/plparser.map", ""

        # Odd issue involving loading of dyld libraries.
        # liblzma.5.dylib, provided by xz as version 8.0.0 and higher,
        # is loaded with the system version, 6.0.0, and libarchive requires 8.x.x+
        # So remove system libraries from build instead.

        # We're safe to do explicitly mention just /usr/lib due to no other
        # build components using this.
        s.gsub! "-L/usr/lib", ""
      end

      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    system "false"
  end
end
