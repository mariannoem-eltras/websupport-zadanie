import-docker-keys:
  cmd.run:
    - name: curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    - creates: /etc/apt/sources.list.d/docker.list
/etc/apt/sources.list.d/docker.list:
  file.managed:
    - source: salt://docker.list

docker:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg
      - lsb-release
      - docker-ce
      - python3-docker
    - install_recommends: False
    - load_modules: true
