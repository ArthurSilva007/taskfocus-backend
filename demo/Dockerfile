# Multi-stage Dockerfile: build with Maven, run minimal JRE image
FROM maven:3.9.6-eclipse-temurin-17 as build
WORKDIR /app
COPY pom.xml mvnw ./
COPY .mvn .mvn
COPY src src
RUN mvn -B -DskipTests clean package
# Localiza o JAR gerado (qualquer *-SNAPSHOT.jar dentro de target) e copia para /app/app.jar
RUN JAR_PATH=$(find target -maxdepth 3 -type f -name "*-SNAPSHOT.jar" | head -n 1) \
    && if [ -n "$JAR_PATH" ]; then cp "$JAR_PATH" /app/app.jar; else echo "ERROR: jar not found in target/ (searched for '*-SNAPSHOT.jar')"; ls -la target || true; exit 1; fi

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/app.jar app.jar
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

EXPOSE 8084
ENV JAVA_OPTS=""
ENTRYPOINT ["/app/docker-entrypoint.sh"]

