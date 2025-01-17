{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/8b27c12";
    nixpkgs-ruby.url = "github:bobvanderlinden/nixpkgs-ruby";
  };

  outputs = { self, flake-utils, nixpkgs, nixpkgs-ruby }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          nixpkgs-ruby.overlays.default
          (self: super: {
            ruby = pkgs.${nixpkgs.lib.fileContents ./.ruby-version};
          })
        ];
        pkgs = import nixpkgs { inherit system overlays; };
        # gems = pkgs.bundlerEnv {
        #   name = "your-package";
        #   ruby = pkgs.ruby;
        #   gemdir = ./.;
        # };
      in
      {
        devShells.default = with pkgs; mkShellNoCC {
          buildInputs = [
            # gems
            ruby
            redis
            postgresql
            nodejs_22
            bundix
          ];

          shellHook = ''
            mkdir -p $PWD/tmp/data
            export PGDATA=$PWD/tmp/data

            initdb -D $PWD/tmp/data

            export GEM_HOME=$PWD/tmp/gems

            export PATH="$GEM_HOME/bin:$PATH"
            ruby --version

            bundle install
          '';
        };
      });
}
