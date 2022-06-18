# data-server

> @TODO maybe in addition to use fricctioness data import, we could use
>       sqlite directly. See https://superuser.com/questions/7169/querying-a-csv-file/891377#891377
> @TODO csvsql also allow query directly without load to SQLite or
>       something before. See https://csvkit.readthedocs.io/en/latest/scripts/csvsql.html

## PHP

```bash
php -S 127.0.0.1:1603 -t ./officina/
```

## Python

```bash
python3 -m http.server 1603 --bind 127.0.0.1 --directory ./officina/
```
