[![Docker Pulls](https://img.shields.io/docker/pulls/flyskywhy/java-nodejs.svg?style=flat-square)](https://hub.docker.com/r/flyskywhy/java-nodejs/)
[![Image Badges](https://images.microbadger.com/badges/image/flyskywhy/java-nodejs.svg)](https://microbadger.com/images/flyskywhy/java-nodejs)

# Java with Node.js
`android-sdk/` and other cache like npm will automatically grows when building apk or e.g. `npm install`, so mount them into docker container is better than [docker-rn-nodejs](https://github.com/flyskywhy/docker-rn-nodejs) for CI/CD, then run bellow in the container:

    export YARN_CACHE_FOLDER=/cache/yarn
    export NPM_CONFIG_CACHE=/cache/npm
    export GRADLE_USER_HOME=/cache/gradle
    export ANDROID_SDK_HOME=/cache/android
    export ANDROID_HOME=/cache/opt/android-sdk
    export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
    set +o pipefail
    yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
    set -o pipefail

where `/cache/` is mounted volume for example.

Now this container can build react-native apk.

### based on [beevelop/java](https://github.com/beevelop/docker-java)
