# frozen_string_literal: true

class Muxedo < Formula
  desc "Terminal multiplexer TUI with live auto-grid layout from TOML profiles"
  homepage "https://github.com/rikvanderkemp/muxedo"
  version "0.1.17"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_darwin_arm64.tar.gz"
      sha256 "e64886a8ef6018e9f705b1aeaeb95c78cba410e22408a43a8641bc0c189834e5"
    else
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_darwin_amd64.tar.gz"
      sha256 "cc0e2f83b2fdcf3e4f402f51fe4929563fc67156e182cc171551c7c0dfda4319"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_linux_arm64.tar.gz"
      sha256 "4caa0a88bb6a68c40f6d7ed1c23cdf25f70c089498170d891af3e9de508ec2b5"
    else
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_linux_amd64.tar.gz"
      sha256 "e276344b2f61071a41c2ac802b438cb124af34cbb9fae19ba191d5ced9ab7f1d"
    end
  end

  def install
    bin.install "muxedo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/muxedo -version")
  end
end
