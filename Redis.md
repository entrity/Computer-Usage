# Redis

```
keys * # lists all keys
scan 0 count 99 # returns the next cursor and an array of keys (doesn't lock)
type KEY # returns type of value
del KEY
```

**Sidekiq example**
```
keys *
type queues
smembers queues
type queue:default
lrange queue:default 0 -1
```

# Lists
lrange KEY 0 -1 # List list
ltrim KEY -1 0 # Truncate list

# Sets
smembers KEY # List set

# Sorted sets (zset)
zrange KEY START END
zscan KEY CURSOR [count COUNT] [match MATCH]
zadd KEY SCORE MEMBER [SCORE MEMBER...]

# Strings
get KEY
```

## Investigating, troubleshooting

```bash
redis-cli monitor # Good for sidekiq queue activity
```
