# story: as a user I can play one round of Remory

# acceptance criteria:
#   - I can see a board
#   - all cards are face down
#   - I can enter a number
#   - the board displays the card in the respective slot


# setup the cards
cards = [['a','*'],['b','*'],['a','*'],['b','*']] # setup the data structure

# setup the view
puts "welcome to Remory, a game of memory"        # print game header
view = cards.map(&:last)                          # setup game variables

# show the board
puts
puts "-" * 20                                     # print round header
puts "here is the board"
puts view.join(" | ")                             # print the board
puts "pick a number 1 - #{cards.length}"          # prompt the user for input

# collect the input
input = gets.chomp                                # collect and clean user input
pos = input.to_i - 1                              # convert input to a number

# apply the input
face = cards[pos].first                           # extract card value
view[pos] = face                                  # save card value to view

# show the result
puts "you flipped card #{input}"
puts view.join(" | ")                             # print the board
