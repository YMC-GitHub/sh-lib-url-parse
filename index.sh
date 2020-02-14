#!/bin/sh
: <<note
test="://"
e=$(awk -v a="$url" -v b="$test" 'BEGIN{print index(a,b)}')
protocl=${url:0:$e-1}
echo "$protocl"
note
function url_protocol() {
  local url=
  local protocol=
  url=""
  if [ "${1}" ]; then
    url="${1}"
  fi
  url=$(echo $url | sed "s,^\",,g" | sed "s,\"\$,,g")
  echo $url | grep "://" 1>/dev/null 2>&1
  if [ $? != 0 ]; then
    protocol=""
  else
    protocol=$(echo "$url" | sed "s,://.*,,g")
  fi
  echo "$protocol"
}
#function-usage
: <<note
url_protocol "$url" #it will return "http"
note

function url_host() {
  local arr=
  local url=
  local protocol=
  url=""
  if [ "${1}" ]; then
    url="${1}"
  fi
  url=$(echo $url | sed "s,^\",,g" | sed "s,\"\$,,g")

  protocol=$(url_protocol "$url")

  arr=$(echo "$url" | sed "s,$protocol://,,")
  # 去除查询
  arr=$(echo "$arr" | sed "s,^.*?,,")
  # 变成数组
  arr=(${arr//// })

  echo ${arr[0]} | grep ":" 1>/dev/null 2>&1
  if [ $? != 0 ]; then
    host=${arr[0]}
  else
    host=$(echo ${arr[0]} | sed "s/:.*//g")
  fi
  echo "$host"
}
#function-usage
: <<note
url_host "$url" #it will return "videomy.xx.com"
note

function url_port() {
  local arr=
  local url=
  local protocol=
  url=""
  if [ "${1}" ]; then
    url="${1}"
  fi
  url=$(echo $url | sed "s,^\",,g" | sed "s,\"\$,,g")
  protocol=$(url_protocol "$url")

  arr=$(echo "$url" | sed "s,$protocol://,,")
  # 去除查询
  arr=$(echo "$arr" | sed "s,^.*?,,")
  # 变成数组
  arr=(${arr//// })

  echo ${arr[0]} | grep ":" 1>/dev/null 2>&1
  if [ $? != 0 ]; then
    port="80"
  else
    port=$(echo ${arr[0]} | sed "s/^.*://g")
  fi
  echo "$port"
}
#function-usage
: <<note
url_port "$url" #it will return "8091"
url_port ":90" #it will return "90"
url_port "xx.com/xx/xx" #it will return "80"
note

function url_pathname() {
  local arr=
  local url=
  local protocol=
  local length=
  local i=
  local pathname=

  url=""
  if [ "${1}" ]; then
    url="${1}"
  fi
  url=$(echo $url | sed "s,^\",,g" | sed "s,\"\$,,g")

  protocol=$(url_protocol "$url")

  arr=$(echo "$url" | sed "s,$protocol://,,")
  # 去除查询
  arr=$(echo "$arr" | sed "s,^.*?,,")
  # 变成数组
  arr=(${arr//// })
  length=${#arr[@]}
  pathname=
  #((last = $length - 1))
  for ((i = 1; i < length; i++)); do
    pathname="${pathname}/${arr[i]}"
  done
  #pathname=$(echo "$pathname" | sed "s|^/||")
  echo "$pathname"
  #((last = $length - 1))
  #file=${arr[$last]}
  #echo "$file"
}
#function-usage
: <<note
url_pathname "$url" #it will return "/20200126/IPX-xx/index.m3u8"
note

function url_search() {
  local url=
  local query=
  url=""
  if [ "${1}" ]; then
    url="${1}"
  fi
  url=$(echo $url | sed "s,^\",,g" | sed "s,\"\$,,g")

  query=$(echo "$url" | sed "s,^.*?,,")
  if [ "$query" ]; then
    echo "?$query"
  else
    echo ""
  fi
}
#function-usage
: <<note
url="xx/xx/xx/?appid=aaaa&apidx=0"
url_search "$url" #it will return "?appid=aaaa&apidx=0"
note

#sed 's/.*'$2'=\([[:alnum:]]*\).*/\1/'
function parse_url_query() {
  local url=
  local query=
  url=""
  if [ "${1}" ]; then
    url="${1}"
  fi

  url=$(echo $url | sed "s,^\",,g" | sed "s,\"\$,,g")
  echo "$url" | sed 's/.*'$2'=\([[:alnum:]]*\).*/\1/'
}
#fuction-usage
: <<note
query="appid=aaaa&apidx=0"
value=$(parse_url_query $query "appid")
echo $value
note

# file-usage
# ./index.sh
# source ./index.sh
