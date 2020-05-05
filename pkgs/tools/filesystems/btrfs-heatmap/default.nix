{ stdenv, lib
, fetchFromGitHub
, python3Packages
, python3
}:

stdenv.mkDerivation rec {
  pname = "btrfs-heatmap";
  # -1 because the debian branch has the man page
  version = "8-1";

  src = fetchFromGitHub {
    owner = "knorrie";
    repo = "btrfs-heatmap";
    rev = "debian/8-1_bpo9+1";
    sha256 = "066bxlm02q5183cshvf8s5psf5b312mx0l4gffn49vwpfkap8fgn";
  };

  buildInputs = [ python3 ];
  nativeBuildInputs = [ python3Packages.wrapPython ];

  installPhase = ''
    install -Dm 0755 heatmap.py $out/sbin/btrfs-heatmap
    install -D debian/man/btrfs-heatmap.8 $out/share/man/man8/btrfs-heatmap.8

    buildPythonPath ${python3Packages.btrfs}
    patchPythonScript $out/sbin/btrfs-heatmap
  '';

  meta = with lib; {
    description = "Visualize the layout of a mounted btrfs";
    homepage = "https://github.com/knorrie/btrfs-heatmap";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [ maintainers.evils ];
  };
}
