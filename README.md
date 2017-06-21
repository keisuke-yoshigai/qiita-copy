# DB設計

## users table
  deviseを用いて作成

| Column | Type |          Option          |
|:------:|:------:|:-------------------------|
| name | string | index: true, null: false, unique: true |
| first_name | string | |
| family_name | string | |
| site_url | text | |
| address | text | |
| self_introduction | text | |

### Association
* has_many :posts
* has_many :comments
* has_many :likes


## posts table
| Column |  Type  |          Option          |
|:------:|:------:|:-------------------------|
| title | string | index: true, unique: true, null: false |
| body | text | index: true, null:false, unique: true |
| image | text | |
| user_id | references | foreign_key: true |

### Association
* has_many :comments
* has_many :likes
* belongs_to :user


## comments table
| Column |  Type  |          Option          |
|:------:|:------:|:-------------------------|
| body | text | null: false |
| user_id | references | foreign_key: true |
| post_id | references | foreign_key: true |

### Association
* belongs_to :user
* belongs_to :post


## likes table
| Column |  Type  |          Option          |
|:------:|:------:|:-------------------------|
| user_id | references | foreign_key: true |
| post_id | references | foreign_key: true |

### Association
* belongs_to :user
* belongs_to :post
