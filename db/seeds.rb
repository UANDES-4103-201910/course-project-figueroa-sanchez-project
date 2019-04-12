# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create!(name: "Country")
Category.create!(name: "City")
Category.create!(name: "Photo")
Category.create!(name: "File")
Category.create!(name: "Location")
Role.create!(name: "normal_user", description: "Interacts with the application and doesn't manages it")
Role.create!(name:"administrator", description: "Manages the application")
Role.create!(name:"super_administrator", description:"Manages the administrator accounts")