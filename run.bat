set M2_HOME=D:\apache-maven-3.5.2
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_161

docker-machine rm messaging-system -f
docker-machine create -d virtualbox --virtualbox-memory "4096" messaging-system
docker-machine ip messaging-system > IP
SET /p MESSAGING_SYSTEM= < IP
DEL IP

docker-machine ssh messaging-system sudo curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
docker-machine ssh messaging-system sudo chmod +x /usr/local/bin/docker-compose
docker-machine ssh messaging-system sudo mkdir /mnt/app
echo "Mount application point as [app]"
pause
docker-machine ssh messaging-system sudo mount -t vboxsf app /mnt/app

call "%M2_HOME%\bin\mvn" clean package -q -f discovery\pom.xml
call "%M2_HOME%\bin\mvn" clean package -q -f configuration\pom.xml
call "%M2_HOME%\bin\mvn" clean package -q -f http-request-consumer\pom.xml
call "%M2_HOME%\bin\mvn" clean package -q -f event-processor\pom.xml
call "%M2_HOME%\bin\mvn" clean package -q -f gateway\pom.xml

docker-machine ssh messaging-system docker-compose -f /mnt/app/messaging-system.yml build
docker-machine ssh messaging-system docker-compose -f /mnt/app/messaging-system.yml up -d

echo *******************************************************
echo http://%MESSAGING_SYSTEM% - Application
echo *******************************************************
pause