# compute archi

Blasty

This is a better approach because each system has the RIGHT semantics.
We can get everything working between them with NATS.
Then wrap the whole things with GRPC - to be clear we are not using NATS for the clients.
- Really we ae using 

- Indexing
	- https://github.com/mosuka/blast
		- stores all data and replicates it
		- we will need NATS for joining up the various Services that do their distinct thing.
		- indexes and facets
			- use blast because it just works. Bleve is a beast to use.
			- It has GRPC interface so easy.
			- So users can do a global search and get back DocID, and then hit the Query system to get the actual data.
- Query
	- use https://github.com/minio/minsql
	- has sql syntax
		- https://github.com/minio/minsql#search-api
	- returns jsons
	- uses minio under the hood and so this can store blobs 8 images, files, etc)
		- so has replication and erasure encoding ( very important
	- no GPRC interface but thats life.
	- can can wrap theirs
	- Flutter clients use the GRPC OR Rest interface
	- has a Web gui :)
	- No subscriptions though !!
- Subscriptions
	- When a "Table" as they call it in minsql, we gen an event.
	- https://github.com/Preetam
		- Not that has has a new storage layer called Cantena that handle dedups for the events !!
	- https://github.com/Preetam/transverse
	- which uses:
		- Event Aggregation and indexing !
			- https://github.com/Cistern/cistern
		- storgae layer:
			- https://github.com/Preetam/lm2
				- The object storage layer designed for Logs and Ordering them in the Order they occur. Exactly what we need !
				- Can handle logs being out of order !
				- Has a sql like query language and so we can filter the Subscriptions :)
					- Hopefully similar to minsql.
		- Replication using S3 !
			- https://github.com/Preetam/rig/blob/master/objectstore.go#L12
			- SO we can just feed it into minsql ironically.
	- has a Web gui :)
- Mutations
	- minsql can do it if needed.
	- https://github.com/minio/minsql#ingesting-data

	
