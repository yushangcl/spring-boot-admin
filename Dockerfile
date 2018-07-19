FROM maven:3.5-jdk-8-alpine AS build
LABEL Author="gayhub@live.cn"

WORKDIR /src
RUN apk add --no-cache git \
    && git clone https://github.com/yushangcl/spring-boot-admin.git \
    && cd spring-boot-admin \
    && mvn package -Dmaven.test.skip=true

# spring-boot-admin
FROM logr/8-jre-alpine
COPY --from=build /src/spring-boot-admin/target/spring-boot-admin-0.0.1-SNAPSHOT.jar .
RUN mv spring-boot-admin-0.0.1-SNAPSHOT.jar spring-boot-admin.jar

#执行
CMD java -jar spring-boot-admin.jar