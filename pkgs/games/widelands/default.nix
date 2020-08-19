{ stdenv, fetchurl, cmake, python, gettext
, boost, libpng, zlib, glew, lua, doxygen, icu
, SDL2, SDL2_image, SDL2_mixer, SDL2_net, SDL2_ttf
}:

stdenv.mkDerivation rec {
  pname = "widelands";
  version = "21";

  meta = with stdenv.lib; {
    description = "RTS with multiple-goods economy";
    homepage    = "http://widelands.org/";
    longDescription = ''
      Widelands is a real time strategy game based on "The Settlers" and "The
      Settlers II". It has a single player campaign mode, as well as a networked
      multiplayer mode.
    '';
    license        = licenses.gpl2Plus;
    platforms      = platforms.linux;
    maintainers    = with maintainers; [ raskin jcumming ];
    hydraPlatforms = [];
  };

  patches = [
    ./bincmake.patch
  ];

  src = fetchurl {
    url = "https://launchpad.net/widelands/build${version}/build${version}/+download/widelands-build${version}-source.tar.gz";
    sha256 = "0mz3jily0w1zxxqbnkqrp6hl88xhrwzbil9crq7gpcwidx60w7k0";
  };

  preConfigure = ''
    cmakeFlags="
      -DWL_INSTALL_BASEDIR=$out/share/widelands
      -DWL_INSTALL_BINARY=$out/bin
      -DWL_INSTALL_DATADIR=$out/share/widelands
      -DWL_INSTALL_PREFIX=$out
      -DUSE_XDG=ON
      -DOPTION_USE_GLBINDING:BOOL=OFF
      -DOPTION_ASAN=OFF
      -DCMAKE_BUILD_TYPE=Release
    "
  '';

  nativeBuildInputs = [ cmake python gettext ];

  buildInputs = [
    boost libpng zlib glew lua doxygen icu
    SDL2 SDL2_image SDL2_mixer SDL2_net SDL2_ttf
  ];

  enableParallelBuilding = true;
}
