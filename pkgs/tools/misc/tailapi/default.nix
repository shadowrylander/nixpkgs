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
    rev = "09256a9645d7f02d0b4c6b526c42cae2d4b177fd";
    sha256 = "18fgfqhrcs6yyqrm67y6wlj413sgkslizkk8q4cjchahzdy8ihhb";
  };

  propagatedBuildInputs = with python310.pkgs; [
    oreo
    requests
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    chmod +x tailapi.py
    patchShebangs tailapi.py
    cp tailapi.py $out/bin/tailapi
  '';

  postInstall = ''
    wrapProgram $out/bin/tailapi $makeWrapperArgs
  '';

  makeWrapperArgs = [
    # "--prefix" "PATH" ":" (lib.makeBinPath [ dbus signal-cli xclip ])
    "--prefix PYTHONPATH : ${placeholder "out"}/lib/${python310.pkgs.python.libPrefix}/site-packages"
  ];

  meta = with lib; {
    # description = "";
    homepage = "https://github.com/syvlorg/tailapi";
    license = licenses.oreo;
    maintainers = with maintainers; [ syvlorg ];
  };
}
