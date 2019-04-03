# v2 


The general demo plan assuming it works.

1. a CLI
- just pass in strings to get it doing pub sub between the topics.
 - that shows that it works.
 
2. gomobile compile the thing
- We may wish to embed the Golang GRPC bus client inside FLutter, and then pass events up to FLutter.
- The advantages are numberous. 
    - The way to do this is here: https://github.com/empirefox
- The other way is to see if we can codegen the art GRPC Client. Use this as a base: https://github.com/amsokol/flutter-grpc-tutorial. I am doubtful it will work.

3. Network
- Use inlets to proxy locally. See: https://github.com/alexellis/inlets
  - This allows running servers ANYWHERE. At home, in an office or on a cloud.
  - Stick Caddy behind inlets client on your laptop and you can run all your services behind that
  - We need an ETD. The Caddy runs a Dynamic DNS chekcer than tells ETCD your IP and if it changes and it updates the INlets Server that is in the cloud, so that it knows which IP address to direct traffic to reach you.

4. Embedding
There is a stong case for embedding Minio, minisql, inlets and Caddy all together.
NATS using file durability and NATS STreaming is a differnet API. Otherwise we coudl also embed NATS.
The use case for this is for very easy deployment for small projects. YOu dont need a public ETD server

5. Discovery.
- ETCD is the obvious choice. DNS also.
- THis tells everything everyone elses endpoints so they can all connect to each other over the network.




## THE STACK

### GRPC bus
https://github.com/uw-labs/proximo

https://github.com/uw-labs/proximo/tree/master/proximo-client


### Storage Server
https://github.com/minio/minsql
- Has sql
- Has HA
- Muation
  - Can easily have proximo call into it and out of it. Just on the way in for a mutation, check it works and then send the CRUD event back out on the topic.
- On Select, return the data and set a subscription for them.
- On Create, Update, Delete (CUD). We dont care about reads i think.
  - Send CUD event back out and let Proximo do the durable inbox to the correct clients Its all here.
  - docs: https://docs.min.io/docs/minio-bucket-notification-guide.html#NATS
  - example: https://github.com/minio/minio-go/blob/master/examples/minio/listenbucketnotification.go
  - BUT, we need to filter ( e.g Select * from Users where Firstname="ged" ). So if a users subscription matches the CUD event predicate, we know to push it up to them. 
  
### Indexing Server
https://github.com/mosuka/blast/

When a CRUD event occurs in minio, it wil be routed via NATS to BLast.
BLast can then grab the doc out of minio and index it.
Very simple.
It can then fire an IndexEvent for any interested subscribers. This is especially useful for Facets and Analytics.

 


## OS
ks3
- https://github.com/rancher/k3s
- This is maybe later, But its a lightwight K8.

## hardware
https://www.mininodes.com/product/5-node-raspberry-pi-3-com-carrier-board/
https://www.raspberrypi.org/products/compute-module-3/

## Hosting
Packet
- https://www.packet.com/cloud/servers/c1-large-arm/

Scaleway
- https://www.scaleway.com/



