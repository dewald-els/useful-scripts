# Editing Apt Sources

This is related to Debian based systems (I think).

## Remove a custom source from APT

List files in the sources directory to identify the correct file: 
```
ls /etc/apt/sources.list.d/.
```

Delete the file associated with the repo: 

```
sudo rm /etc/apt/sources.list.d/filename.list.
```

Update APT 

```
sudo apt update
```

## Remove a default source

Edit the main file: 
```
sudo nano /etc/apt/sources.list 
```

> Add a hash-bang `#` to the beginning of the line to comment it out.

Don't forget to update: 

```
sudo apt update
```