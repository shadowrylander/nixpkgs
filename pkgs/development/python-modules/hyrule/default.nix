{ lib
, buildPythonPackage
, fetchPypi
, hy
}:

buildPythonPackage rec {
  pname = "hyrule";
  version = "0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-vn4J8oXvdKGPVqFoaofHKB34XoqBE+zrC1dc3qQOfNE=";
  };

  propagatedBuildInputs = [ hy ];
  
  pythonImportsCheck = [ "hyrule" ];

  meta = with lib; {
    description = "A utility library for Hy";
    homepage = "https://github.com/hylang/hyrule";
    license = licenses.mit;
    maintainers = with maintainers; [ sylvorg ];
  };
}