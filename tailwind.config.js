module.exports = {
  content: [
    './app/views/**/*.html.slim',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/**/*.vue',
  ],
  theme: {
    extend: {}
  },
  plugins: [require("daisyui")],
  daisyui: { themes: ["light"] },
}
