# frozen_string_literal: true

class TweetForm
  include ActiveModel::Model

  attr_accessor :description, :media

  def save(user)
    return false if invalid?

    upload_image = File.open(media.tempfile.path, 'rb').read
    media_response = twitter_client(user).media_upload({ 'media' => upload_image })
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
                             consumer_key: ENV['TWITTER_API_KEY'],
                             consumer_secret: ENV['TWITTER_API_SECRET'],
                             token: user.token,
                             token_secret: user.secret
                           })
  end
end
