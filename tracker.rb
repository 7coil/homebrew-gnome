# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Tracker < Formula
  desc ""
  homepage ""
  url "https://ftp.gnome.org/pub/GNOME/sources/tracker/2.1/tracker-2.1.0.tar.xz"
  sha256 "ac55db4368acf877a2d897e262b8ff0de7cc37eedd18918981eaab6182bd06fb"
  depends_on "pkg-config" => :build
  depends_on "meson" => :build
  depends_on "vala" => :build
  depends_on "ninja" => :build
  depends_on "intltool" => :build
  depends_on "dbus"
  depends_on "json-glib"
  depends_on "gobject-introspection"
  depends_on "libsoup"
  depends_on "ossp-uuid"
  depends_on "python@2"
  depends_on "python@3"

  def install
    inreplace "./utils/data-generators/cc/generate",
    "/usr/bin/python2",
    Formula["python@2"].opt_bin/"python2"

    mkdir "build" do
      system "meson", "-Dprefix=#{prefix}",
      "-Ddbus_services=#{prefix}/share/dbus-1/services", "-Ddocs=false", ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    system "false"
  end
end
