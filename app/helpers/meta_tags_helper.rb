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
      icon: [
        { href: image_url('favicon.svg') },
        { href: image_url('icon.png'), rel: 'apple-touch-icon-precomposed', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        title: 'Watermark Me',
        type: 'website',
        site_name: 'Watermark Me',
        description: :description,
        image: image_url('ogp.png')
      },
    }
  end
  # rubocop:enable Metrics/MethodLength
end
