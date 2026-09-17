cask "kikigaki" do
  version "0.8.1"
  sha256 "bbd67090fd4a766b58c27b68261b6fadad6eeec70c8f24a894d042ef10020e5a"

  url "https://github.com/tadashi-aikawa/kikigaki/releases/download/v#{version}/KIKIGAKI-#{version}.zip"
  name "KIKIGAKI"
  desc "会議の発話を話者付きでリアルタイムに文字起こしする macOS 用ツール"
  homepage "https://github.com/tadashi-aikawa/kikigaki"

  # SpeechTranscriber が macOS 26 以降のため
  depends_on macos: :tahoe

  app "KIKIGAKI.app"

  # 自己署名(未公証)のため quarantine を外さないと Gatekeeper にブロックされる。
  # 公式 tap では禁止されている手法だが、自前 tap なので postflight_steps で除去する。
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/KIKIGAKI.app"]
  end

  # AI参加者用 Skill のリンクは Cask では張らない。postflight_steps は HOME を差し替えた
  # sandbox で走り、~/.claude の読み取りも禁じられるため、Claude Code 側へ届かない。
  # 利用者の権限で動く同梱 CLI の skill install に任せ、ここでは案内だけする。
  caveats <<~EOS
    KIKIGAKI は自己署名(未公証)アプリです。
    初回起動がブロックされた場合は以下で許可してください:
    システム設定 → プライバシーとセキュリティ → 「このまま開く」

    会議へ AI を参加させる場合は、同梱の Skill を次のコマンドで導入してください。
    ~/.claude/skills/kikigaki と ~/.codex/skills/kikigaki へリンクします。
    既に同名のファイルがある場合は触りません。一度実行すれば brew upgrade 後も更新が届きます。
      "#{appdir}/KIKIGAKI.app/Contents/Helpers/kikigaki-cli" skill install
  EOS
end
