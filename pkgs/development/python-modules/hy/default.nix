{ lib
, pythonOlder
, buildPythonPackage
, fetchPypi
, astor
, colorama
, funcparserlib
, rply
}:

buildPythonPackage rec {
  pname = "hy";
  version = "1.0a4";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-9RTkXxtxEn+I7Q8jNnVpgya4WjuyBKP52a+rVZvz77k=";
  };

  propagatedBuildInputs = [
    colorama
    funcparserlib
    rply
  ] ++ lib.optionals (pythonOlder "3.9") [
    astor
  ];

  doCheck = false;

  pythonImportsCheck = [ "hy" ];

  meta = with lib; {
    description = "Python to/from Lisp layer";
    homepage = "https://github.com/hylang/hy";
    license = licenses.mit;
    maintainers = with maintainers; [ sylvorg ];
  };
}
