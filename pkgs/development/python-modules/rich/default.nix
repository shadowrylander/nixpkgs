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
    rev = "a6c20ce10adc7b8cfacfd74e0b025e8c2c8c19eb";
    sha256 = "1ld3ihvssfk56240wignmd6hv7gynid5wmcynl58ng8sbfywm3ly";
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
