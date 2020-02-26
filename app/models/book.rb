class Book < ApplicationRecord
	belongs_to :user
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
	validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search,condition)
    if search
      if condition == "1"
        Book.where(['title LIKE ?', "#{search}"])
      elsif condition == "2"
        Book.where(['title LIKE ?', "#{search}%"])
      elsif condition == "3"
        Book.where(['title LIKE ?', "%#{search}"])
      elsif condition == "4"
        Book.where(['title LIKE ?', "%#{search}%"])
      end
    else
      Book.all
    end
  end

end
