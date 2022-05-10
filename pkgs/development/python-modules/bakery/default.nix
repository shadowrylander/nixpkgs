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
    rev = "0e2916ed2b94d3badc0e33c246a46e2783612bd0";
    sha256 = "1m9aasy57xx7f12962c6sm331xhvpr8n4k3gg8q69aajf3jwyah3";
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