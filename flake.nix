{
  description = ''Nim client for Stripe.com'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."stripe-master".dir   = "master";
  inputs."stripe-master".owner = "nim-nix-pkgs";
  inputs."stripe-master".ref   = "master";
  inputs."stripe-master".repo  = "stripe";
  inputs."stripe-master".type  = "github";
  inputs."stripe-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."stripe-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}