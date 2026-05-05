# Multi-stage Dockerfile at repository root. Builds the demo module and produces a runtime image.
FROM maven:3.9.6-eclipse-temurin-17 as build
WORKDIR /src

# Copy only what's needed for the demo build to leverage Docker cache
COPY mvnw mvnw
COPY .mvn .mvn
COPY pom.xml pom.xml
COPY demo/pom.xml demo/pom.xml
COPY demo/src demo/src

# Build the demo module (explicit -f demo/pom.xml ensures correct module build)
RUN mvn -f demo/pom.xml -B -DskipTests clean package

# Find the built JAR and copy to a fixed path
RUN mkdir -p /app \
  && JAR_PATH=$(find demo/target -maxdepth 3 -type f -name "*-SNAPSHOT.jar" | head -n 1) \
  && if [ -n "$JAR_PATH" ]; then cp "$JAR_PATH" /app/app.jar; else echo "ERROR: jar not found (searched demo/target)"; ls -la demo/target || true; exit 1; fi

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/app.jar app.jar
# Copy entrypoint from demo (keeps DB conversion behavior)
COPY demo/docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

EXPOSE 8084
ENV JAVA_OPTS=""
ENTRYPOINT ["/app/docker-entrypoint.sh"]

