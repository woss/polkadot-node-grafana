FROM grafana/grafana:6.6.1
LABEL author="Daniel Maricic <daniel@woss.io>"

RUN grafana-cli plugins install simpod-json-datasource
