{ channels, stylix, ... }:

final: prev:
{
    inherit (stylix.nixosModules.stylix) stylix;
}