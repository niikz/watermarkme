# frozen_string_literal: true

class TweetForm
  include ActiveModel::Model

  attr_accessor :description

  def save
    return false if invalid?

    true
  end
end
