# Stage 1: Build the application
FROM gradle:7.5-jdk11 AS build

WORKDIR /app
COPY . .
RUN gradle build

# Stage 2: Build the runtime image
FROM openjdk:11-jre-slim

EXPOSE 8080

WORKDIR /usr/app
COPY --from=build /app/build/libs/my-app-1.0-SNAPSHOT.jar /usr/app/

ENTRYPOINT ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]

