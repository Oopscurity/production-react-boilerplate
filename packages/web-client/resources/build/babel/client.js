function getClientBabelConfig() {
  return {
    plugins: [],
    presets: [
      [
        '@babel/preset-env',
        {
          loose: true,
          modules: false,
          targets: {
            browsers: [
              'last 2 versions',
              'last 4 years',
              'Chrome >= 54',
              'ChromeAndroid >= 54',
              'IE >= 11',
              'Edge >= 15',
              'iOS >= 9',
              'Safari >= 10',
            ],
          },
          useBuiltIns: 'usage',
        },
      ],
    ],
  };
}

module.exports = {
  getClientBabelConfig,
};
