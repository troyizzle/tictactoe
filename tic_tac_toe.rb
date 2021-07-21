class TicTacToe
  UNFINISHED_MESSAGE = "unfinished".freeze
  PLAYER_ONE = "x".freeze
  PLAYER_TWO = "o".freeze
  NO_GAME_BOARD_MESSAGE = "No game board".freeze
  INVALID_ROWS_MESSAGE = "Invalid rows".freeze
  INVALID_INPUT_MESSAGE = "Invalid input".freeze
  INVALID_ROW_LENGTH_MESSAGE = "Invalid row length".freeze

  def initialize(board)
    @board = board
    raise NO_GAME_BOARD_MESSAGE if @board.length.zero?
    raise INVALID_ROW_LENGTH_MESSAGE if @board.length.even?
    @row_length = @board.first.length
    map_board
  end

  def winner
    @inputs.each_value do |inputs|
      case inputs
      when winning_player_one_input then return PLAYER_ONE
      when winning_player_two_input then return PLAYER_TWO
      end
    end

    UNFINISHED_MESSAGE
  end

  private

  def winning_player_one_input
    PLAYER_ONE * @row_length
  end

  def winning_player_two_input
    PLAYER_TWO * @row_length
  end

  # Used to create a hash map of the board's inputs. The map's keys will look
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
      raise INVALID_ROWS_MESSAGE unless row.length == @row_length

      row.each_with_index do |input, row_index|
        raise INVALID_INPUT_MESSAGE unless valid_input?(input)

        add_input_to_map("row_#{index}", input)
        add_input_to_map("column_#{row_index}", input)
        next unless row_index == reverse_diagonal_position

        add_input_to_map("reverse_diagonal", input)
        reverse_diagonal_position -= 1
      end

      add_input_to_map("diagonal", row[index])
    end
  end

  def valid_input?(input)
    [PLAYER_ONE, PLAYER_TWO, ' '].include? input
  end

  def add_input_to_map(name, input)
    @inputs[name] ? @inputs[name] += input : @inputs[name] = input
  end
end
