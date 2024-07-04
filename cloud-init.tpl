#cloud-config
update: true

runcmd:
  - sudo dnf update
  - sudo dnf install -y docker htop
  - sudo systemctl start docker.service
  - sudo systemctl enable docker.service
  - sudo usermod -aG docker ec2-user
  - docker run -d --dns 8.8.8.8  --privileged -v satellite-cache:/tmp/earthly:rw -p 8372:8372 -e EARTHLY_TOKEN=${token} -e EARTHLY_ORG=${organization} -e SATELLITE_NAME=${sat_name} -e SATELLITE_HOST=${ip} earthly/satellite:v0.8.14-ticktock