class Gsls < Formula
  desc "Get a quick overview of Git repositories with gs, a alternative to ls"
  homepage "https://github.com/non-existing-organization/golang-gsls"
  url "https://github.com/non-existing-organization/golang-gsls/releases/download/v0.1.2/golang-gsls-0.1.2.tar.gz"
  version "0.1.2"
  sha256 "a2e5a8226f731064bdeec006538fb376090136ba285a2e25bce81d829e3a22af"
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
