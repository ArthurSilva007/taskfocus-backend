# Multi-stage Dockerfile: build with Maven, run minimal JRE image
FROM maven:3.9.6-eclipse-temurin-17 as build
WORKDIR /app
COPY pom.xml mvnw ./
COPY .mvn .mvn
COPY src src
RUN mvn -B -DskipTests clean package
# Verifica e copia o JAR gerado para um caminho fixo para facilitar o COPY no estágio final
RUN if [ -f target/demo-0.0.1-SNAPSHOT.jar ]; then cp target/demo-0.0.1-SNAPSHOT.jar /app/app.jar; else echo "ERROR: jar not found in target/"; ls -la target || true; exit 1; fi

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/app.jar app.jar
EXPOSE 8084
ENV JAVA_OPTS=""
# Alinha o fallback da porta ao definido em application.properties (PORT:8084)
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=${PORT:-8084} -jar /app/app.jar"]

