class GnomeMusic < Formula
  desc ""
  homepage ""
  url "https://download.gnome.org/sources/gnome-music/3.31/gnome-music-3.31.1.tar.xz"
  sha256 "5f953ea1fe2d98ab7d0e7b230fb2eefa8b4c7c1282464a02ff892cb189a0f856"
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "itstool" => :build
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "gobject-introspection"
  depends_on "libdazzle"
  depends_on "libmediaart"
  depends_on "libsoup"
  depends_on "tracker"
  depends_on "spotlightishere/gnome/pygobject3"
  depends_on "grilo"
  depends_on "gst-python"
  depends_on "libnotify"

  def install
    # We're doing these both manually afterwards.
    inreplace "meson.build" do |s|
      s.gsub! "meson.add_postconf_script('meson_post_conf.py')", ""
      s.gsub! "meson.add_install_script('meson_post_install.py')", ""
    end

    mkdir "build" do
      system "meson", "--prefix=#{prefix}", ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  def post_install
      system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
      system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "-f", "-t", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    system "false"
  end
end
