
require 'open-uri'
require 'nokogiri'

User.destroy_all
Profile.destroy_all
Game.destroy_all
Availability.destroy_all
Order.destroy_all
OwnerReview.destroy_all
PlayerReview.destroy_all

user1 = User.create!(email: 'audrey@gmail.com', password: '123456')
user2 = User.create!(email: 'helene@gmail.com', password: '123456')
user3 = User.create!(email: 'mary@gmail.com', password: '123456')
user4 = User.create!(email: 'gwen@gmail.com', password: '123456')
user5 = User.create!(email: 'claire@gmail.com', password: '123456')
user6 = User.create!(email: 'clementine@gmail.com', password: '123456')
user7 = User.create!(email: 'julie@gmail.com', password: '123456')
user8 = User.create!(email: 'sophie@gmail.com', password: '123456')
user9 = User.create!(email: 'laetiticia@gmail.com', password: '123456')
user10 = User.create!(email: 'marion@gmail.com', password: '123456')

PROFILE1 = Profile.create!(first_name: 'Audrey', last_name: 'Lewagon', address: '62 Rue de Gand, 59000 Lille', phone_number: '0386941029', user: user1)
PROFILE2 = Profile.create!(first_name: 'Helene', last_name: 'Letrain', address: '40 Rue Saint-Sébastien, 59000 Lille', phone_number: '0386941525', user: user2)
PROFILE3 = Profile.create!(first_name: 'Mary', last_name: 'Lecharbon', address: '104 Rue Saint-André, 59000 Lille', phone_number: '0386941526', user: user3)
PROFILE4 = Profile.create!(first_name: 'Gwen', last_name: 'Lagare', address: '67 Rue de la Monnaie, 59000 Lille', phone_number: '0386941528', user: user4)
PROFILE5 = Profile.create!(first_name: 'Claire', last_name: 'Laplace', address: '41 Rue Taitbout, 75009 Paris', phone_number: '0386941521', user: user5)
PROFILE6 = Profile.create!(first_name: 'Clémentine', last_name: 'Lebillet', address: '10 Avenue d\'Iéna, 75116 Paris', phone_number: '0386941522', user: user6)
PROFILE7 = Profile.create!(first_name: 'Julie', last_name: 'Lalocomotive', address: '6 Rue Balzac, 75008 Paris', phone_number: '0386941523', user: user7)
PROFILE8 = Profile.create!(first_name: 'Sophie', last_name: 'Letégévé', address: ' 3 Rue Sainte-Catherine, 54000 Nancy', phone_number: '0386941524', user: user8)
PROFILE9 = Profile.create!(first_name: 'Laeticia', last_name: 'Lesrails', address: '7 Rue Gustave Simon, 54000 Nancy', phone_number: '0386941520', user: user9)
PROFILE10 = Profile.create!(first_name: 'Marion', last_name: 'Lavoiture', address: '10 Rue Saint-Michel, 54000 Nancy', phone_number: '0386941525', user: user10)

def parse_fnac(game_type)
  url = "http://www.fnac.com/n142414/Jeux-de-societe/#{game_type}?ItemPerPage=20&SDM=list"
  doc = Nokogiri::HTML(open(url), nil, 'utf-8')
  doc.search('.Article-item').each do |element|
    name = element.css('.Article-infoContent .Article-desc a').text
    average_duration = 10
    description = ['Ce jeu mélange l\'univers des nains et des princesses', 'Ce jeu mélange l\'univers des enfants et des monsieurs',
      'Ce jeu mélange l\'univers des caniches et des chats mouillés'].sample
    profile = [PROFILE1, PROFILE2, PROFILE3, PROFILE4, PROFILE5, PROFILE6, PROFILE7, PROFILE8, PROFILE9, PROFILE10].sample
    category = element.css('.Article-descSub a').text.gsub(/(\D+)[A-Z]\D+/, '\1')
    price = element.css('.floatl a strong').text.gsub(/\s+/, '').gsub(/€/, '.').to_f
    age_range = element.css('.moreInfos-list li:nth-child(1) .data strong').text.gsub(/[\n\r\s]{2}/, '')
    min_number_players = element.css('.moreInfos-list li:nth-child(2) .data strong').text.gsub(/[\n\r\s]{2}/, '').gsub(/.*([0-9]).*[0-9]/, '\1').to_i
    max_number_players = element.css('.moreInfos-list li:nth-child(2) .data strong').text.gsub(/[\n\r\s]{2}/, '').gsub(/.*[0-9].*([0-9])/, '\1').to_i
    games = Game.new(name: name, description: description, average_duration: average_duration, category: category, price: price, age_range: age_range, min_number_players: min_number_players, max_number_players: max_number_players, profile: profile)
    games.save!
  end
end

parse_fnac("Jeux-d-ambiance")
parse_fnac("Jeux-de-strategie")
parse_fnac("Jeux-de-culture-generale")
parse_fnac("Jeux-de-role")
parse_fnac("Jeux-d-adresse")
parse_fnac("Jeux-de-pions")

Game.all.each do |game|
  availabilities = Availability.create!(start_date: '2017-03-14', end_date: '2017-11-01', game: game)
  profile = [PROFILE1, PROFILE2, PROFILE3, PROFILE4, PROFILE5, PROFILE6, PROFILE7, PROFILE8, PROFILE9, PROFILE10].sample
  order = Order.create!(start_date: '2017-03-14', end_date: '2017-11-01', days: 10, status: 'accepted', total_price: 3.5, game: game, profile: profile)
end

Order.all.each do |order|
  owner_comment = ['Le jeu a été rendu en bon état', 'Le jeu a été rendu en retard', 'Il manquait des pièces dans le jeu à la réception'].sample
  player_comment = ['Le jeu est bon état', 'Il manquait des pièces dans le jeu', 'Le jeu était abîmé'].sample
  profile = [PROFILE1, PROFILE2, PROFILE3, PROFILE4, PROFILE5, PROFILE6, PROFILE7, PROFILE8, PROFILE9, PROFILE10].sample
  owner_review = OwnerReview.create!(rating: 4, comment: owner_comment, state: 'en bon état', profile: profile, order: order)
  player_review = PlayerReview.create!(rating: 4, comment: player_comment, state: 'en bon état', profile: profile, order: order)
end
