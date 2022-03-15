{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, astor
, colorama
, funcparserlib
, rply
}:

buildPythonPackage rec {
  pname = "hy";
  version = "1.0a4";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "hylang";
    repo = pname;
    rev = version;
    sha256 = "0l8gl4w19qw7bina0fdfs61rikqx30375w3xvc3zk0w17bgfj71h";
  };

  propagatedBuildInputs = [
    colorama
    funcparserlib
    rply
  ] ++ lib.optionals (pythonOlder "3.9") [
    astor
  ];

  checkInputs = [ pytestCheckHook ];

  disabledTests = [
    # Don't test the binary
    "test_bin_hy"
    "test_hystartup"
    "est_hy2py_import"
  ];

  postPatch = ''
    substituteInPlace setup.py --replace "version=__version__" "version='${version}'"
  '';

  pythonImportsCheck = [ "hy" ];

  meta = with lib; {
    description = "Python to/from Lisp layer";
    homepage = "https://github.com/hylang/hy";
    license = licenses.mit;
    maintainers = with maintainers; [ sylvorg ];
  };
}
