![SSL](https://github.com/Pingflow/ssl-file/raw/master/icon-ssl.png)

_Create ssl files from variables and share_

[![license](https://img.shields.io/github/license/Pingflow/ssl-file.svg?style=for-the-badge)](https://github.com/Pingflow/ssl-file/blob/master/LICENSE)
[![release](https://img.shields.io/github/release/Pingflow/ssl-file.svg?style=for-the-badge)](https://github.com/Pingflow/ssl-file/releases)
[![build](https://img.shields.io/docker/build/pingflow/ssl-file.svg?style=for-the-badge)](https://hub.docker.com/r/pingflow/ssl-file/)

Docker Compose example
----------------------

```yaml
version: '2'
services:

  ssl-file:
    image: pingflow/ssl-file
    environment:
      SSL_PATH: /etc/ssl/custom
      SSL_CRT_NAME: mydomain.crt
      SSL_CRT: |
      -----BEGIN CERTIFICATE-----
      ...
      -----END CERTIFICATE-----
      SSL_KEY_NAME: mydomain.key
      SSL_KEY: |
      -----BEGIN PRIVATE KEY-----
      ...
      -----END PRIVATE KEY-----
      
  ngnix:
    image: ngnix
    volumes_from:
      - ssl-file:ro
    ports:
      - 80:80/tcp
      - 443:443/tcp
```

Variables
---------

`SSL_PATH` *[Optional]*
- __Description__: Path of directory location SSL files
- __Default__ : `/ssl`

`SSL_CRT_NAME` *[Optional]*
- __Description__: Name of certificate
- __Default__ : `ssl.crt`

`SSL_CRT` *[Required]*
- __Description__: Value of certificate file
- __Default__ : none

`SSL_KEY_NAME` *[Optional]*
- __Description__: Name of private key
- __Default__ : `ssl.key`

`SSL_KEY` *[Required]*
- __Description__: Value of private key file
- __Default__ : none

`SSL_CA_NAME` *[Optional]*
- __Description__: Name of CA
- __Default__ : `ca.crt`

`SSL_CA` *[Optional]*
- __Description__: Value of CA file
- __Default__ : none
