if [ $1 ]; then
    if [ $1 = "update" ]; then
        sudo nixos-rebuild switch -I nixos-config=./configuration/configuration.nix --upgrade
    fi
else
    sudo nixos-rebuild switch -I nixos-config=./configuration/configuration.nix
fi

