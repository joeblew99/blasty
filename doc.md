
Stack
------

What are we proving ?

A User maps to different KV Stores
- A KV Bucket maps one to one to a NATS topic. Nice and easy.

A User has many devices and each of those are at differrnt states in their LOG subscription. A User adds new devices all the time.
- Will nats cope with this. Can channels be used and are they per device ? Can the subscription LOG be used by the same users many devices and NATS can know what data to delete after its ACKed ?
 - All this is up for grabs !
 
User Security. A Usere has a user ID, and so we need to filter what NATS topic, and hence what updates they can get.

User Query - Same goes for Query to the KV bucket when the user first starts up each time. 
 - User client holds NO durable state btw.
 - so when it goes to each Page, if it has no Subscription Log saved it queries the KV first, an then subscribed to updates.

User Mutation is outbound.
- Goes to Blasty and onto NATS topic , which checks security ( of course), and blasts it across to THIRD PARTY SERVER by whatver API then want.
- THIRD PARTY does whatever it needs to do and then using the GRPC Client API, pushes data to their respective Blasty KV store.



Use Case chat.

Basis:
https://github.com/googleapis/gnostic

https://github.com/amsokol/flutter-grpc-tutorial


Golang Test Client with CLI
- allow it to assume different user ID. Forget auth, etc for now.
- allow it to assume many devices by just running more than one in your bash terminal. Is good enough.
- it has no storage except maybe where it is up to in the LOG subscription.
- Communicates with NATS go cletn for now. SO its easy and quick to test our assertions.

Golang Server 
- with basic CMD cli to kick it off.
- Blast NOT underneath it for now.
- NATS Streaming. We need streaming so we get durable queues.
