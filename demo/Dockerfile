# Multi-stage Dockerfile: build with Maven, run minimal JRE image
FROM maven:3.9.6-eclipse-temurin-17 as build
WORKDIR /app
COPY pom.xml mvnw ./
COPY .mvn .mvn
COPY src src
RUN mvn -B -DskipTests clean package

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENV JAVA_OPTS=""
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=${PORT:-8080} -jar /app/app.jar"]

