{ lib
, python3Packages
, hyDefinedPythonPackages /* Packages like with python.withPackages */
, fetchFromGitHub
, ...
}:

python3Packages.buildPythonApplication ((with python3Packages; import ./shared.nix pythonOlder fetchFromGitHub pytestCheckHook lib) // rec {
  propagatedBuildInputs = with python3Packages; [
    appdirs
    clint
    colorama
    fastentrypoints
    funcparserlib
    rply
    pygments
  ] ++ lib.optionals (pythonOlder "3.9") [
    astor
  ] ++ (hyDefinedPythonPackages python3Packages);
})