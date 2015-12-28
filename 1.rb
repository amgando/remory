# story: as a user I can play one round of Remory

# acceptance criteria:
#   - I can see a board
#   - all cards are face down
#   - I can enter a number
#   - the board displays the card in the respective slot

require 'sinatra'

# setup the cards
set :cards, [['a','*'],['b','*'],['a','*'],['b','*']]    # setup the data structure

# setup the view
set :welcome, "welcome to remory, a ruby game of memory" # display game header
set :view, settings.cards.map(&:last)                    # setup game variables

get '/'do
  output = "here is the board"                            # display round header
  output += "<br>"                                        # newline
  output += settings.view.join(' | ')                     # display the board
  output += "<br><br>"                                    # 2 newlines
  output += "pick a number 1 - #{settings.cards.length}"  # prompt the user for input
  output += <<-HTML
  <form action="/play" method="post">
    <input type="text" name="input" placeholder="1 - 4" autofocus>
    <input type="submit">
  </form>
  HTML

  output
end

post '/play' do
  output = "here is the board"                            # display round header
  output += "<br>"                                        # newline
  output += settings.view.join(' | ')                     # display the board
  output += "<br>"                                        # newline

  input = params[:input]                                  # collect user input
  pos = input.to_i - 1                                    # convert input to a number

  # apply the input
  face = settings.cards[pos].first                         # extract card value
  settings.view[pos] = face                                # save card value to view

  # show the result
  output += "<br>"
  output += "you flipped card #{input}"
  output += "<br>"
  output += settings.view.join(' | ')                      # display the board

  output
end
