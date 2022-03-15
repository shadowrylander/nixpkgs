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
    rev = "main";
    sha256 = "1js0nmb355b707n1sdr1f0lrd7zgpnfvp38axqgkk1642wdwx3qh";
  };

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [ oreo ];

  pythonImportsCheck = [ "bakery" ];

  postPatch = ''
    substituteInPlace pyproject.toml \
        --replace "oreo = { git = \"https://github.com/syvlorg/oreo.git\", branch = \"main\" }" ""
  '';

  meta = with lib; {
    homepage = "https://github.com/syvlorg/oreo";
  };
}