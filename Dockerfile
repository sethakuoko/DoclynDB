# Stage 1: Build the Spring Boot application
FROM openjdk:24-jdk-slim as build

WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# Stage 2: Run the compiled JAR in a smaller image
FROM openjdk:24-slim

WORKDIR /app
COPY --from=build /app/target/Doclyn-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]