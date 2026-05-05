#!/bin/sh
set -e

# If the platform injects DATABASE_URL like postgres://user:pass@host:port/db
# translate it to Spring Boot compatible variables when SPRING_DATASOURCE_URL is not set.
if [ -n "$DATABASE_URL" ] && [ -z "$SPRING_DATASOURCE_URL" ]; then
  # remove scheme
  proto_removed=$(echo "$DATABASE_URL" | sed -e 's#^postgres://##')
  user=$(echo "$proto_removed" | cut -d':' -f1)
  pass_and_host_db=$(echo "$proto_removed" | cut -d':' -f2-)
  pass=$(echo "$pass_and_host_db" | cut -d'@' -f1)
  host_db=$(echo "$pass_and_host_db" | cut -d'@' -f2)
  host=$(echo "$host_db" | cut -d'/' -f1 | cut -d':' -f1)
  port=$(echo "$host_db" | cut -d'/' -f1 | cut -d':' -f2)
  db=$(echo "$host_db" | cut -d'/' -f2-)
  if [ -z "$port" ]; then port=5432; fi
  export SPRING_DATASOURCE_URL="jdbc:postgresql://$host:$port/$db"
  export SPRING_DATASOURCE_USERNAME="$user"
  export SPRING_DATASOURCE_PASSWORD="$pass"
  echo "Translated DATABASE_URL to SPRING_DATASOURCE_URL"
fi

# Fallback: if SPRING_DATASOURCE_URL still empty, leave it to application.properties defaults

exec java $JAVA_OPTS -Dserver.port=${PORT:-8084} -jar /app/app.jar

