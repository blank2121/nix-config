{ ... }:
{
    imports = [
        ./audio
        ./boot
        ./bluetooth
        ./networking
        ./nix
        ./printer
        ./timeZone
        # TODO: add encryption, aka password-store and gpg initialization
    ];
}
