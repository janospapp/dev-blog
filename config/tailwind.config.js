const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './config/initializers/heroicon.rb'
  ],
  theme: {
    colors: {
      // Dark colors
      'nord0': '#2e3440',
      'nord1': '#3b4252',
      'nord2': '#434c5e',
      'nord3': '#4c566a',
      // Light colors
      'nord4': '#d8dee9',
      'nord5': '#e5e9f0',
      'nord6': '#eceff4',
      // Frost colors
      'nord7': '#8fbcbb',
      'nord8': '#88c0d0',
      'nord9': '#81a1c1',
      'nord10': '#5e81ac',
      // Aurora colors
      'nord11': '#bf616a',
      'nord12': '#d08770',
      'nord13': '#ebcb8b',
      'nord14': '#a3be8c',
      'nord15': '#b48ead'
    },
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
