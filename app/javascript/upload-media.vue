<template>
  <div>
    <label for="tweet_form_media">Media</label>
    <input
      id="tweet_form_media"
      ref="preview"
      type="file"
      @change="uploadMedia" />
    <div class="canvas_preview">
      <canvas id="canvas"></canvas>
    </div>
    <input name="tweet_form[media]" type="hidden" :value="imageDataUrl" />
    <button type="button" @click="save">投稿する</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      imageDataUrl: '',
      uploadImgSrc: '',
      canvas: '',
      canvasWidth: null,
      canvasHeight: null
    }
  },
  mounted() {
    // Canvasの準備
    this.canvas = document.getElementById('canvas')
    this.canvas.width = 0
    this.canvas.height = 0
  },
  methods: {
    save() {
      const promise = new Promise(function (resolve) {
        resolve()
      })
      function onFulfilled() {
        const form = document.getElementById('form')
        form.submit()
      }
      promise.then(onFulfilled)
    },
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
          // Canvas上に表示する
          this.uploadImgSrc = reader.result
          this.canvasDraw()
        }
      }
      // ファイル読み込みを実行
      reader.readAsDataURL(fileData)
    },
    canvasDraw() {
      // 画像の準備
      const img = new Image()
      img.src = this.uploadImgSrc
      this.canvasWidth = img.width
      this.canvasHeight = img.height

      // Canvasの準備
      this.canvas.width = this.canvasWidth
      this.canvas.height = this.canvasHeight
      const ctx = this.canvas.getContext('2d')

      // Canvas内の要素をクリアする
      ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

      // Canvas上に画像を表示
      img.onload = () => {
        ctx.drawImage(img, 0, 0, this.canvasWidth, this.canvasHeight)

        // CanvasをDataURLに変換
        this.imageDataUrl = this.canvas.toDataURL()
        return this.canvas
      }
    }
  }
}
</script>

<style scoped>
.canvas_preview {
  width: 300px;
  height: auto;
}
.canvas_preview canvas {
  max-width: 100%;
  max-height: 100%;
}
</style>
