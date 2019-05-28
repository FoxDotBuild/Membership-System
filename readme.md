# Makerspace Utility

A collection of tools that are useful for managing a makerspace. This app is currently in use by [Fox.Build Makerspace](https://fox.build/).

## Attendance Tracker

:point_right: [Demo App](https://xp-system.herokuapp.com/)

Awards members points for unlocking the door via Kisi (max: 60 points per 6 hour window).

## Guest Book

:point_right: [Demo App](https://xp-system.herokuapp.com/guest_book_entries/new).

Gets the name and email of visiting guests.

# Deploying to a Makerspace

 If you would like to host the app for use at your organization, perform the following:

1. Click this button: [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy).
2. Create a [Slack Webhook](https://api.slack.com/incoming-webhooks#create_a_webhook).
3. Change the `SLACK_URL` environment variable in the [Heroku Dashboard](https://devcenter.heroku.com/articles/config-vars#using-the-heroku-dashboard). **Use your Slack Webhook URL from step 2.**
4. Visit the `/guest` URL of your Heroku instance.

# Local Setup

Please see `example.env` if you want to run this on a local machine. Rick has not yet written docs for this, but can on request.
