# archi-frontend

GRPC is coming from the backend

two ways:
Server View Model maps to Client View Model = GRPC interface strongly typed
- this is used for common parts of the app like Longon etc

GRPC week typed for any data = View Models / Client Models
- query Simple sql querytext
- query response: json data
- mutation: json
- subscription: same as query text
- * note: this means we can use the equivalent of stored procedures for every possible query. These can be saves in the KV Store
 - in this way the developer can just then use Named queries with params for the JSON query structure


Sub Events
- The backend will send updates to the front end over GPRC
- The user must keep a log of what sequence they are up to on the stream, so they can catchup.
- These are Create, Update, Delete with the Data as JSON.
- The widgets need to then insert the data in the correct location in the List View
- E.g. "Select * from users where firstname = ged, order by DateCreated ascending"
 - So the backend will keep tabs on this and send all new users with that firstname
 - the frontend must inject the new row in the correct place.
 - * to make it easy for the front end, the backend must give the Order sequence number, so the front end knows exactly where to inject it.
