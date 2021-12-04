{ stdenv, lib, fetchFromGitHub, cmake, cxxopts, elfio, termcolor, gtest, binutils, chrpath }:

stdenv.mkDerivation rec {
  pname = "libtree";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "haampie";
    repo = "libtree";
    rev = "v${version}";
    sha256 = "0x3ls1cqra3fz61301hilhdbvql2vb581z026dw8qpr40d9iz7lg";
  };

  cmakeFlags = [ "-DLIBTREE_BUILD_TESTS=ON" ];

  prePatch = ''
    substituteInPlace src/main.cpp \
      --replace "std::string strip = \"strip\";" "std::string strip = \"${binutils.out}/bin/strip\";" \
      --replace "std::string chrpath = \"chrpath\";" "std::string chrpath = \"${chrpath.out}/bin/chrpath\";"
  '';

  doCheck = true;

  buildInputs = [ cmake cxxopts elfio termcolor gtest ];

  meta = with lib; {
    description = "A tool to analyse and bundle shared libraries";
    longDescription = ''
      A tool that:
        turns ldd into a tree
        explains why shared libraries are found and why not
        optionally deploys executables and dependencies into a single directory
    '';
    homepage = "https://github.com/haampie/libtree";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ rardiol ];
  };
}
