cask "jinrai" do
  version "0.5.0"
  sha256 "154ef80d395430d5ec859829381e83c243a6dd8d01afe2463b31997061debe51"

  url "https://github.com/tadashi-aikawa/jinrai/releases/download/v#{version}/JINRAI-#{version}.zip"
  name "JINRAI"
  desc "思考の速度で素早くウィンドウ操作を行う macOS 用ツール"
  homepage "https://github.com/tadashi-aikawa/jinrai"

  depends_on macos: :sequoia

  app "JINRAI.app"

  # 自己署名(未公証)のため quarantine を外さないと Gatekeeper にブロックされる。
  # 公式 tap では禁止されている手法だが、自前 tap なので postflight で除去する。
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/JINRAI.app"],
                   sudo: false
  end

  caveats <<~EOS
    JINRAI は自己署名(未公証)アプリです。
    初回起動がブロックされた場合は以下で許可してください:
    システム設定 → プライバシーとセキュリティ → 「このまま開く」
  EOS
end
