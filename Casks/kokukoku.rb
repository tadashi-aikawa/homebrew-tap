cask "kokukoku" do
  version "0.11.0"
  sha256 "cc9afff31a3ba8e780f899e5e276bdaa5d7ed5bc1b0635300b172a0466167641"

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
