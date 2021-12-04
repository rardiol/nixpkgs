{ lib, stdenv, cmake, fetchFromGitHub, boost }:

stdenv.mkDerivation rec {
  pname = "elfio";
  version = "3.9";

  src = fetchFromGitHub {
    owner = "serge1";
    repo = "ELFIO";
    rev = "Release_${version}";
    sha256 = "13lswi8q7qphps0hq7lbal9cgfkar7lijkzdvilymkapfsf4mvz4";
  };

  buildInputs = [ boost cmake ];

  cmakeFlags = [ "-DELFIO_BUILD_TESTS=ON" ];

  doCheck = true;

  meta = with lib; {
    description = "A header-only C++ library intended for reading and generating
files in the ELF binary format";
    homepage = "http://elfio.sourceforge.net/";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ rardiol ];
  };
}
