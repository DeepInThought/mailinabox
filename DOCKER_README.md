Mail-in-a-Box Docker Image
===========================
By [@DeepInThought](https://github.com/DeepInThought). 

Docker Hub location can be found at [https://hub.docker.com/r/deepinthought/mailinabox/](https://hub.docker.com/r/deepinthought/mailinabox/).  

I began this Docker image as I didn't see anything usable at the time of setup for myself.

Purpose
-------
Provide an up-to-date Docker image of the official [mail-in-a-box/mainabox](https://github.com/mail-in-a-box/mailinabox) repository.

Installation
-------
* For a list of tags, see this [Docker Hub tags](https://hub.docker.com/r/deepinthought/mailinabox/tags/) page.
* The [Dockerfile](https://hub.docker.com/r/deepinthought/mailinabox/~/dockerfile/) for more clarity.    
 
Docker Commands:

    $ docker pull deepinthought/mailinabox

_Optional:_ If you want to pull a specific image [tag](https://hub.docker.com/r/deepinthought/mailinabox/tags/).  i.e. deepinthought/mailinabox:latest

    $ docker pull deepinthought/mailinabox:[TAG] for more options.

Docker Run Commands:

    $ docker run --rm -it deepinthought/mailinabox
        
_Optional:_ If you want to define the port configuration at run. 

    $ docker run --rm -it -p 25:25 -p 53:53/udp -p 53:53 -p 443:443 -p 4190:4190 -p 993:993 -p 995:995 -p 587:587 -p 80:80 deepinthought/mailinabox
    
Docker Files:
-------
* [Dockerfile](Dockerfile) - Official Dockerfile used to construct the image.
* [.dockerignore](.dockerignore) - Keep things out of Docker.
* [docker-compose.yml](docker-compose.yml) - Future usage for docker-compose builds.
* [docker-compose.debug.yml](docker-compose.debug.yml) - Future usage for docker-compose builds.
* [DOCKER_README](DOCKER_README.md) - This readme file.

Official Mail-in-a-Box Information
-------

Mail-in-a-Box helps individuals take back control of their email by defining a one-click, easy-to-deploy SMTP+everything else server: a mail server in a box.

**Please see [https://mailinabox.email](https://mailinabox.email) for the OFFICIAL project's website and [setup guide](https://mailinabox.email/guide.html) for detailed, user-friendly instructions.!**

The official [README](README.md) from [Mail-in-a-Box](https://github.com/mail-in-a-box).

About DeepInThought
-------
[@DeepInThought](https://github.com/DeepInThought) is a [St. Louis, Missouri](https://en.wikipedia.org/wiki/St._Louis) tech startup.  
* Official website is in development.
* Feel free to contact me at [support@deepinthought.io](mailto:support@deepinthought.io).  

![DeepIT](https://raw.githubusercontent.com/DeepInThought/deep-www/master/docs/images/deep_main.png)