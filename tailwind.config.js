// module.exports = {
//   theme: {
//     extend: {}
//   },
//   variants: {},
//   plugins: []
// };

const { colors } = require("tailwindcss/defaultTheme");

module.exports = {
  theme: {
    colors: {
      black: colors.black,
      white: colors.white,
      gray: colors.gray,
      red: colors.red,
      yellow: colors.yellow,
      green: colors.green,
      blue: colors.blue,
      indigo: colors.indigo,
      purple: colors.purple,
      redd: {
        light: "#79666b",
        def: "#6a2225"
      },
      sp: {
        pr: "#efc958",
        sc: "#ed872d",
        // df: "#ef4648",
        mn: "#e67e22"
      }
    }
  }
};

// module.exports = {
//   theme: {
//     colors: {
//       redd: {
//         light: "#79666b",
//         def: "#6a2225"
//       }
//     }
//   }
// };
