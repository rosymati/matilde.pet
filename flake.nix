{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      eachSystem = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      devShells = eachSystem (
        system:
        let
          pkgs = import nixpkgs { inherit system; };

          version = "12.3.1";

          pnpmSrc =
            {
              x86_64-linux = {
                npmPkg = "linux-x64";
                hash = "sha256-JbjO7qu6oxreMgIOGZcVR7QCoILRUE+v8a3k+1HtxTk=";
              };
              aarch64-linux = {
                npmPkg = "linux-arm64";
                hash = "sha256-pvn+IPdjKb6dJAz3ep8XVGrM7NYvT22brV9Gj8ChJIM=";
              };
            }
            .${system} or (throw "no pnpm binary mapping for ${system}");

          pnpm = pkgs.stdenv.mkDerivation {
            pname = "pnpm";
            inherit version;

            src = pkgs.fetchzip {
              url = "https://registry.npmjs.org/@pnpm/exe.${pnpmSrc.npmPkg}/-/exe.${pnpmSrc.npmPkg}-${version}.tgz";
              hash = pnpmSrc.hash;
            };

            dontConfigure = true;
            dontBuild = true;

            nativeBuildInputs = [ pkgs.autoPatchelfHook ];
            buildInputs = [ pkgs.stdenv.cc.cc.lib ];

            installPhase = ''
              mkdir -p $out/bin
              install -m755 pnpm $out/bin/pnpm
            '';
          };

        in
        {
          default = pkgs.mkShell {
            packages = [
              pnpm
            ];
          };
        }
      );
    };
}
