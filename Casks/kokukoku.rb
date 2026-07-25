cask "kokukoku" do
  version "0.19.0"
  sha256 "cbe52b1bbfaf4e671844e158a9a36349d6515d522413c3ce473ac0be68476555"

  url "https://github.com/tadashi-aikawa/kokukoku/releases/download/v#{version}/KOKUKOKU-#{version}.zip"
  name "KOKUKOKU"
  desc "プロジェクトごとの作業時間を計測する macOS 用ツール"
  homepage "https://github.com/tadashi-aikawa/kokukoku"

  depends_on macos: :sequoia

  app "KOKUKOKU.app"

  # 自己署名(未公証)のため quarantine を外さないと Gatekeeper にブロックされる。
  # 公式 tap では禁止されている手法だが、自前 tap なので postflight で除去する。
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/KOKUKOKU.app"],
                   sudo: false
  end

  caveats <<~EOS
    KOKUKOKU は自己署名(未公証)アプリです。
    初回起動がブロックされた場合は以下で許可してください:
    システム設定 → プライバシーとセキュリティ → 「このまま開く」
  EOS
end
