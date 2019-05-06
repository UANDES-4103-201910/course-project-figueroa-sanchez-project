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
Role.create!(name: "normal_user", description: "Interacts with the application and doesn't manages it") #id:1
Role.create!(name:"administrator", description: "Manages the application") #id:2
Role.create!(name:"super_administrator", description:"Manages the administrator accounts") #id:3
User.create!(mail: "activeNormalUser1@gmail.com", is_active:true) #Id:1
User.create!(mail: "activeNormalUser2@gmail.com", is_active:true) #Id:2
User.create!(mail: "activeNormalUser3@gmail.com", is_active:true) #Id:3
User.create!(mail: "activeNormalUser4@gmail.com", is_active:true) #Id:4
User.create!(mail: "bannedNormalUser1@gmail.com", is_active:false) #Id:5
User.create!(mail: "bannedNormalUser2@gmail.com", is_active:false) #Id:6
User.create!(mail: "bannedNormalUser3@gmail.com", is_active:false) #Id:7
User.create!(mail: "bannedNormalUser4@gmail.com", is_active:false) #Id:8
User.create!(mail: "activeAdministrator1@gmail.com", is_active:true) #Id:9
User.create!(mail: "activeAdministrator2@gmail.com", is_active:true) #Id:10
User.create!(mail: "activeAdministrator3@gmail.com", is_active:true) #Id:11
User.create!(mail: "activeAdministrator4@gmail.com", is_active:true) #Id:12
User.create!(mail: "activeSuperAdministrator1@gmail.com", is_active:true) #Id:13
UserRole.create!(role_id: 1, user_id: 1)
UserRole.create!(role_id: 1, user_id: 2)
UserRole.create!(role_id: 1, user_id: 3)
UserRole.create!(role_id: 1, user_id: 4)
UserRole.create!(role_id: 1, user_id: 5)
UserRole.create!(role_id: 1, user_id: 6)
UserRole.create!(role_id: 1, user_id: 7)
UserRole.create!(role_id: 1, user_id: 8)
UserRole.create!(role_id: 2, user_id: 9)
UserRole.create!(role_id: 2, user_id: 10)
UserRole.create!(role_id: 2, user_id: 11)
UserRole.create!(role_id: 2, user_id: 12)
UserRole.create!(role_id: 3, user_id: 13)
UserPassword.create!(user_id:1, password:"password1")
UserPassword.create!(user_id:2, password:"password2")
UserPassword.create!(user_id:3, password:"password3")
UserPassword.create!(user_id:4, password:"password4")
UserPassword.create!(user_id:5, password:"password5")
UserPassword.create!(user_id:6, password:"password6")
UserPassword.create!(user_id:7, password:"password7")
UserPassword.create!(user_id:8, password:"password8")
UserPassword.create!(user_id:9, password:"password9")
UserPassword.create!(user_id:10, password:"password10")
UserPassword.create!(user_id:11, password:"password11")
UserPassword.create!(user_id:12, password:"password12")
UserPassword.create!(user_id:13, password:"password13")
for  i in 1..8
  Profile.create!(user_id:i,first_name:"normalUserFirstName#{i}", last_name:"normalUserLastName#{i}", bio:"bio#{i}",
                  country:"country#{i%2}", city:"city#{i%2}")
end
for  i in 9..13
  Profile.create!(user_id:i,first_name:"administratorFirstName#{i}", last_name:"administratorLastName#{i}", bio:"bio#{i}",
                  country:"country#{i%2}", city:"city#{i%2}")
end

for i in 1..8
  Post.create!(user_id:i, title:"post#{i}", description:"description#{i}")
end

for i in 1..8
  Post.create!(user_id:i, title:"post#{i+8}", description:"description#{i}")
end

votes_types = [true,false]

for _ in 1..30
  random_user = Random.rand(1..8)
  random_post = Random.rand(1..16)
  if Validation.where(user_id: random_user, post_id: random_post).length == 0
    Validation.create!(user_id:random_user, post_id:random_post, vote:votes_types[Random.rand(0..1)])
  end
end


#TODO: Populate with attachments and other optional post elements