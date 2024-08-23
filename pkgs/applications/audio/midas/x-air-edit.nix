{ callPackage, lib, curl, libGL, ... } @ args:

callPackage ./generic.nix (args // rec {
  brand = "Behringer";
  type = "X-AIR";
  version = "1.8.1";
  url = "https://mediadl.musictribe.com/download/software/behringer/XAIR/${version}/${type}-Edit_LINUX_${version}.tar.gz";
  sha256 = "sha256-vFy3/iAsGs1IlBSYAX5zTghbPtBfFCUtqVFxfMsFCGY=";
  homepage = "https://www.behringer.com/series.html?category=R-BEHRINGER-XAIRSERIES";

  # In addition to the libraries used by all midas mixer applications, X-AIR-Edit requires the following:
  extraLibs = [
    curl      # libcurl.so.4
    libGL     # libGL.so.1
  ];
})
