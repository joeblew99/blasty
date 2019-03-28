# archi-frontend

GRPC is coming from the backend

# Slippy Stream Phase

two ways:
Server View Model maps to Client View Model = GRPC interface strongly typed
- this is used for common parts of the app like Longon etc

GRPC week typed for any data = View Models / Client Models

## RPC structure

- query Simple sql queryt ext
- query response: json data
- mutation: json
- subscription: same as query text
- note: enhancement for later this means we can use the equivalent of stored procedures for every possible query. These can be saved in the KV Store as meta data against each KV Bucket.
 - in this way the developer can just then use Named queries with params for the JSON query structure


## Sub Events

- The backend will send updates to the front end over GPRC stream.
- The user must keep a log of what sequence they are up to on the stream, so they can catchup.
- The event types are:  Create, Update, Delete with the Data as JSON.
- Queries:
	- E.g. "Select * from users where firstname = ged, order by DateCreated ascending".
	- So the backend will keep tabs on this and send all new users with that firstname.
	- The widgets need to then insert the data in the correct location in the List View.
	- the frontend must inject the new row in the correct place.
	- * to make it easy for the front end, the backend must give the Order sequence number, so the front end knows exactly where to inject it.
- Forms:
	- These do not need Subscriptions.

## Mutations

- This is just JSON data sent back
- The backend will handles these, and then many possible KV buckets will be updated, sending a stream of subscription events to the message queue.
- The frontend will recieve them as they navigate to different pages. In this way there is no need for the Front end to do any FLux Patterns


# Data Driven GUI Phase

At this stage the Data layer is all data driven.
Now we will make the Forms composition data driven.

HTML is used to describe the GUI.
https://pub.dartlang.org/packages/html
users: https://pub.dartlang.org/packages?q=dependency%3Ahtml

JSON is coming from the Data layer.

## Menu
This is just data with menu hardcoded.

- The data gives a name and a path to the route
- The router then navigates to the Virtual Page which typically is a Master List

## Master List
Then we need to do classic templating to merge the html and json.
For rows this would be 2 templates
1. The List html
2. The row html
The List widget would be designed for this.
It would be able to do sorting, etc. Sorting would be a new query

On clicking a row the router would navigate the user to the Detail Form.

## Detail Forms
For Forms it would be one template with:
1. Data driven validation
2. Other widgets for things like drop downs, etc









