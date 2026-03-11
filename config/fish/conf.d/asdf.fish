# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Mind that this might potentially change the order of PATH items,
# however it's required to make the ASDF work with VS Code as Code config env is overridden by the copilot
# and makes VS Code to prepend the /usr/bin prior the $_asdf_shims which causes asdf to not find the binaries
# if there are system binaries (like OSX ruby 2.6)
fish_add_path --move --prepend $_asdf_shims
set --erase _asdf_shims

# completions
asdf completion fish > ~/.config/fish/completions/asdf.fish
