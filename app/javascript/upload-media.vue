<template>
  <div>
    <label for="tweet_form_media">Media</label>
    <input
      id="tweet_form_media"
      ref="preview"
      type="file"
      @change="uploadMedia" />
    <div id="result"></div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      canvas: '',
      canvasWidth: null,
      canvasHeight: null
    }
  },
  mounted() {
    // Canvasの準備
    this.canvas = document.getElementById('canvas')
  },
  methods: {
    uploadMedia() {
      // ファイル情報を取得
      const fileData = this.$refs.preview.files[0]
      if (!fileData.type.match('image.*')) {
        alert('画像を選択してください')
        return
      }

      // FileReaderオブジェクトを使ってファイル読み込み
      const reader = new FileReader()
      {
        // ファイル読み込みに成功したときの処理
        reader.onload = () => {
          // 画像の準備
          const outputImg = new Image()
          outputImg.src = reader.result
          // ブラウザ上に表示
          document.getElementById('result').appendChild(outputImg)
        }
      }
      // ファイル読み込みを実行
      reader.readAsDataURL(fileData)
    }
  }
}
</script>

<style scoped></style>
