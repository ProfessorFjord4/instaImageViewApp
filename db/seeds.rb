# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Post.create!(
  id: 1,
  permalink: 'https://www.instagram.com/p/C7nzvoYRvXQ/',
  has_children: 0,
  post_datetime: '2024-05-31T06:00:15+0000'
)

# Image.create!(
#   postid: 1,
#   image1: "https://scontent-nrt1-2.cdninstagram.com/v/t51.29350-15/447220082_458309760181434_7234381352964677713_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=18de74&_nc_ohc=sjLF0IJtD1EQ7kNvgGB-Zsv&_nc_ht=scontent-nrt1-2.cdninstagram.com&edm=AL-3X8kEAAAA&oh=00_AYAbfSWFGEcS1uy5wuTOMvV3-ui_aonAgPnT9eyNmoaVYg&oe=665F6617"
# )


# rails g model Image postid:integer image1:string image2:string image3:string image4:string image5:string image6:string image7:string image8:string image9:string image10:string