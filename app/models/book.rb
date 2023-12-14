# == Schema Information
# Schema version: 20231213094225
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  cover_url   :string
#  editable    :boolean          default(FALSE)
#  name        :string           not null
#  slug        :string
#  words_count :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_books_on_slug     (slug) UNIQUE
#  index_books_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Book < ApplicationRecord
  extend FriendlyId
  has_many :words, dependent: :destroy, inverse_of: :book
  belongs_to :user, counter_cache: true
  has_one_attached :cover_url

  broadcasts_refreshes_to :user

  validates :name, presence: true
  normalizes :name, with: -> { _1.squish }

  friendly_id :name, use: :slugged
  after_initialize :calculate_words_count

  scope :ordered, -> { order(name: :desc) }
  scope :search, ->(q) {
    where(arel_table[:name].lower.matches("%#{q.downcase}%"))
  }

  def mastered_words_count
    words.where(status: 'mastered').count
  end

  def unmastered_words_count
    words.where(status: 'unmastered').count
  end

  def mastered_percentage
    return 0 if words_count.zero?

    (Float(mastered_words_count) / words_count) * 100
  end


  def calculate_words_count
    self.words_count = words.to_a.size
  end

  after_create do
    update_user_words_count(1)
  end

  after_destroy do
    update_user_words_count(-1)
  end

  private

  def update_user_works_count(value)
    user = User.find(book.user_id)
    user.words_count = (user.words_count || 0) + value
    user.save!
  end

end
