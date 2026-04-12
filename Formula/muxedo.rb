# frozen_string_literal: true

class Muxedo < Formula
  desc "Terminal multiplexer TUI with live auto-grid layout from TOML profiles"
  homepage "https://github.com/rikvanderkemp/muxedo"
  version "0.1.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_darwin_arm64.tar.gz"
      sha256 "a7561c76d9c58b7ff1bb14eb25b8e6ee9e2e392c1702d31c75ff57dd01333bd9"
    else
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_darwin_amd64.tar.gz"
      sha256 "2c01a8ee09b88ef0f52eeae283af7443cbffd0f03f1394ad0a955f3fb7dcc7bf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_linux_arm64.tar.gz"
      sha256 "9a86c573c30ac5ccb6712abb3ea86c78749111cbc83d73e5e8bab607c7f9aa36"
    else
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_linux_amd64.tar.gz"
      sha256 "70b289feb81c33e26d0cce63ed9ad39b043aa9da09d6a28ea3435b1ecd3c1bba"
    end
  end

  def install
    bin.install "muxedo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/muxedo -version")
  end
end
