<template>
  <div>
    <div class="form-control w-full max-w-x my-4">
      <label for="tweet_form_media">Media</label>
      <input
        id="tweet_form_media"
        ref="preview"
        class="file-input file-input-bordered w-full max-w-x mt-1"
        type="file"
        @change="uploadMedia" />
      <div class="border rounded-lg flex justify-center items-center h-36 mt-2">
        <div class="canvas_preview max-w-full max-h-36">
          <canvas id="canvas" class="max-w-full max-h-36"></canvas>
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
      canvas: '',
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
      this.canvasWidth = img.width
      this.canvasHeight = img.height

      this.canvas = document.getElementById('canvas')
      this.canvas.width = this.canvasWidth
      this.canvas.height = this.canvasHeight
      const ctx = this.canvas.getContext('2d')
      ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

      img.onload = () => {
        ctx.drawImage(img, 0, 0, this.canvasWidth, this.canvasHeight)
        this.addText(ctx, position)
        this.imageDataUrl = this.canvas.toDataURL()
        return this.canvas
      }
    },
    addText(ctx, position) {
      const fontSize = 48
      ctx.font = `bold ${fontSize}px Arial`
      ctx.textAlign = 'center'
      ctx.textBaseline = 'middle'
      ctx.fillStyle = '#2D1B69'
      if (position === 'centerCenter') {
        ctx.fillText(
          this.currentTwitterId,
          this.canvasWidth / 2,
          this.canvasHeight / 2
        )
      } else if (position === 'bottomRight') {
        ctx.fillText(
          this.currentTwitterId,
          this.canvasWidth - fontSize * 3,
          this.canvasHeight - fontSize
        )
      } else {
        ctx.fillText(
          this.currentTwitterId,
          fontSize * 3,
          this.canvasHeight - fontSize
        )
      }
    }
  }
}
</script>

<style scoped></style>
