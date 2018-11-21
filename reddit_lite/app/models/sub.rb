class Sub < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :moderator,
    foreign_key: :moderator_id,
    class_name: :User

  has_many :post_subs

  has_many :posts,
    through: :post_subs,
    source: :post

  def ensure_moderator
    redirect_to subs_url unless @current_user == self.moderator
  end
end
