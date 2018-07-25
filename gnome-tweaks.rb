# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class GnomeTweaks < Formula
  desc ""
  homepage ""
  url "https://download.gnome.org/sources/gnome-tweak-tool/3.27/gnome-tweak-tool-3.27.3.tar.xz"
  sha256 "43b77c256bf97e20d2c1c813736a2d9bc684d2c60c126f758e18566caa0f14fd"
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "python@3"
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "libnotify"

  def install
    # Forces use of gtk3-update-icon-cache instead of gtk-update-icon-cache. No bugreport should
    # be filed for this since it only occurs because Homebrew renames gtk+3's gtk-update-icon-cache
    # to gtk3-update-icon-cache in order to avoid a collision between gtk+ and gtk+3.
    inreplace "meson-postinstall.py", "gtk-update-icon-cache", "gtk3-update-icon-cache"
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
    # software. Run the test with `brew test gnome-tweak-tool`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
