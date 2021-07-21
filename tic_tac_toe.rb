class TicTacToe
  TIE_MESSAGE = 'unfinished'.freeze
  PLAYER_ONE = 'x'.freeze
  PLAYER_TWO = 'o'.freeze

  def initialize(board)
    @board = board
    raise "No game board" if @board.length.zero?

    @row_length = @board.first.length
  end

  def winner
    map_board
    winning_message = ''

    @inputs.each_value do |inputs|
      case inputs
      when winning_player_one_input then winning_message = PLAYER_ONE
      when winning_player_two_input then winning_message = PLAYER_TWO
      end
    end

    winning_message.empty? ? TIE_MESSAGE : winning_message
  end

  private

  def winning_player_one_input
    PLAYER_ONE * @row_length
  end

  def winning_player_two_input
    PLAYER_TWO * @row_length
  end

  # Used to create a hash map of the board's inputs. The map's keys should look
  # like { row_x, column_x, diagonal, reverse_diagonal } and store the values.
  # Example with the following board would return
  #   {
  #     'row_0' => 'ooo',
  #     'row_1' => 'oxx',
  #     'row_2' => 'xoo',
  #     'column_0' => 'oox',
  #     'column_1' => 'oxo',
  #     'column_2' => 'oxo',
  #     'reverse_diagonal' => 'oxo',
  #     'diagonal' => 'xxo'
  #   }
  #
  #   ['o', 'o', 'o'],
  #   ['o', 'x', 'x'],
  #   ['x', 'o', 'o']
  #
  def map_board
    @inputs = {}
    reverse_diagonal_position = @row_length - 1

    @board.each_with_index do |row, index|
      row.each_with_index do |input, row_index|
        add_input_to_map("row_#{index}", input)
        add_input_to_map("column_#{row_index}", input)
        next unless row_index == reverse_diagonal_position

        add_input_to_map("reverse_diagonal", input)
        reverse_diagonal_position -= 1
      end

      add_input_to_map("diagonal", row[index])
    end
  end

  def add_input_to_map(name, input)
    @inputs[name] ? @inputs[name] += input : @inputs[name] = input
  end
end
