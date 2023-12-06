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
require 'rails_helper'

RSpec.describe Book do
  pending "add some examples to (or delete) #{__FILE__}"
end
