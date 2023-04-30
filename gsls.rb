class Gsls < Formula
  desc "Get a quick overview of Git repositories with gs, a alternative to ls"
  homepage "https://github.com/homebrew-non-existing-organization/golang-gsls"
  url "https://github.com/non-existing-organization/homebrew-golang-gsls/releases/download/v0.1.1/golang-gsls-0.1.1.tar.gz"
  version "0.1.1"
  sha256 "7eccf0ccc7981826b3e0360cd74e4a1fc79b79ce18061fba4bc9311cd3c00b12"
  license "Unlicense"

  def install
    if OS.mac?
      bin.install "gs_darwin_amd64" => "gsls"
    elsif OS.linux?
      bin.install "gs_linux_amd64" => "gsls"
    elsif OS.windows?
      bin.install "gs_windows_amd64.exe" => "gsls.exe"
    end
  end

  test do
    system "#{bin}/gsls"
  end
end
