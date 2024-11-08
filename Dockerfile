# Use an official Maven image as the builder
FROM maven:3.8.1-openjdk-11 AS build

# Copy project files
COPY . /app
WORKDIR /app

# Build the Maven project
RUN mvn clean package

# Use a smaller JDK for the final image
FROM openjdk:11-jre-slim

# Copy the built JAR from the Maven image
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar /my-app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "/my-app.jar"]
