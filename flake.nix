{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems =
        f:
        nixpkgs.lib.foldl'
          (
            acc: system:
            nixpkgs.lib.recursiveUpdate acc (
              nixpkgs.lib.mapAttrs (_: value: { "${system}" = value; }) (f system)
            )
          )
          { }
          systems;
    in
    forAllSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        cargoLinkerEnv = {
          x86_64-linux = "CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER";
          aarch64-linux = "CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER";
        }.${system};
      in
      {
        devShells = with pkgs; {
          default = mkShell {
            packages = [
              # python
              uv
              # rust
              rustup
              clang
              # node
              nodejs
              typescript
              # go
              go
            ];
            "${cargoLinkerEnv}" = "clang";
          };
        };
      });
}
