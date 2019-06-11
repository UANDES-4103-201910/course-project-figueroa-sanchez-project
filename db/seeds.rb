# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create!(name: "normal_user", description: "Interacts with the application and doesn't manages it") #id:1
Role.create!(name: "administrator", description: "Manages the application") #id:2
Role.create!(name: "super_administrator", description: "Manages the administrator accounts") #id:3
ReportCategory.create(name: "Inappropiate content")
ReportCategory.create(name: "Spam")
ReportCategory.create(name: "Personal advertising")
ReportCategory.create(name: "Sexual harassment")
ReportCategory.create(name: "Other")
Location.create(name: "Las Condes", location:"ba06b113-1c5f-4aed-8468-7fe76aaaea52")
Location.create(name:"Vitacura", location:"5cac32ad-8f42-4637-a3a0-6dca6b0b60ae")
Location.create(name:"Lo Barnechea", location:"79e5b583-e38d-4e41-af7f-b9fcaf655a55")
Location.create(name:"San Carlos de Apoquindo", location:"74e81917-c9d1-44d1-94a6-c4123bc90c08")
Location.create(name:"Universidad de los Andes", location:"6ccdf1e5-8376-481a-bb79-f308071e1608")
User.create!(email: "activeNormalUser1@gmail.com", password: "password1", is_active: true) #Id:1
User.create!(email: "activeNormalUser2@gmail.com", password: "password2", is_active: true) #Id:2
User.create!(email: "activeNormalUser3@gmail.com", password: "password3", is_active: true) #Id:3
User.create!(email: "activeNormalUser4@gmail.com", password: "password4", is_active: true) #Id:4
User.create!(email: "bannedNormalUser1@gmail.com", password: "password5", is_active: false) #Id:5
User.create!(email: "bannedNormalUser2@gmail.com", password: "password6", is_active: false) #Id:6
User.create!(email: "bannedNormalUser3@gmail.com", password: "password7", is_active: false) #Id:7
User.create!(email: "bannedNormalUser4@gmail.com", password: "password8", is_active: false) #Id:8
User.create!(email: "activeAdministrator1@gmail.com", password: "password9", is_active: true) #Id:9
User.create!(email: "activeAdministrator2@gmail.com", password: "password10", is_active: true) #Id:10
User.create!(email: "activeAdministrator3@gmail.com", password: "password11", is_active: true) #Id:11
User.create!(email: "activeAdministrator4@gmail.com", password: "password12", is_active: true) #Id:12
User.create!(email: "activeSuperAdministrator1@gmail.com", password: "password13", is_active: true) #Id:13
UserRole.create!(role_id: 1, user_id: 1)
UserRole.create!(role_id: 1, user_id: 2)
UserRole.create!(role_id: 1, user_id: 3)
UserRole.create!(role_id: 1, user_id: 4)
UserRole.create!(role_id: 1, user_id: 5)
UserRole.create!(role_id: 1, user_id: 6)
UserRole.create!(role_id: 1, user_id: 7)
UserRole.create!(role_id: 1, user_id: 8)
UserRole.create!(role_id: 1, user_id: 9)
UserRole.create!(role_id: 1, user_id: 10)
UserRole.create!(role_id: 1, user_id: 11)
UserRole.create!(role_id: 1, user_id: 12)
UserRole.create!(role_id: 1, user_id: 13)
UserRole.create!(role_id: 2, user_id: 9)
UserRole.create!(role_id: 2, user_id: 10)
UserRole.create!(role_id: 2, user_id: 11)
UserRole.create!(role_id: 2, user_id: 12)
UserRole.create!(role_id: 3, user_id: 13)
for i in 1..8
  Profile.create!(user_id: i, first_name: "normalUserFirstName#{i}", last_name: "normalUserLastName#{i}", bio: "bio#{i}",
                  country: "country#{i % 2}", city: "city#{i % 2}")
end
for i in 9..13
  Profile.create!(user_id: i, first_name: "administratorFirstName#{i}", last_name: "administratorLastaName#{i}", bio: "bio#{i}",
                  country: "country#{i % 2}", city: "city#{i % 2}")
end

for i in 1..8
  Post.create!(user_id: i, title: "post#{i}", description: "description#{i}", solved: true)
end

for i in 1..8
  Post.create!(user_id: i, title: "post#{i + 8}", description: "description#{i}", solved: false)
end

for postid in 1..16
  for userid in 1..8
    Comment.create(user_id: userid, post_id: postid, comment: "Comentnumber#{postid + userid}")
  end
end


votes_types = [-1, 1]

for _ in 1..30
  random_user = Random.rand(1..8)
  random_post = Random.rand(1..16)
  if Validation.where(user_id: random_user, post_id: random_post).length == 0
    Validation.create!(user_id: random_user, post_id: random_post, vote: votes_types[Random.rand(0..1)])
  end
end

for id in 5..8
  BlackList.create(user_id: id)
end
AdminBlackList.create(black_list_id: 1, user_id: 7)
AdminBlackList.create(black_list_id: 3, user_id: 8)


Report.create(user_id: 1, post_id: 2, report_category_id: 1, comment: "Reportcomment1")
Report.create(user_id: 1, post_id: 3, report_category_id: 2, comment: "Reportcomment2")
Report.create(user_id: 2, post_id: 2, report_category_id: 3, comment: "Reportcomment3")
Report.create(user_id: 2, post_id: 3, report_category_id: 4, comment: "Reportcomment4")
Report.create(user_id: 3, post_id: 3, report_category_id: 5, comment: "Reportcomment5")
Report.create(user_id: 5, post_id: 3, report_category_id: 1, comment: "Reportcomment1")
Report.create(user_id: 4, post_id: 2, report_category_id: 2, comment: "Reportcomment2")
Report.create(user_id: 2, post_id: 6, report_category_id: 3, comment: "Reportcomment3")
Report.create(user_id: 2, post_id: 6, report_category_id: 4, comment: "Reportcomment4")
Report.create(user_id: 3, post_id: 6, report_category_id: 5, comment: "Reportcomment5")

