# story (refactor): as a programmer of this system I want a more readable solution

# acceptance criteria:
# - the code is cleaner and more concise





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
  redirect '/' if settings.view[pos] != '*'                        # enforce a meaningful position


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
      settings.view.map! { |c| c == '*' ? c : '_' }               # clear matching cards
    else
      output += "but they're different."
      settings.view.map! { |c| c == '_' ? c : '*' }               # reset all but the cleared cards
    end

    settings.showing.clear                                         # clear showing cards
  end

  headers "Refresh" => "1; /"

  output
end


