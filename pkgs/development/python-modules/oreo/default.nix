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
  # format = "pyproject";
  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "syvlorg";
    repo = pname;
    rev = "6cb1453b0d13613ca1d19bd1b419b107b99a2f6d";
    sha256 = "0cizhp6p70sx8a388iyy005q0xm83db052f0rwcwmcaxmqvq74zb";
  };

  # buildInputs = [ poetry-core ];

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

  # doCheck = false;

  postPatch = ''
    substituteInPlace pyproject.toml --replace "rich = { git = \"https://github.com/syvlorg/rich.git\", branch = \"master\" }" ""
    substituteInPlace setup.py --replace "'rich @ git+https://github.com/syvlorg/rich.git@master'," ""
  '';

  meta = with lib; {
    description = "The Stuffing for Other Functions!";
    homepage = "https://github.com/syvlorg/oreo";
    license = licenses.oreo;
    maintainers = with maintainers; [ syvlorg ];
  };
}
