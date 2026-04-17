# frozen_string_literal: true

class Muxedo < Formula
  desc "Terminal multiplexer TUI with live auto-grid layout from TOML profiles"
  homepage "https://github.com/rikvanderkemp/muxedo"
  version "0.1.16"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_darwin_arm64.tar.gz"
      sha256 "44d0bacef64639e61af9f2209e67cd1ac0cab3d0b9978fe806b9faa75e8469b9"
    else
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_darwin_amd64.tar.gz"
      sha256 "eff2e0a960cb46d3d4e963dd78c01c0f19f4f28c464a8e80bfb9791f015706c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_linux_arm64.tar.gz"
      sha256 "5be065fbff1d4401fc755b3e731b0f4b62935fb967eb8be9d0edba2afb2701a5"
    else
      url "https://github.com/rikvanderkemp/muxedo/releases/download/v#{version}/muxedo_#{version}_linux_amd64.tar.gz"
      sha256 "a4f308119c8d3a03ae7a5b3f3a636adaa6ab95b7a3353e729b4cb7159b0b5e6a"
    end
  end

  def install
    bin.install "muxedo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/muxedo -version")
  end
end
