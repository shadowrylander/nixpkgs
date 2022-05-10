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
    rev = "1b3344196cd572e54a4758c7a8f53b4dfc6418dd";
    sha256 = "05z6cr5dj0br3jvmincj77vfg7r70is1b6awkg75xll96g371rnq";
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