{ lib
, buildPythonPackage
, fastavro
, fetchPypi
, google-api-core
, google-auth
, google-cloud-bigquery
, pandas
, protobuf
, pyarrow
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "google-cloud-bigquery-storage";
  version = "2.17.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-AsEcoAmOg+J/g8P5o51PzO9R5z0Nce9zQ/EiIYhmaFw=";
  };

  propagatedBuildInputs = [
    google-api-core
    protobuf
  ] ++ google-api-core.optional-dependencies.grpc;

  passthru.optional-dependencies = {
    fastavro = [
      fastavro
    ];
    pandas = [
      pandas
    ];
    pyarrow = [
      pyarrow
    ];
  };

  checkInputs = [
    google-auth
    google-cloud-bigquery
    pytestCheckHook
  ];

  # Dependency loop with google-cloud-bigquery
  doCheck = false;

  preCheck = ''
    rm -r google
  '';

  pythonImportsCheck = [
    "google.cloud.bigquery_storage"
    "google.cloud.bigquery_storage_v1"
    "google.cloud.bigquery_storage_v1beta2"
  ];

  meta = with lib; {
    description = "BigQuery Storage API API client library";
    homepage = "https://github.com/googleapis/python-bigquery-storage";
    changelog = "https://github.com/googleapis/python-bigquery-storage/blob/v${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
