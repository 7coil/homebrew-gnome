# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class EvolutionDataServer < Formula
  desc ""
  homepage ""
  url "https://download.gnome.org/sources/evolution-data-server/3.29/evolution-data-server-3.29.4.tar.xz"
  sha256 "71a5777e53be025d1b198f54a3448a0b045de13e0d8a8b3a9540bc25329a8207"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libical"
  depends_on "nspr"
  depends_on "krb5"
  depends_on "nss"
  depends_on "libaccounts-glib"
  depends_on "libsignon-glib"
  depends_on "libsecret"
  depends_on "db"
  depends_on "libgweather"
  depends_on "libcanberra"
  depends_on "libgdata"
  depends_on "gcr"
  depends_on "gnome-online-accounts"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    mkdir "build" do
      ENV.prepend_path "PKG_CONFIG_PATH", "#{Formula["nss"].opt_prefix}/lib/pkgconfig"
      system "cmake",
      # Would require full gcr, which we can't due because of X11
      "-DENABLE_GTK=OFF",
      # Requires WebKitGTK2
      "-DENABLE_OAUTH2=OFF",
      # https://github.com/Homebrew/homebrew-core/issues/30476
      "-DENABLE_CANBERRA=OFF",
      *std_cmake_args, ".."
      system "make", "install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test evolution-data-server`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
