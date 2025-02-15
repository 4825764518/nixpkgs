{ lib
, buildPythonPackage
, fetchPypi
, graphviz
, jupyter
, matplotlib
, networkx
, opt-einsum
, pandas
, pillow
, pyro-api
, pythonOlder
, torch
, scikit-learn
, seaborn
, torchvision
, tqdm
, wget
}:

buildPythonPackage rec {
  pname = "pyro-ppl";
  version = "1.8.3";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit version pname;
    hash = "sha256-Pt1DgbAg0S6KtQ6+ApjHpo0VC4oCT5mK2G/ax6MI1Q4=";
  };

  propagatedBuildInputs = [
    pyro-api
    torch
    networkx
    opt-einsum
    tqdm
  ];

  passthru.optional-dependencies = {
    extras = [
      graphviz
      jupyter
      # lap
      matplotlib
      pandas
      pillow
      scikit-learn
      seaborn
      torchvision
      # visdom
      wget
    ];
  };

  # pyro not shipping tests do simple smoke test instead
  doCheck = false;

  pythonImportsCheck = [
    "pyro"
    "pyro.distributions"
    "pyro.infer"
    "pyro.optim"
  ];

  meta = with lib; {
    description = "Library for probabilistic modeling and inference";
    homepage = "http://pyro.ai";
    license = licenses.asl20;
    maintainers = with maintainers; [ teh georgewhewell ];
  };
}
