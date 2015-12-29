# story: as a user I am prompted to match cards according to game rules

# acceptance criteria:
# - after entering a pair of numbers the board RESETs unmatched pairs
# - after entering a pair of numbers the board CLEARs matched pairs




require 'sinatra'

set :cards, [['a','*'],['b','*'],['a','*'],['b','*']]              # setup the data structure
set :welcome, "welcome to remory, a ruby game of memory"           # print game header
set :view, settings.cards.map(&:last)                              # setup game variables
set :showing, []


get '/' do
  output = "here is the board"                                     # user instructions
  output += "<br>"                                                 # newline

  output += settings.view.join(' | ')                              # print the board
  output += "<br><br>"                                             # newline

  output += "pick a number 1 - #{settings.cards.length}"           # prompt the user for input
  output += "<br>"                                                 # newline

  output += <<-HTML
  <form action="/play" method="post">
    <input type="text" name="input" placeholder="1 - 4" autofocus>
    <input type="submit">
  </form>
  HTML

  output
end

post '/play' do
  output = "here is the board"                                     # user instructions
  output += "<br>"                                                 # newline

  output += settings.view.join(' | ')                              # print the board
  output += "<br>"                                                 # newline

  input = params[:input]                                           # collect and clean user input
  pos = input.to_i - 1                                             # convert input to a number

  # bug fixes
  redirect '/' if input.empty?                                     # enforce a meaningful input
  redirect '/' unless (0...settings.cards.length).include? pos     # enforce a meaningful position


  face = settings.cards[pos].first                                 # extract card value
  settings.view[pos] = face                                        # save card value to view

  output += "<br>"
  output += "you flipped card #{input}"
  output += "<br>"
  output += settings.view.join(' | ')                              # print the board
  output += "<br>"

  # track the cards facing up
  settings.showing.push(face)                                      # track which cards are showing

  # check if we have a pair
  if settings.showing.count == 2                                   # if 2 cards are showing
    output += "you picked 2 cards: #{settings.showing.join(' and ')} ... "
    
    if settings.showing.first == settings.showing.last             # if they're the same card
      output += "and they match!"

      new_view = []                                                # create a new view
      settings.view.each do |card|                                 # iterate (loop) over the cards in the view
        if card == '*'                                             # if the card hasn't been flipped
          new_view.push(card)                                      # then leave it as is
        else
          new_view.push('_')                                       # otherwise clear it
        end
      end
      settings.view.replace(new_view)                              # replace the view with the new one

    else
      output += "but they're different."

      new_view = []                                               # create a new view
      settings.view.each do |card|                                # iterate (loop) over the cards in the view
        if card == '_'                                            # if the card has already been cleared
          new_view.push(card)                                     # then leave it as is
        else
          new_view.push('*')                                      # otherwise reset it
        end
      end
      settings.view.replace(new_view)                             # replace the view with the new one

    end

    settings.showing.clear                                         # clear showing cards
  end

  headers "Refresh" => "1; /"

  output
end





