# Multi-stage build for Spring Boot application
# Stage 1: Build stage
FROM openjdk:24-jdk-slim as build
COPY . .
RUN ./mvnw clean package -DskipTests

FROM openjdk:24-jre-slim
COPY --from=build /app/target/Doclyn-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
