# == Schema Information
# Schema version: 20231206030451
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  cover_url   :string
#  editable    :boolean          default(FALSE)
#  name        :string           not null
#  words_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_books_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Book < ApplicationRecord
  broadcasts_refreshes
  belongs_to :user, counter_cache: false

  has_one_attached :cover_url

  validates :name, presence: true
  normalizes :name, with: -> { _1.squish }

  scope :ordered, -> { order(name: :desc) }
  scope :search, ->(q) {
    where(arel_table[:name].lower.matches("%#{q.downcase}%"))
  }
end