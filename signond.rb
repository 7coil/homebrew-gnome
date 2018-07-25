# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Signond < Formula
  desc ""
  homepage ""
  url "https://gitlab.com/accounts-sso/signond/-/archive/VERSION_8.59/signond-VERSION_8.59.tar.gz"
  sha256 "c43ab9307af2b72222a42900952989a4550de67691ab89ffbd6c2b3fcc89fb2d"
  depends_on "qt5"
  depends_on "doxygen" => :build

  def install
    # Override LIBDIR to prevent lib64, which really isn't a thing o nmacOS.
    system "qmake", "PREFIX=#{prefix}", "LIBDIR=#{prefix}/lib"
    # As of Sierra and else, Xcode provides the -lrt functions natively.
    inreplace './src/signond/signond.pro', '-lrt', ""
    system "make", "install"
  end

  test do
    system "false"
  end
end
