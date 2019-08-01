# frozen_string_literal: true

limit = 100
URL_BASE = "https://developer.nps.gov/api/v1/parks?fields=images&limit=#{limit}&start="
start = 1
API_KEY = "&api_key=#{ENV['NPS_API_KEY']}"

while start < 500
  parks = JSON.parse(open(URL_BASE + start.to_s + API_KEY).read)['data']
  parks.each do |p|
    next unless p['latLong'] != ''

    new_park = {}
    new_park[:latLong] = p['latLong']
    new_park[:name] = p['name']
    new_park[:fullname] = p['fullName']
    new_park[:parkCode] = p['parkCode']
    new_park[:states] = p['states']
    new_park[:designation] = p['designation']
    new_park[:url] = p['url']
    new_park[:description] = p['description']
    new_park[:weatherInfo] = p['weatherInfo']
    park = Park.create(new_park)
    p['images'].each do |i|
      new_pic = { park_id: park.id,
                  title: i['title'],
                  url: i['url'],
                  caption: i['caption'] }
      Picture.create(new_pic)
    end
  end
  start += 100
end

pic_arr = ['https://www.nps.gov/customcf/structured_data/upload/IMG_4956.jpg', 'https://www.nps.gov/customcf/structured_data/upload/DSC_0833.png', 'https://www.nps.gov/common/uploads/structured_data/3C82F638-1DD8-B71B-0B93D85F83991274.jpg', 'https://www.nps.gov/common/uploads/structured_data/3C82F405-1DD8-B71B-0B2EB1FEC35F52B9.jpg']
pic_arr.each do |pic|
  bad_pic = Picture.all.find { |p| p.url == pic }
  bad_pic&.destroy
end

# 3.times do
#   fullname = Faker::FunnyName.two_word_name.split(' ')
#   user = User.new(username: Faker::Kpop.iii_groups,
#                   password: '12345',
#                   firstname: fullname[0],
#                   lastname: fullname[1],
#                   profile_url: Faker::LoremFlickr.image)
#   user.save
# end

# users = [User.first, User.all[1], User.all[2]]
# parks = [Park.all[80], Park.all[11], Park.all[7], Park.all[90], Park.all[138]]

# i = 0
# while i <= 4
#   Trip.create(user: users[0],
#               park: parks[i],
#               title: Faker::Lorem.sentence,
#               description: Faker::Lorem.paragraph_by_chars(256, false),
#               season: 'Summer',
#               year: '2018')
#   i += 1
# end

# i = 0
# while i <= 4
#   Trip.create(user: users[1],
#               park: parks[i],
#               title: Faker::Lorem.sentence,
#               description: Faker::Lorem.paragraph_by_chars(256, false),
#               season: 'Summer',
#               year: '2000')
#   i += 1
# end

# i = 0
# while i < 3
#   Trip.create(user: users[2],
#               park: parks[i],
#               title: Faker::Lorem.sentence,
#               description: Faker::Lorem.paragraph_by_chars(256, false),
#               season: 'Summer',
#               year: '2001')
#   i += 1
# end

# while i <= 4
#   Trip.create(user: users[2],
#               park: parks[i],
#               title: Faker::Lorem.sentence,
#               description: Faker::Lorem.paragraph_by_chars(256, false),
#               season: 'Winter',
#               year: '2001')
#   i += 1
# end
