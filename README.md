# README

AWSのEC2にて動作確認しております。

##【前提環境】
サーバ：EC2
OS：Amazon Lnux2

↓以下AMIを利用しインスタンス立ち上げ
Amazon Linux 2 AMI (HVM) - Kernel 5.10,
SSD Volume Type
ami-0ecb2a61303230c9d (64 ビット (x86)) 
※念のためストレージサイズは15GBで設定ください。

他：Gitインストール済の想定
($ sudo yum install git)

##【確認手順】

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

⑥welcomeページの確認
ブラウザでご確認ください。
URL：http://127.0.0.1:3000/


⑦APIの動作確認(POST)　※自身はpostmanで確認
【httpメソッド】
　POST

【url】
　http://localhost:3000/api/ver1/items

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

⑧itemsテーブルに格納したデータを確認
【httpメソッド】
　GET

【URL】
　http://localhost:3000/api/ver1/items

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

⑨確認後はrailsサーバーを停止ください
「ctrl+c」