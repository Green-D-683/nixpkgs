{ callPackage }@args:

callPackage ../../mi/midas-generic/generic.nix (
  args
  // rec {
    brand = "Behringer";
    type = "X-AIR";
    version = "1.8.1";
    url = "https://cdn.mediavalet.com/aunsw/musictribe/VX4UkGFjQ0a1DH2Q8zg3sg/_KJ6tGIG7kGVqPxP-OsnLQ/Original/${type}-Edit_LINUX_${version}.tar.gz";
    hash = "sha256-vFy3/iAsGs1IlBSYAX5zTghbPtBfFCUtqVFxfMsFCGY=";
    homepage = "https://www.behringer.com/series.html?category=R-BEHRINGER-XAIRSERIES";
    deps = [ "libgl1" ];
  }
)
