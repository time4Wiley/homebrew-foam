class FoamJekyllSetup < Formula
  desc "Setup Jekyll with Just the Docs theme for Foam knowledge bases"
  homepage "https://github.com/time4Wiley/foam-jekyll-setup"
  url "https://github.com/time4Wiley/foam-jekyll-setup/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "bfb58906cfc43446502ade74c391f6e29801f6e964e2fb74b02356b9f7cca87f"
  license "MIT"
  
  def install
    # Install the main script
    bin.install "setup-jekyll-foam.sh" => "foam-jekyll-setup"
    
    # Install the shell function wrapper
    (share/"foam-jekyll-setup").install "foam-jekyll.sh"
    
    # Create wrapper scripts for the aliases
    (bin/"foam-jekyll").write <<~EOS
      #!/bin/bash
      if [ $# -eq 0 ]; then
        exec "#{bin}/foam-jekyll-setup" "$(pwd)"
      elif [ "$1" == "--uninstall" ] && [ $# -eq 1 ]; then
        exec "#{bin}/foam-jekyll-setup" --uninstall "$(pwd)"
      else
        exec "#{bin}/foam-jekyll-setup" "$@"
      fi
    EOS
    
    (bin/"fj").write <<~EOS
      #!/bin/bash
      if [ $# -eq 0 ]; then
        exec "#{bin}/foam-jekyll-setup" "$(pwd)"
      elif [ "$1" == "--uninstall" ] && [ $# -eq 1 ]; then
        exec "#{bin}/foam-jekyll-setup" --uninstall "$(pwd)"
      else
        exec "#{bin}/foam-jekyll-setup" "$@"
      fi
    EOS
    
    # Make wrapper scripts executable
    chmod 0755, bin/"foam-jekyll"
    chmod 0755, bin/"fj"
  end
  
  def caveats
    <<~EOS
      foam-jekyll-setup has been installed!
      
      You can now use any of these commands:
        foam-jekyll-setup /path/to/repo
        foam-jekyll /path/to/repo
        fj /path/to/repo
      
      Or run in the current directory:
        foam-jekyll
        fj
      
      To uninstall Jekyll setup:
        foam-jekyll --uninstall
        fj --uninstall /path/to/repo
      
      To use the shell function (optional), add this to your ~/.zshrc or ~/.bashrc:
        source #{share}/foam-jekyll-setup/foam-jekyll.sh
    EOS
  end
  
  test do
    # Test that the script exists and is executable
    assert_predicate bin/"foam-jekyll-setup", :exist?
    assert_predicate bin/"foam-jekyll-setup", :executable?
    assert_predicate bin/"foam-jekyll", :exist?
    assert_predicate bin/"foam-jekyll", :executable?
    assert_predicate bin/"fj", :exist?
    assert_predicate bin/"fj", :executable?
  end
end