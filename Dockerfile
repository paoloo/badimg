FROM ubuntu:latest

LABEL test1="hidden layer data"
ADD secret.txt /etc/secret.txt
RUN echo "inserting new data" >> /tmp/flag
RUN echo "inserting more data" >> /etc/random.txt \
    && rm -rf /etc/secret.txt

LABEL test2="fake api key"
ENV API_KEY="2b7c8c7714e699f758a7303827f47364"

LABEL doc="installing tools"
RUN apt update \
	&& apt install curl nmap netcat iproute2 stress-ng -y

RUN curl -fSL "https://github.com/genuinetools/amicontained/releases/download/v0.4.9/amicontained-linux-amd64" -o "/usr/local/bin/amicontained" \
	&& chmod a+x "/usr/local/bin/amicontained" \


CMD ["nc", "-kl", "8080"]
