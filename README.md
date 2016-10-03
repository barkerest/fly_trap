## README

The `fly_trap` app is just a very simple catch-all for the root of a webserver.

If it is configured to respond to raw IP requests with no domain name provided, then you can
figure out who is accessing the site legitimately and who is just scanning for vulnerabilities.

In some instances, you will want to "prime" the system by pinging your own webserver to keep
the rails app alive.  The easiest way to do that is with a crontab entry that polls the `ping_url`.

The `ping_url` is defined in the `routes.rb` configuration file with a psuedo-random string.
The default is "ft-h1CobSYEyW9S", but you can, and probably should, change that to something
else.

