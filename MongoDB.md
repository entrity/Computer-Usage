# MongoDB

## Quick commands
https://docs.mongodb.com/manual/reference/mongo-shell/
```js
show dbs
use <db>
show collections
show users
show roles
// Find last
db.rocketchat_message.find().sort({$natural:-1}).limit(1)
// Update one
db.collection.updateOne(
   { _id: "3sXWTENZAKtukrnXY" },
   { $set: { status: "D" }, $inc: { quantity: 2 } },
)
```
