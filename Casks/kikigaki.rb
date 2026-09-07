cask "kikigaki" do
  version "0.2.0"
  sha256 "86d079398e77d67c85a38469507b49e10a452c716ee17b84e0651edf85017db9"

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
