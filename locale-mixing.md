# Setting different locales for System

## Enabling locales

Enable the locales:

```shell
sudo nano /etc/locale.gen
```

Uncomment any locales you want to use, e.g. 

```shell
en_US.UTF-8 UTF-8
nb_NO.UTF-8 UTF-8
```

Update the locale generation:

```shell
sudo locale-gen
```

## Setting the locales

Edit the locale file

```shell
sudo nano /etc/locale.conf
```

Add the following lines:

```shell
LANG=en_US.UTF-8
LC_TIME=nb_NO.UTF-8
LC_MONETARY=nb_NO.UTF-8
LC_NUMERIC=nb_NO.UTF-8
```
The above config applies:

- Language: en US
- Time: Norwegian
- Currency: Norwegian
- Numbers: Norwegian
