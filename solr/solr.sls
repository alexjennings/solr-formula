#sls

{% set config_version = salt['pillar.get']('solr:config', '4.1') %}
{% set schema_version = salt['pillar.get']('solr:schema', '4.1') %}
{% set solr_version = salt['pillar.get']('solr:version', '4.4.0') %}
{% set solr_file_hash = salt['pillar.get']('solr:hash', 'md5=6ae4f981a7e5e79fd5fc3675e19602f3') %}

include:
  - .jdk

solr_source:
  file.managed:
    - name: /opt/solr-{{ solr_version }}.tgz
    - source: http://archive.apache.org/dist/lucene/solr/{{ solr_version }}/solr-{{ solr_version }}.tgz
    - source_hash: {{ solr_file_hash }}
  cmd.run:
    - name: tar -xf /opt/solr-{{ solr_version }}.tgz
    - cwd: /opt
    - unless: file /opt/solr-{{ solr_version }}
    - require:
      - file: solr_source

solr_collection1:
  cmd.run:
    - name: cp -rp /opt/solr-{{ solr_version }}/example /opt/solr-{{ solr_version }}/cluster1
    - unless: file /opt/solr-{{ solr_version }}/cluster1
    - require:
      - cmd: solr_source


solr_log:
  file.directory:
    - name: /var/log/solr
    - mode: 777


solr_default:
  file.managed:
    - name: /etc/default/solr
    - template: jinja
    - source: salt://solr/templates/solr-default
    - watch_in:
      - service: solr_service

solr_schema:
  file.managed:
    - name: /opt/solr-{{ solr_version }}/cluster1/solr/collection1/conf/schema.xml
    - source: salt://solr/files/schema-{{ schema_version }}.xml
    - require:
      - cmd: solr_collection1
    - watch_in:
      - service: solr_service

solr_config:
  file.managed:
    - name: /opt/solr-{{ solr_version }}/cluster1/solr/collection1/conf/solrconfig.xml
    - source: salt://solr/files/solrconfig-{{ config_version }}.xml
    - require:
      - cmd: solr_collection1
    - watch_in:
      - service: solr_service


solr_init:
  file.managed:
    - name: /etc/init.d/solr
    - mode: 777
    - source: salt://solr/files/solr-init

solr_service:
  service:
    - name: solr
    - running
    - require:
      - file: solr_init
      - cmd: solr_collection1
      - file: solr_default
      - file: solr_log
      - file: solr_config
      - file: solr_schema

