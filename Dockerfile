FROM nginx:latest

WORKDIR /app

COPY *.html /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
