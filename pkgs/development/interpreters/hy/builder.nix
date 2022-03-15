{ lib
, python310Packages
, hyDefinedPythonPackages /* Packages like with python.withPackages */
, fetchFromGitHub
, ...
}:

python39Applications.buildPythonApplication ((with python310Packages; import ./shared.nix pythonOlder fetchFromGitHub pytestCheckHook lib) // rec {
  propagatedBuildInputs = with python310Packages; [
    appdirs
    clint
    colorama
    fastentrypoints
    funcparserlib
    rply
    pygments
  ] ++ lib.optionals (pythonOlder "3.9") [
    astor
  ] ++ (hyDefinedPythonPackages python310Packages);
})