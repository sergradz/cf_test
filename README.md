## Architecture

I used nodejs server(written in coffeescript).

Consumer server (frontend_server.coffee) gets the message and sends it iron.io MQ. Definitely I didn't want to create
a wheel. And iron.io does all the job. Plus no need spend time for setup. In real world maybe I would change the queue
provider depends on real requirements.

Then worker.coffee fetches message from the queue. And handles it. I didn't want to be too fancy - so I just save it to
mongodb.

On frontend we have another nodejs server frontend_server.coffee that serves static /public/index.html page and
websocket connections via socket.io

In order to send handled message from worker to frontend I used socket.io-emitter with redis. Also potentially this
could help to serve multiple nodes for frontend server.

Although all components based on one sever. (I used EC2 micro instance for demo) all of them could work on different
servers.

* consumer server
* frontend server
* workers
* mongodb
* redis

Amount of workers could be different according to your needs. You also could setup load balancing to consumer server.

## Requirements

Redis - as a socket.io adapter
MongoDB - to store data

## Installation

* npm install
* cd public && bower install

### Run
coffee fronted_server.coffee - runs frontend
coffee gate_server.coffee - runs consumer server
coffee worker.coffee

### Testing
npm test - runs functional and unit tests in test ENV

coffee bin/generate_sample_data.coffee - will generate realistic data to gate server. I used only a few currency codes
for demo.

