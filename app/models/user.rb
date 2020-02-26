class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }


  def email_required?
    false
  end

  def email_changed?
    false
  end

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.search(search,condition)
    if search
      if condition == "1"
        User.where(['name LIKE ?', "#{search}"])
      elsif condition == "2"
        User.where(['name LIKE ?', "#{search}%"])
      elsif condition == "3"
        User.where(['name LIKE ?', "%#{search}"])
      elsif condition == "4"
        User.where(['name LIKE ?', "%#{search}%"])
      end
    else
      User.all
    end
  end


end
