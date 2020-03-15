class Item < ApplicationRecord
  belongs_to :category, dependent: :destroy, optional: true
  accepts_nested_attributes_for :category, allow_destroy: true
end
