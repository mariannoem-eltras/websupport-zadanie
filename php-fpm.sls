docker_image_php-fpm:
  dockerng_image.present:
    - force: true
    - name: crunchgeek/php-fpm:7.4-r2

docker_image_memcached:
  dockerng_image.present:
    - force: true
    - name: memcached:latest

docker_container_php-fpm:
  docker_container.running:
    - name: php-fpm
    - image: crunchgeek/php-fpm:7.4-r2
    - port_bindings: 8000:8000
    - networks:
        - websupport-test


docker_container_memcached:
  docker_container.running:
    - name: memcached
    - image: memcached:latest
    - networks:
        - websupport-test

