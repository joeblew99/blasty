# blasty



Here is the big picture flow. Its a CQRS system for FLutter and Microservices.
The FLow is:
1. The Flutter client makes a mutation and sents it back to the Server NATS --> ANY Read/ Write System that subscribes. It coudl be many R/W systems.
2. The ANY RW System does what it wants localy ( its has its own internal state ) and then updates our MiniSQL Read Store by sending CUD events --> NATS --> Minisql Store. 
3. The MiniSQL Store carries out the CRD OP, and sends CRD Events --> NATS --> Flutter.
4. Flutter slip streams the CRD Op into the View. 


Nice things:

Flutter only has Views, and zero state or data mapping to do.
A View in Flutter has a 1 to 1 mapping to a table in MiniSQL. 
It gets any changes and just slips streams them into the View.
It does not have to worry about any other view synchronisation at all. NONE.

Schema Evolution.
You can evolve your schema easily because different versions of clients can map to different buckets.
You NEVER retire a View.
The CUD Event handler of the ingestion layer just spits the data to all versions of the view. Its very simple.

It works for both internal and external microservices.
YOu can map any third party system into this. You dont have to reengineer anything.
The third party system just sends you the payload, and you write simple logic to put that into the MiniSQL store.
The third party system if its under your control, can calculate the CUD Ops and sent it onto your NATS router also.

The Client can be anything in this architecture.
- Any IOT device that wants a View of anything.
- Any Microservice dependent on you either internal or external.

Reporting and Analytics
You get this for free.

Scaling, Perf and HA
RPC has no guarantee that it wil arrive. You MUST have this with any streaming system liek this.
By mixing NATS and RPC, you get this guarantee easily and simply. 








