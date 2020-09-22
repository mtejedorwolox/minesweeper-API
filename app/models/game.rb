class Game < ApplicationRecord
  has_many :cells

  accepts_nested_attributes_for :cells

  before_save :build_cells

  validates :rows, :columns, presence: true, numericality: { only_integer: true,
                                                             greater_than: 0,
                                                             less_than_or_equal_to: 100 }

  validates :mines, presence: true,
                    numericality: { only_integer: true,
                                    greater_than: 0,
                                    less_than: ->(game) { game.rows * game.columns } }

  def build_cells
    cells_hashes = (0..(rows*columns-1)).map do |pos|
      { row: pos / rows,
        column: pos % columns }
    end.shuffle
    (1..mines).each { |mine| cells.build(cells_hashes.pop.merge(mine: true)) }
    cells.build(cells_hashes)
    cells.each do |cell|
      cell.value = cells.select do |x|
        x.row >= cell.row-1 && x.row <= cell.row+1 &&
        x.column >= cell.column-1 && x.column <= cell.column+1
      end.map(&:mine)
         .reduce(0) { |acc, x| acc + (x ? 1 : 0) }
    end
  end
end

