# story: as a user I am informed when I have picked two cards

# acceptance criteria:
# - When I pick two cards I see a message





# setup the cards
cards = [['a','*'],['b','*'],['a','*'],['b','*']] # setup the data structure

# setup the view
puts "welcome to Remory, a game of memory"        # print game header
view = cards.map(&:last)                          # setup game variables
showing = []

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

  # track the cards facing up
  showing.push(face)                              # track which cards are showing

  # check if we have a pair
  if showing.count == 2                           # if 2 cards are showing
    print "you picked 2 cards: "
    p showing
    showing.clear                                 # clear showing cards
  end
end
