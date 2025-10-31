FROM maven:3.9.8-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk
WORKDIR /app
# El nombre del JAR de tu proyecto (java-hello-world-0.0.1-SNAPSHOT.jar)
ARG JAR_FILE=java-hello-world-0.0.1-SNAPSHOT.jar
# Copia el JAR compilado desde la etapa 'build'
COPY --from=build /app/target/${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
