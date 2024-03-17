# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
trello_client = TrelloWrapper.new

trello_client.lists.each do |list|
  db_list = List.find_or_create_by(name: list.name, trello_id: list.id)

  trello_client.cards(list).each do |card|
    Card.find_or_create_by(name: card.name, trello_id: card.id, list: db_list, description: card.desc)
  end
end
