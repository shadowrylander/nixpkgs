{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, CommonMark
, dataclasses
, poetry-core
, pygments
, typing-extensions
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "rich";
  version = "12.0.0";
  format = "pyproject";
  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "syvlorg";
    repo = pname;
    rev = "master";
    sha256 = "1pag703gc0ga6mw9v033zg2xjk2i2v26q8rj1p2988p78lqibp3p";
  };

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [
    CommonMark
    pygments
  ] ++ lib.optional (pythonOlder "3.7") [
    dataclasses
  ] ++ lib.optional (pythonOlder "3.9") [
    typing-extensions
  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "rich" ];

  meta = with lib; {
    description = "Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal";
    homepage = "https://github.com/syvlorg/rich";
    license = licenses.mit;
    maintainers = with maintainers; [ syvlorg ];
  };
}
