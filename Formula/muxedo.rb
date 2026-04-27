# frozen_string_literal: true

class Muxedo < Formula
  desc "Terminal multiplexer TUI with live auto-grid layout from TOML profiles"
  homepage "https://github.com/rikvanderkemp/muxedo"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_darwin_arm64.tar.gz"
      sha256 "2aa67c6ad7b9d485b1c3b3aa590cbdacf1e0e1fbb12d96d5b7196177995573e6"
    else
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_darwin_amd64.tar.gz"
      sha256 "039c5079eb68582f44f0b9db4b5e3e47c7b0ab9c1d0a90924fe2e7ab5b9b66ae"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_linux_arm64.tar.gz"
      sha256 "46385e00ffa4a5eb50931fc7b3aff8b75f36812f2df30a477de68377a2a2c707"
    else
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_linux_amd64.tar.gz"
      sha256 "3420b7a1f8d5403ecbb1c2d4e432f259399f16f622b02b6c6ad6e4b44af5e12f"
    end
  end

  def install
    bin.install "muxedo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/muxedo -version")
  end
end
