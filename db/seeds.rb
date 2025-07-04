require 'open-uri'
require 'pexels'

puts "Cleaning database"
Offer.destroy_all
User.destroy_all

users = []

15.times do
  users << User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123456"
  )
end

puts "Hosts created!"

TITLES = [
  "Charming loft near the Bosphorus",
  "Modern apartment in the heart of Paris",
  "Cozy studio with mountain views",
  "Sunny beachside bungalow",
  "Spacious downtown condo",
  "Rustic cabin in the woods",
  "Elegant flat near the Opera",
  "Minimalist 1-bedroom with fast WiFi",
  "Bright apartment close to Central Park",
  "Historic home with garden",
  "Luxury suite with private terrace",
  "Quiet retreat in the countryside",
  "Contemporary loft with city views",
  "Chic flat steps from the river",
  "Vintage apartment with original features",
  "Modern flat near tech hub",
  "Seaside apartment with balcony",
  "Cozy nest in the old town",
  "Bright and airy studio",
  "Modern apartment with skyline views"
]

ADDRESSES = [
  "Karaköy, Istanbul, Turkey",
  "5 Rue de la Paix, 75002 Paris, France",
  "1600 Pennsylvania Avenue, DC, USA",
  "10 Downing Street, London, UK",
  "Piazza del Duomo, Milan, Italy",
  "Shibuya Crossing, Tokyo, Japan",
  "Gran Via, Madrid, Spain",
  "Alexanderplatz, Berlin, Germany",
  "Váci Street, Budapest, Hungary",
  "Churchillplein 10, Rotterdam, Netherlands",
  "Portland, Oregon, USA",
  "Richmond, Melbourne, Australia",
  "Rua Oscar Freire, São Paulo, Brazil",
  "Marine Drive, Mumbai, India",
  "Yonge Street, Toronto, Canada",
  "Boulevard Saint-Michel, Paris, France",
  "Syntagma Square, Athens, Greece",
  "Orchard Road, Singapore",
  "Wynwood, Miami, Florida, USA",
  "Old City, Jerusalem, Israel"
]

client = Pexels::Client.new(ENV["PEXELS_API_KEY"])

property_type_images = {}

Offer::PROPERTY_TYPES.each do |property_type|
  photos = client.photos.search(property_type, per_page: 10)
  images_url = photos.map { |photo| photo.src["original"] }
  property_type_images[property_type] = images_url
end

20.times do
  property_type = Offer::PROPERTY_TYPES.sample

  offer = Offer.new(
    title: TITLES.sample,
    address: ADDRESSES.sample,
    description: Faker::Lorem.paragraph(sentence_count: 4),
    number_of_bathrooms: rand(1..3),
    number_of_beds: rand(1..5),
    guests_limit: rand(1..7),
    property_type: property_type,
    price_per_night: rand(50..254),
    user: users.sample
  )

  5.times do
    offer_image = property_type_images[property_type].sample
    puts "Downloading image #{offer_image}"
    file = URI.open(offer_image)
    offer.photos.attach(io: file, filename: "flat_#{rand(1000)}.jpg", content_type: "image/jpg")
  end

  offer.save!
end

puts "Accomodations created!"
