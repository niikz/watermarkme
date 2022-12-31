# frozen_string_literal: true

module MetaTagsHelper
  # rubocop:disable Metrics/MethodLength
  def default_meta_tags
    {
      site: 'Watermark Me',
      reverse: true,
      description: '画像にアカウント名の透かしを入れて投稿できるツイート投稿サービス',
      keywords: %w[WatermarkMe Watermark Twitter],
      charset: 'utf-8',
    }
  end
  # rubocop:enable Metrics/MethodLength
end
