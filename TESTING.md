# kontextwork-base

## Run tests

```bash
chef exec kitchen test
```

### Run tests during development

```
# setup all the boxes
chef exec kitchen converge default

# now run this again and again while fixing the tests or run converte + verify if 
# you fixed the recipes
chef exec kitchen verify default
```

### Only specific platforms

```bash
#only debian buster
chef exec kitchen converge default-eugenmayer-debian10

#only debian stretch
chef exec kitchen converge default-eugenmayer-debian9
s```
