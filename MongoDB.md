# MongoDB
https://docs.mongodb.com/manual/reference/mongo-shell/

## Example commands
```js
show dbs
use <db>
show collections
show users
show roles
```
## Example FIND queries
```js
// Find last
db.rocketchat_message.find().sort({$natural:-1}).limit(1)
// Select only certain fields
db.rocketchat_message.find({}, {ts:1, msg:1})
// De-select only certain fields
db.rocketchat_message.find({}, {_id:0, channels:0})
// Pretty-print
db.rocketchat_message.find({}).toArray()
// Find by regex
db.rocketchat_message.find({msg: /happ.ness/})
// Find by nested field
db.rocketchat_message.find({"u.username": "Insureio.bot"})
```

## Example UPDATE queries
```js
// Update one
db.collection.updateOne(
   { _id: "3sXWTENZAKtukrnXY" },
   { $set: { status: "D" }, $inc: { quantity: 2 } },
)
```
