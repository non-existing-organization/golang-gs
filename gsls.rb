class Gsls < Formula
  desc "Get a quick overview of Git repositories with gs, a alternative to ls"
  homepage "https://github.com/non-existing-organization/golang-gsls"
  url "https://github.com/non-existing-organization/golang-gsls/releases/download/v0.2.0/golang-gsls-v0.2.0.tar.gz"
  version "0.2.0"
  sha256 "6276da2b5b646d703ed1c4874720e521401b2fdc74c47991e3be5a061ee76968"
  license "Unlicense"

  def install
    if OS.mac?
      bin.install "gsls_darwin_amd64" => "gsls"
    elsif OS.linux?
      bin.install "gsls_linux_amd64" => "gsls"
    elsif OS.windows?
      bin.install "gsls_windows_amd64.exe" => "gsls.exe"
    end
  end

  test do
    system "#{bin}/gsls"
  end
end
