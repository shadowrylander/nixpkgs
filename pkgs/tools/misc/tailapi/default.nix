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

  dontBuild = true;

  installPhase = ''
    mkdir --parents $out/bin
    cp $src/tailapi.py $out/bin/tailapi
    chmod +x $out/bin/tailapi
    patchShebangs $out/bin/tailapi
  '';

  postInstall = ''
    wrapProgram $out/bin/tailapi $makeWrapperArgs
  '';

  # Adapted From: https://gist.github.com/CMCDragonkai/9b65cbb1989913555c203f4fa9c23374
  # postFixup = ''
  #     wrapProgram $out/bin/soft --set PATH ${lib.makeBinPath [ git ]}
  # '';

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
