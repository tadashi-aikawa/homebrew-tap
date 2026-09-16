cask "kokukoku" do
  version "0.25.0"
  sha256 "b5c2c5e6311c286be0f2c5bc85e4056d5e2038bc94bab65e76957efd5bb95987"

  url "https://github.com/tadashi-aikawa/kokukoku/releases/download/v#{version}/KOKUKOKU-#{version}.zip"
  name "KOKUKOKU"
  desc "プロジェクトごとの作業時間を計測する macOS 用ツール"
  homepage "https://github.com/tadashi-aikawa/kokukoku"

  depends_on macos: :sequoia

  app "KOKUKOKU.app"

  # 自己署名(未公証)のため quarantine を外さないと Gatekeeper にブロックされる。
  # 公式 tap では禁止されている手法だが、自前 tap なので postflight_steps で除去する。
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/KOKUKOKU.app"]
  end

  caveats <<~EOS
    KOKUKOKU は自己署名(未公証)アプリです。
    初回起動がブロックされた場合は以下で許可してください:
    システム設定 → プライバシーとセキュリティ → 「このまま開く」
  EOS
end
