docker_image_mysql:
  docker_image.present:
    - force: True
    - name: mysql

docker_container_mysql:
   docker_container.running:
     - name: mysql
     - image: mysql:latest
     - networks:
         - websupport-test
