if [ $1 ]; then
    if [ $1 = "update" ]; then
        sudo nix-channel --update
        sudo nixos-rebuild switch -I nixos-config=./configuration/configuration.nix --upgrade
    fi
else
    sudo nixos-rebuild switch -I nixos-config=./configuration/configuration.nix
fi

