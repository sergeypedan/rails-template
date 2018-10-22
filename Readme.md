# README

### Connect to hosting

```sh
ssh root@$CODE2TRAVEL_IP
```

### Go to project

```sh
cd "/var/www/code2travel.com/current"
```

### Source chruby

```sh
source "/etc/profile.d/chruby.sh"
```

### Precompile manually

```sh
bin/rails assets:precompile
```

## Puma

### Listen to logs

```sh
tail -f "/var/www/code2travel.com/shared/log/production.log"
tail -f "/var/www/code2travel.com/shared/log/puma.stdout.log"
tail -f "/var/www/code2travel.com/shared/log/puma.stderr.log"

tail -f "/var/www/code2travel.com/shared/log/sidekiq.log"
```

### Start / stop

```sh
pumactl --config "/var/www/code2travel.com/current/config/puma/production.rb" stop
pumactl --config "/var/www/code2travel.com/current/config/puma/production.rb" start
pumactl --config "/var/www/code2travel.com/current/config/puma/production.rb" restart
```

## NGINX

### Check NGINX config

```sh
cat /etc/nginx/sites-enabled/code2travel.com
```

### Status

```sh
systemctl status nginx
systemctl is-enabled nginx
systemctl is-active nginx
systemctl reload nginx
```

```sh
ps aux | grep nginx
```

### Start / stop

```sh
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
```

### Listen to logs

```sh
tail -f "/var/log/nginx/access.log"
tail -f "/var/log/nginx/error.log"
```

### Remove backups

```sh
rm -rf /var/www/code2travel.com/backups
```

## Check which process are using ports

```sh
lsof -wni tcp:80
lsof -wni tcp:443
lsof -wni tcp:3000
```
