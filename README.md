Gestalt  [![Build Status](https://travis-ci.org/codingteam/Gestalt.png?branch=develop)](https://travis-ci.org/codingteam/Gestalt)
=======

This is Gestalt, a daemon that will track activity within your GitHub and
Bitbucket organization(s) and report summaries via RESTful API.

For detailed API description, please see [the draft on the project
wiki](https://github.com/codingteam/Gestalt/wiki/Public-API).

For copying terms, see LICENSE file.

# Building and running the service

You need the following installed in your system:

* [Erlang version 17 or above](erlang.org)
* [rebar](https://github.com/rebar/rebar/wiki/Getting-started#first-steps)

First of all, you need to create a config for the service. We provide an example
that you can copy and then edit:

    $ cp rel/files/app.config.example rel/files/app.config
    $ $EDITOR rel/files/app.config

Now run:

    # fetch the dependencies
    $ rebar get-deps
    # compile the source
    $ rebar compile

    # generate the release
    $ rebar generate
    # You might get "WARN:  'generate' command does not apply to directory XYZ"
    # It means you're running an older version of rebar. You can ignore the
    # warning, or you can cd into rel directory before running `rebar generate`.
    # See https://github.com/rebar/rebar/pull/254 for details

    # start the service
    $ ./rel/gestalt/bin/gestalt start
    # if the above fails, claiming that Gestalt "is not an erlsrv controlled
    # service", run the following instead:
    $ ./rel/gestalt/bin/gestalt install
    $ ./rel/gestalt/bin/gestalt start
    # or this:
    $ ./rel/gestalt/bin/gestalt console

You should now see Gestalt's public API responding at port 8080. You can also
check if the service is alive by pinging it:

    $ ./rel/gestalt/bin/gestalt ping

It's also possible to get a shell attached to the service:

    $ ./rel/gestalt/bin/gestalt attach

(Note: you can quit by pressing ^D.)

To stop the service, run:

    $ ./rel/gestalt/bin/gestalt stop
