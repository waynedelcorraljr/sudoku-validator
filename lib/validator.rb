require 'pry'

class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    # Start creating your solution here.
    #
    # It's likely that you'll want to have many more classes than this one that
    # was provided for you. Don't be hesistant to extract new objects (and
    # write tests for them).
    board = Board.new(@puzzle_string)
    
    if board.incomplete?
      return "This sudoku is valid, but incomplete."
    elsif board.rows_are_valid? && board.columns_are_valid? # board.subgroups_are_valid?
      return "This sudoku is valid."
    else
      return "This sudoku is invalid."
    end
    
  end

  class Board
    def initialize(board)
      @stripped_board = board.split(/\n/).map {|row_str| row_str.gsub(/[|]/, '')}.select {|row| !row.include?("-")}
      @rows =  @stripped_board.map {|row_str| row_str.split(' ').map(&:to_i)}
    end

    
    def incomplete?
      self.rows.flatten.include?(0) ? true : false
    end
    
    def rows_are_valid?
      self.rows.all? {|row| row == row.uniq} ? true : false
    end
    
    def columns_are_valid?
      self.columns.all? {|column| column == column.uniq} ? true : false
    end
    
    def subgroups_are_valid?
      return "This sudoku is invalid."
    end

    def rows
      @rows
    end

    def columns
      i = 0
      columns_array = []
      while i < 9
        columns_array << @rows.map {|el| el[i]}
        i += 1
      end
      columns_array
    end

    def subgroups

    end
  end

end
