#!/bin/bash

if test -d "/opt/homebrew/bin/"; then
  PATH="/opt/homebrew/bin/:${PATH}"
fi

# Checks if swiftlint has been installed, displaying an error in Xcode if it's missing.

if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://stash.sd.apple.com/projects/DP/repos/swiftlint_distribution"
fi
