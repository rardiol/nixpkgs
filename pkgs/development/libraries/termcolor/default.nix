{ lib, stdenv, cmake, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "termcolor";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "ikalnytskyi";
    repo = "termcolor";
    rev = "v${version}";
    sha256 = "1h25p3j3i9sbq5gr1rwcsjg6wcmnrs2crkn61sxwknj9a7x42j2v";
  };

  buildInputs = [ cmake ];

  cmakeFlags = [ "-DTERMCOLOR_TESTS=ON" ];

  doCheck = true;

  checkPhase = ''
    ./test_termcolor
  '';

  meta = with lib; {
    description = "A header-only C++ library for printing colored messages to the terminal";
    homepage = "https://termcolor.readthedocs.io/";
    license = licenses.bsd3;
    platforms = platforms.all;
    maintainers = with maintainers; [ rardiol ];
  };
}
