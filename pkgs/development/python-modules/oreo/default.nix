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
    rev = "main";
    sha256 = "056p4y2akpl1qjxdgvhl0sv6k045imawdq2wll3bgvnj2pwafr1i";
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