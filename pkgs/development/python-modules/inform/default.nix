{ lib, buildPythonPackage, fetchFromGitHub
, arrow
, six
, hypothesis
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "inform";
  version = "1.25";

  src = fetchFromGitHub {
    owner = "KenKundert";
    repo = "inform";
    rev = "v${version}";
    sha256 = "1r56wmn21c7ggy33548l6dfjswhadkp2iaalfb7xgsxmq7qfcnax";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace "pytest-runner>=2.0" ""
  '';

  propagatedBuildInputs = [ arrow six ];

  checkInputs = [ pytestCheckHook hypothesis ];
  preCheck = ''
    patchShebangs test.doctests.py test.inform.py
    ./test.doctests.py
    ./test.inform.py
  '';

  meta = with lib; {
    description = "Print and logging utilities";
    longDescription = ''
      Inform is designed to display messages from programs that are typically
      run from a console. It provides a collection of ‘print’ functions that
      allow you to simply and cleanly print different types of messages.
    '';
    homepage = "https://inform.readthedocs.io";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ jeremyschlatter ];
  };
}
