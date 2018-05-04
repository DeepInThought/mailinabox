# Python builder
FROM python:latest as PYTHON_BUILDER

WORKDIR /usr/src/app
COPY /containers/docker/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD [ "python3", "-m", "mailinabox" ]

# Pull the latest Ubuntu Trusty 14.04 image to conform to https://mailinabox.email/guide.html#machine
FROM ubuntu:trusty
EXPOSE 25 53/udp 53/tcp 80 443 587 993 4190

COPY --from=PYTHON_BUILDER /usr/src/app /usr/local/lib/mailinabox
# STORAGE_ROOT=/home/user-data according to setup/questions.sh
VOLUME /home/user-data

# make sure we're fully up-to-date and add the ppa:mail-in-a-box/ppa repository
RUN sh -xc 'apt-get update && apt-get dist-upgrade -y' \
    echo "# adding mail-in-a-box apt ppa's to sources.list" \
    echo "deb http://ppa.launchpad.net/mail-in-a-box/ppa/ubuntu trusty main" >> "/etc/apt/sources.list" \
    echo "deb-src http://ppa.launchpad.net/mail-in-a-box/ppa/ubuntu trusty main" >> "/etc/apt/sources.list" \
    apt-get update \
# cleanup time
    apt-get purge -y --auto-remove && rm -rf /var/lib/apt/lists/*

# Install packages needed by Mail-in-a-Box.
# ADD containers/docker/apt_package_list.txt /tmp/mailinabox_apt_package_list.txt
# RUN echo "dialog python3 python3-pip" >> /tmp/mailinabox_apt_package_list.txt 
#     DEBIAN_FRONTEND=noninteractive apt-get install -y $(cat /tmp/mailinabox_apt_package_list.txt)

# from questions.sh -- needs merging into the above line
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y dialog python3 python3-pip
# RUN pip3 install "email_validator>=1.0.0"

# Now add Mail-in-a-Box to the system.
# ADD . /usr/local/mailinabox

# Configure runit services.
# RUN /usr/local/mailinabox/containers/docker/tools/configure_services.sh

# Add my_init scripts
# ADD containers/docker/my_init.d/* /etc/my_init.d/

# ARG necessary for build variables to pass. #
ARG BUILD_DATE 
ARG VCS_REF
ARG BUILD_VERSION

# ********** Information ********** #
# Following label schema per http://label-schema.org/rc1/ and build hook for dynamic org.label-schema.build-date & vcs-ref labeling. #
LABEL org.label-schema.name="deepinthought/mailinabox" \
    org.label-schema.description="A Docker image build forked from mail-in-a-box/mailinabox on Github.com" \
    org.label-schema.usage="DOCKER_README.md" \
    org.label-schema.build-date=$BUILD_DATE \ 
    org.label-schema.vcs-url="https://github.com/DeepInThought/mailinabox.git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.schema-version="1.0.0-rc1" \
    org.label-schema.url="https://github.com/DeepInThought/mailinabox" \
    org.label-schema.vendor="DeepInThought <support@deepinthought.io>" \
    org.label-schema.version=${BUILD_VERSION}:-0.0.1} \
    org.label-schema.docker.cmd="docker run --rm -it -p 25:25 -p 443:443 -p 4190:4190 -p 993:993 -p 995:995 -p 587:587 -p 80:80 deepinthought/mailinabox"

# Get ready to run command 
ENTRYPOINT ["./containers/docker/scripts/release.sh"]