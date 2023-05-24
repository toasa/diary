#!/bin/bash

# 今日の日記を作成するスクリプト。
# 通常は１日に一度実行する。
# 動作は macOS のみ確認済。

function getDayOfWeek () {
    dow=$(date "+%w")
    week=("日" "月" "火" "水" "木" "金" "土")
    echo "${week[$dow]}曜日"
}

DIARY_ROOT_PATH="."
Y=$(date "+%Y")
M=$(date "+%m")
D=$(date "+%d")

TODAY_DIARY="${DIARY_ROOT_PATH}/${Y}/${M}/${D}.md"

# 新年のディレクトリを作成
if [ ! -d "${DIARY_ROOT_PATH}/${Y}" ]; then
    mkdir ${DIARY_ROOT_PATH}/${Y}
    echo "Create a new year directory: ${Y}"
fi

# 新月のディレクトリを作成
if [ ! -d "${DIARY_ROOT_PATH}/${Y}/${M}" ]; then
    mkdir ${DIARY_ROOT_PATH}/${Y}/${M}
    echo "Create a new month directory: ${M}"
fi

# 作成する日記の中身
content=$(cat << EOF
### $(getDayOfWeek)

<img src="" width="500">

<img src="" width="700">

### Fragments

EOF
)

# 月末は歩数報告のセクションを追加
next_day=$(date -v+1d +%d)
if [ $next_day = "01" ];then
    content+=$(cat << "EOF"


### 今月の歩数

|||
|---|---|
|歩数|XXX|
|ハートポイント|YYY|
EOF
)
fi

# 今日の日記を作成
if [ ! -e ${TODAY_DIARY} ]; then
    echo "$content" > ${TODAY_DIARY}
    echo "Create new diary: ${TODAY_DIARY}"
else
    echo "Already exists!: ${TODAY_DIARY}"
fi