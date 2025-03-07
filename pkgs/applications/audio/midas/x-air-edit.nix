{
  callPackage,
  curl,
  libGL,

  # Since Behringer/Midas no longer ship the icon in their tarballs (present in v1.8, not v1.8.1), the icon must be manually downloaded, using the icon from Flathub purely as a convenience - this should be a consistent url and hence be a reliable fetch
  icon ? (
    builtins.fetchurl {
      url = "https://dl.flathub.org/media/com/behringer/XAirEdit/ae8f33db1bb473961cc67ae58b82d81f/icons/128x128/com.behringer.XAirEdit.png";
      sha256 = "sha256:1acd2l71a25y11v9f2ld6wcl3rarcibga1lsp6fzmfc8wq2js0fi";
    }
  ),
  ...
}@args:

callPackage ./generic.nix (
  args
  // rec {
    brand = "Behringer";
    type = "X-AIR";
    version = "1.8.1";
    url = "https://mediadl.musictribe.com/download/software/behringer/XAIR/${version}/${type}-Edit_LINUX_${version}.tar.gz";
    sha256 = "sha256-vFy3/iAsGs1IlBSYAX5zTghbPtBfFCUtqVFxfMsFCGY=";
    homepage = "https://www.behringer.com/series.html?category=R-BEHRINGER-XAIRSERIES";

    # In addition to the libraries used by all midas mixer applications, X-AIR-Edit requires the following:
    extraLibs = [
      curl # libcurl.so.4
      libGL # libGL.so.1
    ];
    inherit icon;
  }
)
