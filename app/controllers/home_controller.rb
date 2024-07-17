class HomeController < ApplicationController
  require 'net/http'
  require 'json'

  def top
    insta_accountname = "yomiuri.giants"
    @timestamp = insta_latest_timestamp_check(insta_accountname)
    database_latest_data = Post.order(updated_at: :desc).limit(1)
    database_latest_post_id = 0
    database_latest_data.each do |data|
      database_latest_post_id = data.id
    end
    database_account_latest_data = Post.where(account_name: insta_accountname).order(updated_at: :desc).limit(1)
    database_latest_post_datetime = DateTime.new(2000,1,1)
    if database_account_latest_data.present?
      database_account_latest_data.each do |data|
        database_latest_post_datetime = data.post_datetime
        puts(database_latest_post_datetime)
      end
    end
    if database_latest_post_datetime == @timestamp
      puts("latest_post_is_updated")
      account_latest_post = Post.where(account_name: insta_accountname).order(updated_at: :desc).limit(1)
      @latest_post = Image.where(postid: account_latest_post[0].id).limit(1)
      # @latest_post = Image.order(updated_at: :desc).limit(1)
    else
      latest_data = insta_images_get(insta_accountname)
      permalink = latest_data["permalink"]
      post_datetime = latest_data["timestamp"]
      if latest_data.has_key?("children")
        latest_images = latest_data["children"]["data"]
        has_children = 1
        database_latest_post_id += 1
        post = Post.new(id: database_latest_post_id,permalink: permalink, post_datetime: post_datetime, has_children: has_children, account_name: insta_accountname)
        post.save
        images_num = latest_images.length
        10.times do |i|
          if i < images_num
            instance_variable_set('@image' + (i + 1).to_s, latest_images[i]["media_url"])
          else
            instance_variable_set('@image' + (i + 1).to_s, nil)
          end
        end
        image = Image.new(postid: database_latest_post_id,image1: @image1, image2: @image2, image3: @image3, image4: @image4, image5: @image5, image6: @image6, image7: @image7, image8: @image8, image9: @image9, image10: @image10)
        image.save
        @latest_post = Image.order(updated_at: :desc).limit(1)
        @latest_post
      else
        has_children = 0
        database_latest_post_id += 1
        post = Post.new(id: database_latest_post_id,permalink: permalink, post_datetime: post_datetime, has_children: has_children, account_name: insta_accountname)
        post.save
        latest_image_not_children = latest_data["media_url"]
        image = Image.new(postid: database_latest_post_id,image1: latest_image_not_children)
        image.save
        @latest_post = Image.order(updated_at: :desc).limit(1)
        @latest_post
      end
    end
    # @insta_img = insta_images_get("yomiuri.giants")
  end

  def insta_latest_timestamp_check(account_name)
    instagram_url = "https://graph.facebook.com/v19.0/"
    business_id = ENV["INSTAGRAM_BUSINESS_ID"]
    access_token = ENV["INSTAGRAM_ACCESS_TOKEN"]
    fields = "{media.limit(1){permalink,timestamp}}"

    url = instagram_url + business_id + "?fields=business_discovery.username(" + account_name + ")" + fields + "&access_token=" + access_token

    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)

    json_response_body = JSON.parse(response.body)


    recent_timestamp_str = json_response_body["business_discovery"]["media"]["data"][0]["timestamp"]
    recent_timestamp = Time.parse(recent_timestamp_str)

    return recent_timestamp
  end

  def insta_images_get(account_name)
    instagram_url = "https://graph.facebook.com/v19.0/"
    business_id = ENV["INSTAGRAM_BUSINESS_ID"]
    access_token = ENV["INSTAGRAM_ACCESS_TOKEN"]
    fields = "{media.limit(1){media_url,media_type,permalink,timestamp,children{media_url}}}"
    # fields = "{media.limit(1){thumbnail_url,media_url,media_type,permalink,timestamp,children{media_type,media_url,permalink}}}"

    url = instagram_url + business_id + "?fields=business_discovery.username(" + account_name + ")" + fields + "&access_token=" + access_token

    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)

    json_response_body = JSON.parse(response.body)

    recent_data = json_response_body["business_discovery"]['media']["data"][0]
    recent_data
  end
end

