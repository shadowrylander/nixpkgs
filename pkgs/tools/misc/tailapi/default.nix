{ lib
, python310
, fetchFromGitHub
}:

python310.pkgs.buildPythonApplication rec {
  pname = "tailapi";
  version = "1.0.0.0";

  src = fetchFromGitHub {
    owner = "syvlorg";
    repo = pname;
    rev = "ada101b9c2919cfbe365c7d5fe71710d95425ca3";
    sha256 = "0bywlkbwxsnf11i1kv36ls2yax0pp30qmgcyfq3gcmzzhcgk2q3k";
  };

  propagatedBuildInputs = with python310.pkgs; [
    oreo
    requests
  ];

  installPhase = ''
    mkdir --parents $out/bin
    cp $src/${pname}.py $out/bin/${pname}
    chmod +x $out/bin/${pname}
  '';

  postFixup = "wrapProgram $out/bin/${pname} $makeWrapperArgs";

  makeWrapperArgs = [
    # "--prefix" "PATH" ":" (lib.makeBinPath [ git ])
    "--prefix PYTHONPATH : ${placeholder "out"}/lib/${python310.pkgs.python.libPrefix}/site-packages"
  ];

  meta = with lib; {
    # description = "";
    homepage = "https://github.com/syvlorg/${pname}";
    license = licenses.oreo;
    maintainers = with maintainers; [ syvlorg ];
  };
}
