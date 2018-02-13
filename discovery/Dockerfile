FROM java:8
COPY target/*.jar /usr/src/application/application.jar
WORKDIR /usr/src/application
CMD ["java", "-jar", "application.jar"]