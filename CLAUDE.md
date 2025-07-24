# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Homebrew tap repository that provides Foam-related tools. The tap name is `time4wiley/foam`.

## Key Commands

### Testing Formula Changes
```bash
# Test the formula syntax
brew audit --new-formula Formula/foam-jekyll-setup.rb

# Test installation locally
brew install --build-from-source ./Formula/foam-jekyll-setup.rb

# Run formula tests
brew test foam-jekyll-setup
```

### Publishing Changes
```bash
# After making changes to formulas, update the SHA256 hash if URL changed
brew fetch --formula Formula/foam-jekyll-setup.rb

# Verify the tap works
brew tap time4wiley/foam
brew install foam-jekyll-setup
```

## Architecture

### Homebrew Formula Structure
- Formulas are Ruby files in the `Formula/` directory
- Each formula class inherits from `Formula`
- Key methods:
  - `install`: Defines installation steps
  - `caveats`: Post-install messages for users
  - `test`: Automated tests for the formula

### foam-jekyll-setup Formula
- Downloads from GitHub releases with specific version tags
- Installs main script as `foam-jekyll-setup`
- Creates convenience aliases: `foam-jekyll` and `fj`
- Includes shell function wrapper for optional sourcing
- Wrapper scripts handle both explicit directory arguments and current directory defaults

## Development Guidelines

### Adding New Formulas
1. Create new `.rb` file in `Formula/` directory
2. Follow Homebrew formula conventions
3. Include proper `desc`, `homepage`, `url`, `sha256`, and `license`
4. Test locally before committing

### Updating Existing Formulas
1. Update the `url` to new version tag
2. Update `sha256` hash using `brew fetch --formula`
3. Test installation and functionality
4. Update any affected wrapper scripts or installation logic