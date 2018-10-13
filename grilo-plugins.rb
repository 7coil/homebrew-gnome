# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class GriloPlugins < Formula
  desc ""
  homepage ""
  url "https://gitlab.gnome.org/GNOME/grilo-plugins/uploads/cc4a1d49dd65111ad012bb809e6c641e/grilo-plugins-0.3.6.tar.xz"
  sha256 "d9e07ec0aeb1e52270b6a3629c9f040d6f40808834aa3c8e2da90fecb7c31275"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "intltool" => :build
  depends_on "glib"
  depends_on "libmediaart"
  depends_on "lua"
  depends_on "gst-plugins-bad"
  depends_on "grilo"


  def install
    mkdir "build" do
      system "meson", "--prefix=#{prefix}", ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test grilo-plugins`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
