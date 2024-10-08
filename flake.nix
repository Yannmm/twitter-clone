{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

        restart_db = pkgs.writeScriptBin "restart_db" ''
          if pgrep "postgres" >/dev/null; then
            pg_ctl stop
          fi

          pg_ctl -D $PGDATA -o '-k $PGHOST' start
        '';

        prepare_local_data = pkgs.writeScriptBin "prepare_local_data" ''
          rake db:create
          rake db:migrate
          rails jobs:work &
        '';

        kill_services = pkgs.writeScriptBin "kill_services" ''
          # kill psql
          kill -9 $(lsof -i :$PGPORT -t)
        '';
      in
      {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            ruby
            redis
            postgresql
            restart_db
            prepare_local_data
          ];

          shellHook = ''
            mkdir -p $PWD/tmp/data
            export PGDATA=$PWD/tmp/data
            export PGHOST=$PWD/tmp/data
            export PGPORT=5433

            initdb -D $PWD/tmp/data

            export GEM_HOME=$PWD/tmp/gems

            export PATH="$GEM_HOME/bin:$PATH"
            ruby --version

            bundle install
          '';
        };
      });
}
