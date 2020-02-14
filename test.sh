#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source "$THIS_FILE_PATH/index.sh"

function test() {
  local fn=
  local expectValue=
  local ouput=
  fn=${1}
  ouput=$($fn)
  expectValue=${2}
  echo "test:$fn"
  if [ "$ouput" = "$expectValue" ]; then
    echo "it is ok"
  else
    echo "it is false.expect $ouput = $expectValue"
  fi
}

## function usage
url="http://videomy.xx.com:8091/20200126/IPX-xx/index.m3u8"
test "url_protocol $url" "http"
test "url_host $url" "videomy.xx.com"
test 'url_port ":90"' "90"
test 'url_port "xx.com/xx/xx"' "80"
test "url_pathname $url" "/20200126/IPX-xx/index.m3u8"
url="xx/xx/xx/?appid=aaaa&apidx=0"
test "url_search $url" "?appid=aaaa&apidx=0"
query="appid=aaaa&apidx=0"
test "parse_url_query $query appid" "aaaa"

## file-usage
# ./test.sh
