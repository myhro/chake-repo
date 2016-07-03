package 'docker.io'

docker_clean = '/usr/local/bin/docker-clean.sh'

docker_clean_src = "#!/bin/bash
docker rm $(docker ps -a | grep 'Exited' | awk '{ print $1 }')
docker rmi $(docker images | grep '^<none>' | awk '{ print $3 }')
"

file docker_clean do
    content docker_clean_src
    owner 'root'
    group 'root'
    mode '0775'
end

cron 'docker-clean' do
    minute '0'
    hour '6'
    command docker_clean
end
