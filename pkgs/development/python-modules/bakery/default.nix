{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, poetry-core
, oreo
}:

buildPythonPackage rec {
  pname = "bakery";
  version = "2.0.0.0";
  format = "pyproject";
  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "syvlorg";
    repo = pname;
    rev = "2399cc48ef885b31f8a6c3e164f471f4156ea5d5";
    sha256 = "0xh19r2xdq7cq5in91gxmka0af65q99y4dwbwy9srizxwjwxzb0k";
  };

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [ oreo ];

  pythonImportsCheck = [ "bakery" ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace "oreo = { git = \"https://github.com/syvlorg/oreo.git\", branch = \"main\" }" ""
  '';

  meta = with lib; {
    homepage = "https://github.com/syvlorg/oreo";
  };
}