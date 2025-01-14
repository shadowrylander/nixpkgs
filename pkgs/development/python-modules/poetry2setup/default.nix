{ lib
, python3
, fetchFromGitHub
, gawk
}:

python3.pkgs.buildPythonApplication rec {
  pname = "poetry2setup";
  version = "1.0.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "abersheeran";
    repo = pname;
    rev = "6d3345f488fda4d0f6eed1bd3438ea6207e55e3a";
    sha256 = "07z776ikj37whhx7pw1f3pwp25w04aw22vwipjjmvi8c642qxni4";
  };

  propagatedBuildInputs = with python3.pkgs; [ poetry-core ];

  buildInputs = with python3.pkgs; [ poetry-core ];

  installPhase = ''
    mkdir --parents $out/bin
    cp $src/${pname}.py $out/bin/${pname}
    chmod +x $out/bin/${pname}
    ${gawk}/bin/awk -i inplace 'BEGINFILE{print "#!/usr/bin/env python3"}{print}' $out/bin/${pname}
  '';

  postFixup = "wrapProgram $out/bin/${pname} $makeWrapperArgs";

  makeWrapperArgs = [ "--prefix PYTHONPATH : ${placeholder "out"}/lib/${python3.pkgs.python.libPrefix}/site-packages" ];

  meta = with lib; {
    description = "Convert python-poetry(pyproject.toml) to setup.py.";
    homepage = "https://github.com/abersheeran/${pname}";
    license = licenses.mit;
    maintainers = with maintainers; [ sylvorg ];
  };
}
