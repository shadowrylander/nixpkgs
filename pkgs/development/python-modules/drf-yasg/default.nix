{ lib
, buildPythonPackage
, fetchPypi
, inflection
, ruamel-yaml
, setuptools-scm
, six
, coreapi
, djangorestframework
, pytestCheckHook
, pytest-django
, datadiff
}:

buildPythonPackage rec {
  pname = "drf-yasg";
  version = "1.21.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Lyh3plukEn1+7t+pp3oJbbLjdDvRIddFACmXtBfA2Go=";
  };

  postPatch = ''
    # https://github.com/axnsan12/drf-yasg/pull/710
    sed -i "/packaging/d" requirements/base.txt
  '';

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    six
    inflection
    ruamel-yaml
    coreapi
    djangorestframework
  ];

  checkInputs = [
    pytestCheckHook
    pytest-django
    datadiff
  ];

  # ImportError: No module named 'testproj.settings'
  doCheck = false;

  pythonImportsCheck = [ "drf_yasg" ];

  meta = with lib; {
    description = "Generation of Swagger/OpenAPI schemas for Django REST Framework";
    homepage = "https://github.com/axnsan12/drf-yasg";
    maintainers = with maintainers; [ ];
    license = licenses.bsd3;
  };
}
