{ stdenv, fetchurl, lib, libX11, libXext, alsa-lib, freetype, brand, type, version, homepage, url, sha256, extraMaintainters ? [], extraLibs ? [], ... }:
let
name = "${type}-Edit";
in
stdenv.mkDerivation rec {
  pname = "${lib.toLower name}";
  inherit version;

  src = fetchurl {
    inherit url;
    inherit sha256;
    postFetch = "ls";
  };

  sourceRoot = ".";
  dontBuild = true;
  dontStrip = true;

  installPhase = ''
    ls -a
    mkdir -p $out/bin
    cp ${name} $out/bin/${pname}
    mkdir -p $out/share/icons
    cp ${name}_icon.png $out/share/icons/${lib.toLower name}.png
    mkdir -p $out/share/applications
    cat <<INI > $out/share/applications/${name}.desktop
        [Desktop Entry]
        Terminal=false
        Name=${name}
        Exec=$out/bin/${pname}
        Type=Application
        Icon=${lib.toLower name}
        INI
  '';
  preFixup = let
    # we prepare our library path in the let clause to avoid it become part of the input of mkDerivation
    libPath = lib.makeLibraryPath ([
      libX11           # libX11.so.6
      libXext          # libXext.so.6
      alsa-lib          # libasound.so.2
      freetype         # libfreetype.so.6
      stdenv.cc.cc.lib # libstdc++.so.6
    ] ++ extraLibs      # Extra Libraries required by some packages built from this derivation but not all
    );
  in ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}" \
      $out/bin/${pname}
  '';

  meta = with lib; {
    inherit homepage;
    description = "Editor for the ${brand} ${type} digital mixer";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = (with maintainters; [ magnetophon Green-D-683 ]) ++ extraMaintainters; ## Extra Maintainers for some subpackages
  };
}
