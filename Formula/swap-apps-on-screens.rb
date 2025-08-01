class SwapAppsOnScreens < Formula
  desc "Swap windows between screens on macOS"
  homepage "https://github.com/time4Wiley/swap-apps-on-screens-mac"
  url "https://github.com/time4Wiley/swap-apps-on-screens-mac/releases/download/v1.0.0/swap-apps-on-screens-mac.zip"
  sha256 "6bfe9452f8d7a8d44101846cc79f0a76aa1875582c1f7c9a6327dea91f5d0a75"
  license "MIT"

  depends_on :macos

  def install
    bin.install "SwapWindows"
    bin.install "SizeUpSwapper"
    bin.install "TopWindowDetector"
    
    # Create convenience symlink
    bin.install_symlink "SizeUpSwapper" => "swap-screens"
  end

  def caveats
    <<~EOS
      This tool requires accessibility permissions to function properly.
      
      On first run, you'll be prompted to grant accessibility permissions:
      1. Open System Settings > Privacy & Security > Accessibility
      2. Add and enable the installed binaries
      
      For SizeUp integration, ensure SizeUp is installed:
      https://www.irradiatedsoftware.com/sizeup/
      
      Usage:
        swap-screens          # Swap windows using SizeUp
        SwapWindows          # Swap windows using native API
        TopWindowDetector    # Diagnostic tool
    EOS
  end

  test do
    # Basic test to ensure binaries execute
    assert_match "Window", shell_output("#{bin}/TopWindowDetector 2>&1", 1)
  end
end