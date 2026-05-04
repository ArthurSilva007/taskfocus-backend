Deploy instructions (quick)

1) Build locally (fast):

   On Windows PowerShell (from demo folder):

   .\mvnw.cmd -DskipTests clean package

   The repackaged jar will be created at: target/demo-0.0.1-SNAPSHOT.jar

2) Start locally (for smoke test):

   $env:PORT=8080; java -Dserver.port=$env:PORT -jar target/demo-0.0.1-SNAPSHOT.jar

   Note: the application expects environment variables for database, mail and JWT secrets. Use application.properties or set env vars.

3) Deploy to Railway (or similar):

   - Push this repository to Git (ensure demo/ is committed).
   - In Railway create a new project, choose Deploy from GitHub (or connect your repo)
   - Set the service root to the `demo/` folder (if asked) or the repo containing `pom.xml`.
   - Build command: .\\mvnw.cmd -DskipTests clean package
   - Start command: java -Dserver.port=$PORT -jar target/demo-0.0.1-SNAPSHOT.jar
   - Add environment variables required by the app (example names used in application.properties):
       SPRING_DATASOURCE_URL, SPRING_DATASOURCE_USERNAME, SPRING_DATASOURCE_PASSWORD,
       SPRING_MAIL_HOST, SPRING_MAIL_PORT, SPRING_MAIL_USERNAME, SPRING_MAIL_PASSWORD,
       JWT_SECRET, SPRING_PROFILES_ACTIVE (e.g., production)

4) Alternatives:

   - Docker: add a Dockerfile that builds with Maven and runs the jar — helpful for consistent deploys.

5) Troubleshooting:

   - If the build fails on Railway due to missing Java or Maven, choose the Java environment or provide a Dockerfile.
   - If the app fails to start, check logs for missing env vars or database connection issues.

