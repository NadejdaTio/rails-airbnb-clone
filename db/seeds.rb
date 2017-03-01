require 'open-uri'
require 'nokogiri'

User.destroy_all
Profile.destroy_all
Game.destroy_all
Availability.destroy_all
Order.destroy_all
OwnerReview.destroy_all
PlayerReview.destroy_all

url = "http://www.fnac.com/n142414/Jeux-de-societe/Jeux-d-ambiance?ItemPerPage=20&SDM=list"
doc = Nokogiri::HTML(open(url), nil, 'utf-8')

user1 = User.create!(email: 'pal.hadur@gmail.com', password: '123456')
user2 = User.create!(email: 'amanda.gradur@gmail.com', password: '1234567')
profile1 =  Profile.create!(first_name: 'Paul', last_name: 'hadur', address: '25 rue de la moule, Lille', phone_number: '0386941029', user: user1)
profile2 = Profile.create!(first_name: 'Amanda', last_name: 'Gradur', address: '30 rue de la moule, Lille', phone_number: '0386941529', user: user2)

doc.search('.Article-item').each do |element|
  name = element.css('.Article-desc a').text
  description = ''
  average_duration = 0
  category = element.css('.Article-descSub a').text
  price = element.css('.floatl a strong').text.gsub(/\s+/, '').gsub(/€/, '.').to_f
  age_range = element.css('.moreInfos-list li:nth-child(1) .data strong').text.gsub(/[\n\r\s]{2}/, '')
  min_number_players = element.css('.moreInfos-list li:nth-child(2) .data strong').text.gsub(/[\n\r\s]{2}/, '').gsub(/.*([0-9]).*[0-9]/, '\1').to_i
  max_number_players = element.css('.moreInfos-list li:nth-child(2) .data strong').text.gsub(/[\n\r\s]{2}/, '').gsub(/.*[0-9].*([0-9])/, '\1').to_i
  games = Game.new(name: name, description: description, average_duration: average_duration, category: category, price: price, age_range: age_range, min_number_players: min_number_players, max_number_players: max_number_players, profile: profile1)
  games.save!
end

Game.all.each do |game|
  availabilities = Availability.create!(start_date: '2017-03-14', end_date: '2017-11-01', game: game)
  order = Order.create!(start_date: '2017-03-14', end_date: '2017-11-01', days: 10, status: 'accepted', total_price: 3.5, game: game, profile: profile2)
end

Order.all.each do |order|
  owner_review = OwnerReview.create!(rating: 4, comment: 'c\'est pas mal', state: 'en bon état', profile: profile1, order: order)
  player_review = PlayerReview.create!(rating: 4, comment: 'c\'est pas mal', state: 'en bon état', profile: profile2, order: order)
end

