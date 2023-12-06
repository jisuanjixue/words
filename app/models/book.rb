# == Schema Information
# Schema version: 20231206013124
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  cover_url   :string
#  editable    :boolean          default(FALSE)
#  name        :string           not null
#  words_count :integer
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
  belongs_to :user, counter_cache: true
  validates :name, presence: true
  normalizes :name, with: -> { _1.squish }

  scope :ordered, -> { order(name: :desc) }
  scope :search, ->(q) {
    where(arel_table[:name].lower.matches("%#{q.downcase}%"))
  }
end
