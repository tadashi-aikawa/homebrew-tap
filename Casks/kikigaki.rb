cask "kikigaki" do
  version "0.6.0"
  sha256 "f8ec6e1807d459b99ea3acbb83163a4184cf44e4f6a71a72277d93ca9b9e42e5"

  url "https://github.com/tadashi-aikawa/kikigaku/releases/download/v#{version}/KIKIGAKI-#{version}.zip"
  name "KIKIGAKI"
  desc "会議の発話を話者付きでリアルタイムに文字起こしする macOS 用ツール"
  homepage "https://github.com/tadashi-aikawa/kikigaku"

  # SpeechTranscriber が macOS 26 以降のため
  depends_on macos: :tahoe

  app "KIKIGAKI.app"

  # 自己署名(未公証)のため quarantine を外さないと Gatekeeper にブロックされる。
  # 公式 tap では禁止されている手法だが、自前 tap なので postflight で除去する。
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/KIKIGAKI.app"],
                   sudo: false
  end

  caveats <<~EOS
    KIKIGAKI は自己署名(未公証)アプリです。
    初回起動がブロックされた場合は以下で許可してください:
    システム設定 → プライバシーとセキュリティ → 「このまま開く」
  EOS
end
