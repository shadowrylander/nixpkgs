{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, astor
, colorama
, funcparserlib
, rply
}:

buildPythonPackage ((import ../../interpreters/hy/shared.nix pythonOlder fetchFromGitHub pytestCheckHook lib) // rec {
  propagatedBuildInputs = [
    colorama
    funcparserlib
    rply
  ] ++ lib.optionals (pythonOlder "3.9") [
    astor
  ];
})