FROM maven:3.8-openjdk-11 as maven_build
WORKDIR /app

# Download dependencies
COPY pom.xml .
RUN mvn --batch-mode de.qaware.maven:go-offline-maven-plugin:resolve-dependencies

# Compile + package JAR
COPY src src/
RUN mvn --offline clean compile assembly:single

########################################################################

FROM openjdk:11.0-jre
WORKDIR /app

ENV APP_JAR=charity-commission-database-loader-1.0-SNAPSHOT-jar-with-dependencies.jar

COPY --from=maven_build /app/target/${APP_JAR} /app

CMD java -jar ${APP_JAR}