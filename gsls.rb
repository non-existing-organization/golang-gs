class Gsls < Formula
  desc "Get a quick overview of Git repositories with gs, a alternative to ls"
  homepage "https://github.com/non-existing-organization/golang-gsls"
  url "https://github.com/non-existing-organization/golang-gsls/releases/download/v0.3.0/golang-gsls-v0.3.0.tar.gz"
  version "0.3.0"
  sha256 "6cbb85b4c2184d7368364408f9591d574da123bc741b700cf311acbe72c1a96c"
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
