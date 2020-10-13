## Test mailers

You can preview emails with [`ActionMailer::Preview`](https://github.com/actionverb/files-rails#testing-mails). See [also](https://stackoverflow.com/a/42487750/507721).

At Files.com, we use https://github.com/actionverb/files-rails#testing-mails. Thjis solution is probably based on the gem [letter opener](https://github.com/ryanb/letter_opener)

Other "mail interceptors" exist.

## Misc

- Bullet - Notifies you in development when you have an `N+1` query problem.
- Commonmarkup - Renders markup as html
- Grape API - api framework
- factory_bot - build/create model instances for test/dev
- mini_record - allows for automatic migrations (no db migrations files)
- lograge & lograge-sql - create excellent logs
- Pry, rails-pry - debugger
- Redis - pub/sub
- Rubocop - Enforces style, lints ruby code
- Sidekiq - spawn/schedule background jobs and external tasks
- spork - holds rails process, ready to spin up a test or server or console quickly
- Swagger (swagger-grape) - automatically document api. can be used in conjunction with grape

## Ruby

Ruby environment managers:

- rbenv
- rvm

### Rbenv

#### System install [ref](https://blakewilliams.me/posts/system-wide-rbenv-install).

```bash
cd /usr/local
git clone git://github.com/sstephenson/rbenv.git rbenv
chgrp -R staff rbenv
chmod -R g+rwxXs rbenv
# Install ruby-build (a tool for installing rubies into rbenv)
cd /usr/local/rbenv
mkdir plugins
cd plugins
git clone git://github.com/sstephenson/ruby-build.git
chgrp -R staff ruby-build
chmod -R g+rwxs ruby-build
# Add system vars
cat <<-EOF > /etc/profile.d/rbenv.sh
export RBENV_ROOT=/usr/local/rbenv
export PATH="\$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOF
```

```bash
rbenv versions
rbenv version
rbenv install 2.6.6
rbenv shell [2.3.0] # Get/set current shell's ruby
rbenv local [2.7.1] # Get/set current dir's ruby
```

## Arel

### Update

Arel has an UpdateManager, but to get it to perform a join is convoluted and extremely poorly documented:

```ruby
s = Site.arel_table;
p = Plan.arel_table;
j = Arel::Nodes::JoinSource.new(s, [s.create_join(p)]);
u = Arel::UpdateManager.new;
u.table j;
u.set [[s[:campaign], p[:name]]];
puts(u.to_sql);
```

## Capistrano (deployment)

### List tasks
```bash
bundle exec cap -T
```

### Deploy to only select servers in a multi-server stage (as when using 3 servers for production)
```bash
HOSTS=66.228.51.251:4000 bundle exec cap production deploy
```

## Bundler

I've had a few problems with bundler, particularly when using rvm. _NB:_ if your app needs a particular version of bundler and you have one in a global/default gemset that is somehow interfering, it's insufficient to remove bundler using the usual commands. (I don't remember the right things to do, maybe `rvm gemset use global`, then uninstall 1.1.3 from global. You may need to downgrade rubygems too: `gem update --system 2.7.6`.)

### Run specific version of bundler

```bash
bundle _1.17.3_ -v # Bundler version 1.17.3
```

### Uninstall specific version of undler
`gem` may not remove your global bundler installation.
```bash
gem uninstall -i /usr/local/rvm/gems/ruby-2.3.0@global bundler -v 2.1.4
```

### "Could not fetch specs from http://rubygems.org/"
If bundler complains that it can't access rubygems.org, disable IPv6:
```bash
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1 # This was actually unnecssary for me; the previous command changed this value too.
```
