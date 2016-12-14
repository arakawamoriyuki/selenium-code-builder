# テキストファイルをダウンロードする
window.app.factory 'Download', ['Chrome', (Chrome)->
  return (content, fileName, saveAs = true) =>
    Chrome.downloads.download
      url: "data:,#{encodeURIComponent(content)}"
      filename: fileName
      saveAs: saveAs
]