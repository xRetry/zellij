{
    description = "Flake for personal zellij config";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils, ... }: {
        overlays.default = import ./overlay.nix;
    } // flake-utils.lib.eachDefaultSystem (system:
	let 

	pkgs = import nixpkgs {
		inherit system;
		overlays = [
			self.overlays.default
		];
	};

	in {
		devShell = pkgs.mkShell {
			packages = (with pkgs; [
				zellij-configured
			]);
		};
	});
}
