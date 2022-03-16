{ lib
, fetchFromGitHub
, python310Packages
, glibcLocales
, coreutils
, git
, fzf
, fasd
, direnv
, zoxide
, starship
}:

python310Packages.buildPythonApplication rec {
  pname = "xonsh";
  version = "0.11.0";

  # fetch from github because the pypi package ships incomplete tests
  src = fetchFromGitHub {
    owner = "xonsh";
    repo = "xonsh";
    rev = version;
    sha256 = "sha256-jfxQMEVABTOhx679V0iGVX9RisuY42lSdztYXMLwdcw=";
  };

  LC_ALL = "en_US.UTF-8";

  postPatch = ''
    sed -ie "s|/bin/ls|${coreutils}/bin/ls|" tests/test_execer.py
    sed -ie "s|SHELL=xonsh|SHELL=$out/bin/xonsh|" tests/test_integrations.py

    sed -ie 's|/usr/bin/env|${coreutils}/bin/env|' tests/test_integrations.py
    sed -ie 's|/usr/bin/env|${coreutils}/bin/env|' scripts/xon.sh
    find scripts -name 'xonsh*' -exec sed -i -e "s|env -S|env|" {} \;
    find -name "*.xsh" | xargs sed -ie 's|/usr/bin/env|${coreutils}/bin/env|'
    patchShebangs .

    substituteInPlace scripts/xon.sh \
      --replace 'python' "${python310Packages.python}/bin/python"

  '';

  makeWrapperArgs = [
    "--prefix PYTHONPATH : ${placeholder "out"}/lib/${python310Packages.python.libPrefix}/site-packages"
  ];

  postInstall = ''
    wrapProgram $out/bin/xon.sh \
      $makeWrapperArgs
  '';

  disabledTests = [
    # fails on sandbox
    "test_colorize_file"
    "test_loading_correctly"
    "test_no_command_path_completion"
    # fails on non-interactive shells
    "test_capture_always"
    "test_casting"
    "test_command_pipeline_capture"
    "test_dirty_working_directory"
    "test_man_completion"
    "test_vc_get_branch"
    # ???
    "test_xonfig_info"
    "test_xonfig_kernel_with_jupyter"
    "test_xonfig_kernel_no_jupyter"
  ];

  disabledTestPaths = [
    # fails on non-interactive shells
    "tests/prompt/test_gitstatus.py"
    "tests/completers/test_bash_completer.py"
  ];

  preCheck = ''
    HOME=$TMPDIR
  '';

  checkInputs = [ glibcLocales git ] ++
    (with python310Packages; [ pyte pytestCheckHook pytest-mock pytest-subprocess ]);

  buildInputs = [
    fd
    fzf
    fasd
    direnv
    zoxide
    starship
  ];

  nativeBuildInputs = buildInputs;

  propagatedBuildInputs = with python310Packages; [
    ply
    prompt-toolkit
    pygments
    bakery
    xontrib-sh
    xontrib-readable-traceback
    xontrib-pipeliner
    xonsh-autoxsh
    xonsh-direnv
  ];

  meta = with lib; {
    description = "A Python-ish, BASHwards-compatible shell";
    homepage = "https://xon.sh/";
    changelog = "https://github.com/xonsh/xonsh/raw/${version}/CHANGELOG.rst";
    license = licenses.bsd3;
    maintainers = with maintainers; [ spwhitt vrthra ];
  };

  passthru = {
    shellPath = "/bin/xonsh";
  };
}
