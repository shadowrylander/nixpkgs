{ lib
, python39Packages
, hyDefinedPythonPackages /* Packages like with python.withPackages */
, ...
}:
python39Packages.buildPythonApplication rec {
  pname = "hy";
  version = "1.0a4";

  src = python39Packages.fetchPypi {
    inherit pname version;
    sha256 = "sha256-9RTkXxtxEn+I7Q8jNnVpgya4WjuyBKP52a+rVZvz77k=";
  };

  checkInputs = with python39Packages; [ flake8 pytest ];

  propagatedBuildInputs = with python39Packages; [
    appdirs
    astor
    clint
    colorama
    fastentrypoints
    funcparserlib
    rply
    pygments
  ] ++ (hyDefinedPythonPackages python39Packages);

  # Hy does not include tests in the source distribution from PyPI, so only test executable.
  checkPhase = ''
    $out/bin/hy --help > /dev/null
  '';

  meta = with lib; {
    description = "A LISP dialect embedded in Python";
    homepage = "https://hylang.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ sylvorg ];
    platforms = platforms.all;
  };
}
