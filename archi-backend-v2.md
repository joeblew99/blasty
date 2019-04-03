# v2 

## Validation

- Check that proximo works with a simple untyped cli where you pass in strings
- Use inlets to proxy locally. Is faster to test.https://github.com/alexellis/inlets
- Check you can stil gen a client. For examle in Dart. Use this as a base: https://github.com/amsokol/flutter-grpc-tutorial
 - If we cant gen clients then i have to embed the golang client insie flutter using gomobile and empire fox: https://github.com/empirefox

- Not sure what else yet.

## Code

### GRPC bus
https://github.com/uw-labs/proximo

https://github.com/uw-labs/proximo/tree/master/proximo-client

The general demo plan assuming it works

1. a CLI
- just pass in strings to get it doing pub sub between the topcis.
 - that shows that it works
 
2. gomobile compile the thing
- i need to the client inside flutter. The reason is because this thing 

### Server
https://github.com/minio/minsql
- Has sql
- Has HA
- Muation
  - Can easily have proximo call into it and out of it. Just on the way in for a mutation, check it works and then send the CRUD event back out on the topic.
- Select
  - Send CRUD event back out and let Proximo do the durable inbox to the correct clients Its all here: https://docs.min.io/docs/minio-bucket-notification-guide.html#NATS
- Subscription on Select
  - We need to filter ( e.g Select * from Users where Firstname="ged ). SO we need to apply the predicate on the events being fired to the clients. Make sense !!!
  
### Indexing Server
https://github.com/mosuka/blast/

When a CRUD event occurs in minio, it wil be routed via NATS to BLast.
BLast can then grab the doc out of mini and index it.
Very simple.
It can then fired an IndexEvent for any interested subscribes to get.

 


## OS
ks3
- https://github.com/rancher/k3s

## hardware
https://www.mininodes.com/product/5-node-raspberry-pi-3-com-carrier-board/
https://www.raspberrypi.org/products/compute-module-3/

## Hosting
Packet
- https://www.packet.com/cloud/servers/c1-large-arm/

Scaleway
- https://www.scaleway.com/



