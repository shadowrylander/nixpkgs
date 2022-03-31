{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, poetry-core
, addict
, autoslot
, click
, coconut
, cytoolz
, hy
, hyrule
, more-itertools
, nixpkgs
, rich
, toolz
}:

buildPythonPackage rec {
  pname = "oreo";
  version = "1.0.0.0";
  format = "pyproject";
  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "syvlorg";
    repo = pname;
    rev = "51065aa8ecea1ee309f1dd54bdef2f14ec634b47";
    sha256 = "1s6lrzzfdadn4hx8qkzy1jh9vmlly5k01dwdg4yqk4yqbqlkqfbv";
  };

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [
      addict
      autoslot
      click
      coconut
      cytoolz
      hy
      hyrule
      more-itertools
      nixpkgs
      rich
      toolz
  ];

  pythonImportsCheck = [ "oreo" ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace "rich = { git = \"https://github.com/syvlorg/rich.git\", branch = \"master\" }" ""
  '';

  meta = with lib; {
    description = "The Stuffing for Other Functions!";
    homepage = "https://github.com/syvlorg/oreo";
    license = licenses.oreo;
    maintainers = with maintainers; [ syvlorg ];
  };
}