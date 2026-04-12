# frozen_string_literal: true

class Muxedo < Formula
  desc "Terminal multiplexer TUI with live auto-grid layout from TOML profiles"
  homepage "https://github.com/rikvanderkemp/muxedo"
  version "0.1.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_darwin_arm64.tar.gz"
      sha256 "19b8323605d38c11b3b6545492b99b9a968b6134224c6acf2c70940590f3d9eb"
    else
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_darwin_amd64.tar.gz"
      sha256 "a90085c10f03ea05b6523432f348b28368d951ff9f369550289b1a0d76e1a4ae"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_linux_arm64.tar.gz"
      sha256 "70d64081e29ac63073640af7e81f73dddafda5034c44668d8353ee3720bb36eb"
    else
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_linux_amd64.tar.gz"
      sha256 "5c0869cb0bbb0abdb0648588bf9b618b5a14c8434dae451370ec162090bd06c9"
    end
  end

  def install
    bin.install "muxedo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/muxedo -version")
  end
end
