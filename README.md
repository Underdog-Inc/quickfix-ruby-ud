# QuickFIX Ruby

This repo builds the quickfix_ruby_ud gem and precompiles native extensions for `aarch64-linux` and `x86_64-linux` 
platforms.

# Creating a new version

1. Increment the version number in `quickfix_ruby_ud.gemspec`.
2. Update the date in `quickfix_ruby_ud.gemspec`.
3. run `./package.sh` to build the gem for each target platform.

That script will automatically push the new gem version to RubyGems, so it assumes you have write access.

# Updating the quickfix source

Running `./generate_source_files.sh` will pull down the UD Quickfix fork and build that repo. This is needed to run 
codegen for the native extensions. If you want to update those source files, first update the `master` branch of the
fork here: https://github.com/Underdog-Inc/quickfix before running this script.

Once complete, commit the modified source files to this repo, then proceed with generating a new gem version.
