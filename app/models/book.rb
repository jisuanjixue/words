# == Schema Information
# Schema version: 20231208084152
#
# Table name: books
#
#  id         :bigint           not null, primary key
#  cover_url  :string
#  editable   :boolean          default(FALSE)
#  name       :string           not null
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
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
  belongs_to :user, counter_cache: false
  has_one_attached :cover_url

  broadcasts_refreshes_to :user

  validates :name, presence: true
  normalizes :name, with: -> { _1.squish }

  friendly_id :name, use: :slugged

  scope :ordered, -> { order(name: :desc) }
  scope :search, ->(q) {
    where(arel_table[:name].lower.matches("%#{q.downcase}%"))
  }

end
