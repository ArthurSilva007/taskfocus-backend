FROM eclipse-temurin:17-jre

# Runtime-only Dockerfile: expects the application JAR to be present under
# `target/` in the build context. This keeps the image small and makes CI
# responsibility to build the artifact (recommended).
WORKDIR /app

# Allow override of the jar filename at build time. Default matches Maven artifactId/version.
ARG JAR_FILE=demo-0.0.1-SNAPSHOT.jar
COPY target/${JAR_FILE} app.jar

COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

EXPOSE 8084
ENV JAVA_OPTS=""
ENTRYPOINT ["/app/docker-entrypoint.sh"]

