# Troubleshooting MySQL / MariaDB

---
> Specified key was too long; max key length is 767 bytes
On a varchar or bigchar, the column max length may exceed innodb's index key limit of 767 bytes. If the encoding is utf8mb4, a `varchar(255)` could potentially entail a key of 1020 bytes (255 * 4).

**Solution 1**
```sql
ALTER DATABASE `dr-test` CHARACTER SET utf8 COLLATE utf8_general_ci;
```

**Solution 2** Specify a max _length_ for the key, e.g.
```sql
create index `foo` on addresses ( street(191) );
```
```ruby
# In Ruby on Rails:
add_index "addresses", ["street"], name: "foo", length: 191
# Or
add_index "addresses", ["street", "state_id"], name: "foo", length: {"street"=>191}
```
