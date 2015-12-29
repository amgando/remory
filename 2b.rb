# story (defect): as a user I can press enter (without a number) and the last card is flipped
# story (defect): as a user I can type text and the last card is flipped

# (after some investigation, these stories are likely related)

# acceptance criteria (fixed):
# - I can press enter (without a number) and nothing changes on the board
# - I can enter non-numeric text and nothing changes on the board
require 'sinatra'

set :cards, [['a','*'],['b','*'],['a','*'],['b','*']]              # setup the data structure
set :welcome, "welcome to remory, a ruby game of memory"           # print game header
set :view, settings.cards.map(&:last)                              # setup game variables



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

  headers "Refresh" => "1; /"

  output
end