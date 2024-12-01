# Stage 1: Build the application
FROM gradle:7.5-jdk11 AS build

WORKDIR /app

COPY . .

# Run gradle build and show the contents of build/libs for debugging
RUN ./gradlew clean build --stacktrace && ls -al /app/build/libs  # Run gradle build and then list libs

# Stage 2: Build the runtime image
FROM openjdk:11-jre-slim

EXPOSE 8080

WORKDIR /usr/app
# Update COPY path to match the correct file and directory
COPY --from=build /app/build/libs/java-app-1.0-SNAPSHOT.jar /usr/app/

ENTRYPOINT ["java", "-jar", "java-app-1.0-SNAPSHOT.jar"]
