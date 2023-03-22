FROM gradle:7.4.0-jdk17 AS build

WORKDIR /app

COPY . .

RUN gradle clean build
RUN gradle publish

FROM openjdk:17-slim

WORKDIR /app

COPY --from=build /app/build/libs/com.example-1.0-SNAPSHOT.jar /app/com.example-1.0-SNAPSHOT.jar

EXPOSE 8080

CMD ["java", "-jar", "/app/com.example-1.0-SNAPSHOT.jar"]
