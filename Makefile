all:
	sudo docker-compose build
	sudo docker-compose up -d

down:
	sudo docker-compose down

remove:
	sudo docker rm $(sudo docker ps -a -q)
	sudo docker rmi $(sudo docker images -q)

volume:
	sudo docker volume rm $(sudo docker volume ls -q)

clean:
	sudo docker-compose down
	sudo docker-compose rm -f

clear_all:
	sudo docker rmi $(sudo docker images -f "dangling=true" -q)
	sudo docker rm $(sudo docker ps -aq) -f
	sudo docker-compose down --volume
	sudo docker-compose rm -f

re: clean all
