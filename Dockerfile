FROM tomcat:8.5-alpine

RUN mkdir -p /usr/local/tomcat/webapps/api/WEB-INF/classes/com/vividseats/servlet

COPY src/main/webapp/WEB-INF/com/vividseats/servlet/Api.class /usr/local/tomcat/webapps/api/WEB-INF/classes/com/vividseats/servlet/
COPY src/main/webapp/WEB-INF/web.xml /usr/local/tomcat/webapps/api/WEB-INF/