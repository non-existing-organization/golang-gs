class Gsls < Formula
  desc "Get a quick overview of Git repositories with gs, a alternative to ls"
  homepage "https://github.com/non-existing-organization/golang-gsls"
  url "https://github.com/non-existing-organization/golang-gsls/releases/download/v0.3.0/golang-gsls-v0.3.0.tar.gz"
  version "0.3.0"
  sha256 "db07c6c778c223853c5b15fa97fdb2817799dfa8b747c241ca131c72266e75cd"
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
