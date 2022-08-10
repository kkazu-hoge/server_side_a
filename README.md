# README

## 前提環境
AWSのEC2にて動作確認しております。<br>
サーバ：EC2<br>
OS：Amazon Lnux2

↓以下AMIを利用しインスタンス立ち上げ<br>
Amazon Linux 2 AMI (HVM) - Kernel 5.10,<br>
SSD Volume Type<br>
ami-0ecb2a61303230c9d (64 ビット (x86))<br> 
※ストレージサイズは10GB程度で設定ください。(使用は4GB程度)

他：Gitインストール済の想定
```
$ sudo yum install git
```

## 確認手順

①「git clone」でEC2へ「server_side_a」をダウンロード（/home/ec2-user直下）
```
$ git clone https://github.com/kkazu-hoge/server_side_a.git
```

②環境構築用のスクリプトを実行する（時間がかかりますので少しお待ちください）
```
$ cd server_side_a
$ mv rails_build.sh ..
$ cd ..
$ sh rails_build.sh
```

③gemをインストール
```
$ bundle install
```

④マイグレーション
```
$ rails db:migrate
```

⑤railsサーバ起動
```
$ rails s
```

⑥welcomeページの確認<br>
【url】http://127.0.0.1:3000/
<br>※1 エディター(VScode)のremote sshプラグインでpuma(web/apサーバ)を起動しているリモートポート(127.0.0.1(localhost):3000)を<br>
ローカルアドレス(127.0.0.1(localhost):3000)へ転送しています。(ポートフォワーディング)


⑦APIの動作確認(POST)　※postmanで確認<br>
【httpメソッド】POST

【url】http://localhost:3000/api/ver1/items
※1 <br>
【body】(json)
```
{
  "name": "apple",
  "price": 200
}
```

【response例】
```
{
    "status": "SUCCESS",
    "message": "Saved item",
    "data": {
        "id": 1,
        "name": "apple",
        "price": 200,
        "created_at": "yyyy-mm-ddThh:mm:ss.xxxZ",
        "updated_at": "yyyy-mm-ddThh:mm:ss.xxxZ"
    }
}
```

⑧itemsテーブルに格納したデータを確認<br>
【httpメソッド】GET

【url】http://localhost:3000/api/ver1/items
※1 <br>
【response例】
```
{
    "status": "SUCCESS",
    "message": "Get items",
    "data": [
        {
            "id": 1,
            "name": "apple",
            "price": 200,
            "created_at": "yyyy-mm-ddThh:mm:ss.xxxZ",
            "updated_at": "yyyy-mm-ddThh:mm:ss.xxxZ"
        }
    ]
}
```

⑨確認後はrailsサーバーを停止ください<br>
　「ctrl+c」
