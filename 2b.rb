# story (defect): as a user I can press enter (without a number) and the last card is flipped
# story (defect): as a user I can type text and the last card is flipped

# (after some investigation, these stories are likely related)

# acceptance criteria (fixed):
# - I can press enter (without a number) and nothing changes on the board
# - I can enter non-numeric text and nothing changes on the board

# setup the cards
cards = [['a','*'],['b','*'],['a','*'],['b','*']] # setup the data structure

# setup the view
puts "welcome to Remory, a game of memory"        # print game header
view = cards.map(&:last)                          # setup game variables

loop do
  # show the board
  puts
  puts "-" * 20                                   # print round header
  puts "here is the board"
  puts view.join(" | ")                           # print the board
  puts "pick a number 1 - #{cards.length}"        # prompt the user for input

  # collect the input
  input = gets.chomp                              # collect and clean user input
  pos = input.to_i - 1                            # convert input to a number

  # bug fixes
  next if input.empty?                            # enforce a meaningful input
  next unless (0...cards.length).include? pos     # enforce a meaningful position

  # apply the input
  face = cards[pos].first                         # extract card value
  view[pos] = face                                # save card value to view

  # show the result
  puts "you flipped card #{input}"
  puts view.join(" | ")                           # print the board
end
