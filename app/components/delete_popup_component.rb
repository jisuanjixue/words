# frozen_string_literal: true

class DeletePopupComponent < ViewComponent::Base
  def initialize(objects:)
    @objects = objects
  end
end
