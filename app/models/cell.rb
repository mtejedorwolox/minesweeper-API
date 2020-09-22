class Cell < ApplicationRecord
  belongs_to :game

  enum state: %i[hidden flagged marked]

  default_scope { order(:row, :column) }
end
