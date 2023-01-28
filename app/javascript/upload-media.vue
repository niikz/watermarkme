<template>
  <div>
    <div class="form-control w-full max-w-x my-4">
      <label for="tweet_form_media">画像をえらぶ</label>
      <input
        id="tweet_form_media"
        ref="preview"
        class="file-input file-input-bordered w-full max-w-x mt-1"
        type="file"
        @change="uploadMedia" />
      <div
        class="canvas_preview_block box-content border rounded-lg flex justify-center items-center p-1 mt-2">
        <div class="canvas_preview max-w-full">
          <canvas id="canvas" class="max-w-full"></canvas>
        </div>
      </div>
    </div>
    <div class="form-control w-full max-w-x my-4">
      <label>配置を決める</label>
      <div class="grid grid-flow-col gap-4">
        <label class="label cursor-pointer justify-start">
          <span class="label-text mr-2">左下</span>
          <input
            type="radio"
            name="position"
            value="bottomLeft"
            class="radio"
            checked
            @change="changePosition" />
        </label>
        <label class="label cursor-pointer justify-start">
          <span class="label-text mr-2">真ん中</span>
          <input
            type="radio"
            name="position"
            value="centerCenter"
            class="radio"
            @change="changePosition" />
        </label>
        <label class="label cursor-pointer justify-start">
          <span class="label-text mr-2">右下</span>
          <input
            type="radio"
            name="position"
            value="bottomRight"
            class="radio"
            @change="changePosition" />
        </label>
      </div>
    </div>
    <input name="tweet_form[media]" type="hidden" :value="imageDataUrl" />
    <button class="btn btn-neutral w-full" type="button" @click="save">
      投稿する
    </button>
  </div>
</template>

<script>
export default {
  props: {
    currentTwitterId: { type: String, default: '' }
  },
  data() {
    return {
      imageDataUrl: '',
      uploadImgSrc: '',
      ctx: '',
      canvasWidth: null,
      canvasHeight: null,
      position: 'bottomLeft'
    }
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
    changePosition() {
      this.position = document.forms[0].position.value
      this.canvasDraw(this.position)
    },
    uploadMedia() {
      const fileData = this.$refs.preview.files[0]
      if (!fileData) {
        this.uploadImgSrc = ''
        this.ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight)
      }

      if (!fileData.type.match('image.*')) {
        alert('画像を選択してください')
        return
      }

      const reader = new FileReader()
      {
        reader.onload = () => {
          this.uploadImgSrc = reader.result
          this.position = document.forms[0].position.value
          this.canvasDraw(this.position)
        }
      }
      reader.readAsDataURL(fileData)
    },
    canvasDraw(position) {
      const img = new Image()
      img.src = this.uploadImgSrc

      const canvas = document.getElementById('canvas')
      this.ctx = canvas.getContext('2d')
      this.ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

      img.onload = () => {
        const maxWidth = 1280
        const maxHeight = 640
        if (img.width > maxWidth || img.height > maxHeight) {
          this.resizeCanvas(img.width, img.height, maxWidth, maxHeight)
        } else {
          this.canvasWidth = img.width
          this.canvasHeight = img.height
        }
        canvas.width = this.canvasWidth
        canvas.height = this.canvasHeight
        this.ctx.drawImage(img, 0, 0, this.canvasWidth, this.canvasHeight)
        this.addText(this.ctx, position)
        this.imageDataUrl = canvas.toDataURL()
        return this.canvas
      }
    },
    resizeCanvas(imgWidth, imgHeight, maxWidth, maxHeight) {
      if (imgWidth > imgHeight * 2) {
        this.canvasHeight = (maxWidth * imgHeight) / imgWidth
        this.canvasWidth = (this.canvasHeight * imgWidth) / imgHeight
      } else {
        this.canvasWidth = (maxHeight * imgWidth) / imgHeight
        this.canvasHeight = (this.canvasWidth * imgHeight) / imgWidth
      }
    },
    addText(ctx, position) {
      const fontSize = this.canvasWidth / 20
      this.ctx.font = `bold ${fontSize}px Arial`
      this.ctx.fillStyle = 'rgba(31, 41, 55, 0.3)'
      if (position === 'centerCenter') {
        this.ctx.textAlign = 'center'
        this.ctx.textBaseline = 'middle'
        this.ctx.fillText(
          this.currentTwitterId,
          this.canvasWidth / 2,
          this.canvasHeight / 2
        )
      } else if (position === 'bottomRight') {
        this.ctx.textAlign = 'end'
        this.ctx.fillText(
          this.currentTwitterId,
          this.canvasWidth - fontSize,
          this.canvasHeight - fontSize
        )
      } else {
        this.ctx.fillText(
          this.currentTwitterId,
          fontSize,
          this.canvasHeight - fontSize
        )
      }
    }
  }
}
</script>

<style scoped>
.canvas_preview_block {
  height: 30rem;
}
.canvas_preview,
#canvas {
  max-height: 30rem;
}
</style>
