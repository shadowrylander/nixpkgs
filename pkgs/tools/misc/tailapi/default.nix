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
    rev = "ac349ef5d91734e70cc3137cfb747a13564f0f1a";
    sha256 = "1s0zmshgivxwj592kmqxjms380qdi26sbaw83sp5zpqhx2hh9qvc";
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
