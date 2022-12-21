<template>
  <div>
    <canvas id="canvas"></canvas>
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
  mounted () {
    // 画像の準備
    const img = new Image()
    img.src = 'https://placehold.jp/150x150.png'
    this.canvasWidth = img.width
    this.canvasHeight = img.height

    // Canvasの準備
    this.canvas = document.getElementById('canvas')
    this.canvas.width = this.canvasWidth
    this.canvas.height = this.canvasHeight
    const ctx = this.canvas.getContext('2d')

    // Canvas上に画像を表示
    img.onload = () => {
      ctx.drawImage(img, 0, 0, this.canvasWidth, this.canvasHeight)
      return this.canvas
    }
  }
}
</script>

<style scoped></style>
