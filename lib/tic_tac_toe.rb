WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board)
  puts " #{board[0]} " "|" " #{board[1]} " "|" " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " "|" " #{board[4]} " "|" " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " "|" " #{board[7]} " "|" " #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, x_o)
  board[position] = x_o
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, 8) && !(position_taken?(board, index))
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn = 0
  board.each do |position|
    if position != " "
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  if turn_count(board) % 2 != 0
     return "O"
  else
     return "X"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |winning_positions|
    if winning_positions.all? {|game_square| board[game_square] == "X"} || winning_positions.all? {|game_square| board[game_square] == "O"}
       return winning_positions
    end
  end
   false
end

def full?(board)
  board.none? {|game_square| game_square == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    return true
  end
end

def winner(board)
  if !won?(board)
      return nil
  elsif board[won?(board)[0]] && board[won?(board)[1]] && board[won?(board)[2]] == "X"
      return "X"
  elsif board[won?(board)[0]] && board[won?(board)[1]] && board[won?(board)[2]] == "O"
      return "O"
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if winner(board) == "X"
    return puts "Congratulations X!"
  elsif winner(board) == "O"
    return puts "Congratulations O!"
  elsif draw?(board)
    return puts "Cat's Game!"
  end
end
