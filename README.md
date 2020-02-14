# sh lib url parse

## desc

like nodejs lib 'url'

## feat
- support protocol
- support host
- support port
- support pathname
- support search


## how to use for poduction?

```sh
# get the code

# run the index file
# ./index.sh

# or import to your sh file
# source /path/to/the/index file

# usage
url="http://videomy.xx.com:8091/20200126/IPX-xx/index.m3u8"
url_protocol "$url" #it will return "http"
url_host "$url" #it will return "videomy.xx.com"
url_port "$url" #it will return "8091"
url_port ":90" #it will return "90"
url_port "xx.com/xx/xx" #it will return "80"
url_pathname "$url" #it will return "/20200126/IPX-xx/index.m3u8"
url="xx/xx/xx/?appid=aaaa&apidx=0"
url_search "$url" #it will return "?appid=aaaa&apidx=0"
query="appid=aaaa&apidx=0"
parse_url_query $query "appid" #it will return "aaaa"

```

## how to use for developer?

```sh
# get the code

# run test
./test.sh
#2 get some fail test
./test.sh | grep "it is false"
```

## author

yemiancheng <ymc.github@gmail.com>

## license

MIT