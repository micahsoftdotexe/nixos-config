if [ $1 ]; then
    if [ $1 = "update" ]; then
        sudo nix-channel --update
        sudo nixos-rebuild switch -I nixos-config=./configuration/configuration.nix --upgrade
    fi
    if [ $1 = "clean" ]; then
        sudo nix-collect-garbage -d
    fi
else
    sudo nixos-rebuild switch -I nixos-config=./configuration/configuration.nix
fi

