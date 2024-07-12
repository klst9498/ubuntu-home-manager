#!/usr/bin/env bash
set -e
pushd ~/.config/home-manager
alejandra .
git diff -U0 *.nix
echo "Rebuilding ... "
home-manager switch 8>hm-switch.log || (
cat hm-switch.log | grep —color error false)
gen=$(home-manager generations)
git commit -am "$gen"
popd

