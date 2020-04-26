{ stdenv, mkDerivationWith, fetchFromGitHub, qtbase, openscenegraph, mygui, bullet, ffmpeg
, boost, cmake, SDL2, unshield, openal, libXt, pkgconfig }:

let
  openscenegraph_ = openscenegraph.overrideDerivation (self: {
    src = fetchFromGitHub {
      owner = "OpenMW";
      repo = "osg";
      rev = "2b4c8e37268e595b82da4b9aadd5507852569b87";
      sha256 = "0admnllxic6dcpic0h100927yw766ab55dix002vvdx36i6994jb";
    };
  });
in mkDerivationWith stdenv.mkDerivation rec {
  version = "2020-04-19";
  pname = "openmw";

  src = fetchFromGitHub {
    owner = "OpenMW";
    repo = "openmw";
    rev = "7ade0cb2c3390a456f8cf607d8da930a75942ae3";
    sha256 = "0pk7s5fvm39yi2481h4z9dscnc9gr3xaqnhaz6fzw9njs6rlhbi5";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ cmake boost ffmpeg bullet mygui openscenegraph_ SDL2 unshield openal libXt qtbase ];

  cmakeFlags = [
    "-DDESIRED_QT_VERSION:INT=5"
  ];

  meta = with stdenv.lib; {
    description = "An unofficial open source engine reimplementation of the game Morrowind";
    homepage = http://openmw.org;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ abbradar ];
  };
}
