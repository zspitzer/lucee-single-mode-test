# Lucee 6 Single Mode host test

This is a test suite for checking Lucee 6 single mode with multiple hosts with mod_cfml and apache

It does the following via Github Actions

- Installs lucee using the ubuntu x64 installer
- Set up Apache with two nearly identical virtual hosts
- calls each virtual host and dumps the output

Developed to triage this bug

https://luceeserver.atlassian.net/browse/LDEV-5536
