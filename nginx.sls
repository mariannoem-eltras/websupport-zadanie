docker_network_websupport-test:
   docker_network.present:
     - name: websupport-test
     - internal: True
     - enable_ipv6: False

docker_image_nginx:
  docker_image.present:
    - force: True
    - name: nginx:latest

docker_container_nginx:
   docker_container.running:
     - name: nginx
     - image: nginx:latest
     - port_bindings:
         - 80:80
     - networks:
         - websupport-test

