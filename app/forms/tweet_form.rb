# frozen_string_literal: true

class TweetForm
  include ActiveModel::Model

  attr_accessor :description, :media

  validates :description, length: { maximum: 140 }
  validates :media, presence: true

  def save(user)
    return false if invalid?

    media_response = twitter_client(user).media_upload({ 'media' => decoded_content })
    media_id = JSON.parse(media_response.body)['media_id_string']
    response = twitter_client(user).statuses_update({
                                                      status: description,
                                                      media_ids: media_id
                                                    })
    JSON.pretty_generate(JSON.parse(response.body))
    true
  end

  private

  def twitter_client(user)
    TwitterAPI::Client.new({
                             consumer_key: Rails.application.credentials.dig(:twitter, :twitter_api_key),
                             consumer_secret: Rails.application.credentials.dig(:twitter, :twitter_api_secret),
                             token: user.token,
                             token_secret: user.secret
                           })
  end

  def decoded_content
    Base64.decode64(image_content)
  end

  def image_content
    media.sub(%r/data:image\/.{3,},/, '')
  end
end
