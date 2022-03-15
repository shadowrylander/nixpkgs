{ lib
, python39Packages
, hyDefinedPythonPackages /* Packages like with python.withPackages */
, ...
}:
python39Packages.buildPythonApplication rec {
  pname = "hy";
  version = "1.0a4";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "hylang";
    repo = pname;
    rev = version;
    sha256 = "0l8gl4w19qw7bina0fdfs61rikqx30375w3xvc3zk0w17bgfj71h";
  };

  propagatedBuildInputs = with python39Packages; [
    appdirs
    clint
    colorama
    fastentrypoints
    funcparserlib
    rply
    pygments
  ] ++ lib.optionals (pythonOlder "3.9") [
    astor
  ] ++ (hyDefinedPythonPackages python39Packages);

  checkInputs = with python39Packages; [ pytestCheckHook ];

  disabledTests = [
    # Don't test the binary
    "test_bin_hy"
    "test_hystartup"
    "est_hy2py_import"
  ];

  postPatch = ''
    substituteInPlace setup.py --replace "version=__version__" "version='${version}'"
  '';

  meta = with lib; {
    description = "A LISP dialect embedded in Python";
    homepage = "https://hylang.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ sylvorg ];
    platforms = platforms.all;
  };
}
