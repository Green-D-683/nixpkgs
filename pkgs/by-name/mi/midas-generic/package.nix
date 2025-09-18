{lib, stdenv}:

stdenv.mkDerivation {
  name = "midas-generic";

  meta = with lib; {
    homepage = "https://www.behringer.com/catalog.html?brandName=behringer&catalog=Application&category=C-BEHRINGER-MIXERS-DIGITALMIXERS&application=P-BEHRINGER-LIVEPORTABLESOUND";
    description = "Not actually a package by itself, this contains the common generic arguments used to package Midas Mixer Control Software, such as x32edit, m32edit and xairedit ";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.unfree;
    platforms = [];
    broken = true; # Hide on search.nixos.org - simply a builder for other packages - a 'meta.hidden' option would probably be better here
    maintainers = [
      maintainers.Green-D-683
    ];
  };

}
