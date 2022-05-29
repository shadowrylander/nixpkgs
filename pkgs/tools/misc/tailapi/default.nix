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
    rev = "c5f43527bbd685418a4f971bfa05127f4fc5d6b1";
    sha256 = "13k4r2ywfl84ygr58y3v022hgky5g344f0pkjvvxq9xg6wfb93dq";
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
