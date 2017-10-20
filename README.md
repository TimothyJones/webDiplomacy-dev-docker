webDiplomacy-dev-docker
=======================

Provides a development environment for webDiplomacy

# What you need

 * [Docker](https://www.docker.com/)
 * A system that runs `bash`

# Usage

Get the harness:

```
git clone https://github.com/TimothyJones/webDiplomacy-dev-docker.git
cd webDiplomacy-dev-docker
```

Then, just run:

```
./start-server.sh
```

It will take a while the first time you've run it, as it needs to build the docker image.

Once the server has started, it runs at [localhost:80](http://localhost) by default. You can change this by setting WEBDIP_PORT before calling `./start-server.sh`

Once you've registered a new user, navigate to [http://localhost/gamemaster.php?gameMasterSecret=](http://localhost/gamemaster.php?gameMasterSecret=) to make yourself an admin.

# Very important

Do not use this harness to run a webDiplomacy installation open to the web! It has debug mode set on, and default passwords everywhere. You have been warned.

Also, the database doesn't persist between server starts.
