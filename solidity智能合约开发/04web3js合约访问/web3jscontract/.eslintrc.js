// module.exports = {
//   root: true,
//   env: {
//     node: true
//   },
//   extends: [
//     'plugin:vue/vue3-essential',
//     '@vue/standard',
//     // 'plugin:@typescript-eslint/eslint-recommended'
//     '@vue/typescript/recommended'
//   ],
//   // parser: 'vue-eslint-parser',
//   parserOptions: {
//     ecmaVersion: 2020
//     // ecmaVersion: 'latest',
//     // parser: '@typescript-eslint/parser'
//   },
//   rules: {
//     'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
//     'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
//     'vue/multi-word-component-names': 'off'
//   },
//   overrides: [
//     {
//       files: [
//         '**/__tests__/*.{j,t}s?(x)',
//         '**/tests/unit/**/*.spec.{j,t}s?(x)'
//       ],
//       env: {
//         jest: true
//       }
//     }
//   ]
// }


//半年前的配置
module.exports = {
  root: true,
  env: {
    node: true,
  },
  extends: [
    "plugin:vue/vue3-essential",
    "eslint:recommended",
    "@vue/typescript/recommended",
    "plugin:prettier/recommended",
  ],
  parserOptions: {
    ecmaVersion: 2020,
  },
  rules: {
    "no-console": process.env.NODE_ENV === "production" ? "warn" : "off",
    "no-debugger": process.env.NODE_ENV === "production" ? "warn" : "off",
    "@typescript-eslint/no-explicit-any": 0,
    "vue/multi-word-component-names": 0,
  },
  overrides: [
    {
      files: [
        "**/__tests__/*.{j,t}s?(x)",
        "**/tests/unit/**/*.spec.{j,t}s?(x)",
      ],
      env: {
        jest: true,
      },
    },
  ],
};
