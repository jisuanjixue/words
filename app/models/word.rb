# == Schema Information
# Schema version: 20231208053214
#
# Table name: words
#
#  id               :bigint           not null, primary key
#  definition       :text
#  example_sentence :text
#  name             :string
#  pronunciation    :string
#  slug             :string
#  status           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  book_id          :bigint           not null
#
# Indexes
#
#  index_words_on_book_id  (book_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#
class Word < ApplicationRecord
  extend FriendlyId
  belongs_to :book, touch: true, counter_cache: true
  has_one :user, through: :book
  has_rich_text :definition
  has_rich_text :example_sentence

  broadcasts_refreshes_to :user

  enum status: {  unmastered: 0, mastered: 1 }

  friendly_id :name, use: :slugged

  validates :name, presence: true
  normalizes :name, with: -> { _1.squish }

  after_initialize :set_default_status, if: :new_record?

  after_create do
    user = User.find(book.user_id)
    user.words_count = (user.words_count || 0) + 1
    user.save!
  end

  after_destroy do
    user = User.find(book.user_id)
    user.words_count = (user.words_count || 0) - 1
    user.save!
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name definition] # replace with your actual Word attributes
  end


  private

  def set_default_status
    self.status ||= :unmastered
  end
end
