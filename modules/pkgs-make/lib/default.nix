nixpkgs:

let

    composed = builtins.foldl' (a: acc: b: a (acc b)) (a: a);
    applying = composed [ composed nixpkgs.lib.reverseList ];
    libExtn = {
        inherit composed applying;
        tarball = nixpkgs.callPackage ./tarball {};
        licenses = nixpkgs.callPackage ./licenses {} nixpkgs;
    };

in

    {
        nix = nixpkgs.lib // libExtn;
        haskell = import ./haskell.nix nixpkgs.haskell.lib;
    }
