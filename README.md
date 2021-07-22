# UnifiedPush Common-Proxies

Common-Proxies is a set of rewrite proxies and gateways for UnifiedPush. See [the diagram](https://unifiedpush.org/img/diagram.png) for more info regarding where rewrite proxies and gateways fit in UnifiedPush.


## Installing

1. Download the binary and [example config file](./example-config.toml) onto your server
. Place the [systemd service file](./up-rewrite-proxy.service) in /etc/systemd/system/up-rewrite-proxy.service . Make sure to edit the contents of the file.
1. `systemctl enable --now up-rewrite-proxy`
1. Install the [reverse-proxy](#reverse-proxy)

### Docker-Compose with Gotify quick start
There's [a guide](https://unifiedpush.org/users/distributors/gotify/#docker-compose-quick-setup) on the documentation for UnifiedPush.

### Docker
1. Run `docker run -p 5000:5000 -e UP_GATEWAY_MATRIX_ENABLE=true -e OTHER_ENV_VAR=other -v $PWD/config.toml:/app/config.toml:ro unifiedpush/common-proxies`. While changing parameters like the port and the environment variables to the appropriate values.
1. Check the [example config file](./example-config.toml) for all configuration options and their environment variable forms
1. Install the [reverse-proxy](#reverse-proxy)

### Reverse Proxy

Use the following nginx config, or the equivalent for your reverse proxy. The following snippet goes with the same domain as your push provider (probably Gotify).
```nginx 
location ~ ^/(FCM|UP|_matrix) {    
        proxy_pass            http://127.0.0.1:5000;
}
```
The :5000 will be the port you specify to the listen directive in the config file or the docker port flag.


## Rewrite Proxy

Common-Proxies handles paths like /UP (Gotify) or /FCM (Firebase). Only traffic for these paths should be forwarded to common-proxies, where it can then convert the push message to the push-provider specific format.

### FCM

This is meant to be hosted by the app developers or someone who has access to the Firebase settings for that project. The FCM key under `rewrite.fcm` in the config file is this secret key.

### Gotify

This is primarily meant to be hosted on the same machine as the Gotify server. Running it on a different machine hasn't been tested yet but you can share information about that in this repo's issues.

## Gateway

A Gateway is meant to take push messages from an existing service, like Matrix and convert it to the UnifiedPush format. While Gateways are primarily meant to be hosted by the App Developer, some Gateways (like currently the only one, Matrix) support discovery on the push provider domain to find self-hosted gateways. It's always optional to host gateways as the app developer usually should have one.

### Matrix
Gateways matrix push until [MSC 2970](https://github.com/matrix-org/matrix-doc/pull/2970) is accepted.  
`["notification"]["devices"][0]["pushkey"]` is the UP endpoint this gateways to.

## Note
* Not all architectures in the releases have been tested.
