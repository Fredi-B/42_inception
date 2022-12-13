# Dockerfile Nginx
# get penultimate stable version of Debian
FROM debian:buster

# update && install in one RUN
# "ensures your Dockerfile installs the latest package versions" #cachebusting
# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)
# '-y' answers yes to all prompts
# 'rm -rf...' delete the apt cache, to prevent potential parsing errors
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update -y && apt-get install -y \
    nginx \
    apt-get install -y openssl \
&& rm -rf /var/lib/apt/lists/*

# copy custom nginx config file from the host VM into the container
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

# openssl req -newkey rsa:4096: Create a 4096 bit RSA key for use with the TLS certificate

# (https://www.linode.com/docs/guides/create-a-self-signed-tls-certificate/)
# (https://www.openssl.org/docs/man1.0.2/man1/openssl-req.html)
RUN openssl req -x509 -days 365 -nodes -newkey rsa:4096 \
    -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -sha256 \
    -subj "/CN=fbechtol.42.fr" 

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
