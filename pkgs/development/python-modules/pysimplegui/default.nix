{ lib
, buildPythonPackage
, fetchPypi
, tkinter
, pythonOlder
}:

buildPythonPackage rec {
  pname = "pysimplegui";
  version = "4.60.1";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    pname = "PySimpleGUI";
    inherit version;
    sha256 = "sha256-PqGOOq6lFb30Dn1zAV0QHZKr3fIUsTSudnTpnFi5ZZg=";
  };

  propagatedBuildInputs = [
    tkinter
  ];

  pythonImportsCheck = [
    "PySimpleGUI"
  ];

  meta = with lib; {
    description = "Python GUIs for Humans";
    homepage = "https://github.com/PySimpleGUI/PySimpleGUI";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ lucasew ];
  };
}
