cask "utsushie" do
  version "0.14.0"
  sha256 "772ce89481143dcc04a840e5a26f7c67360cef20d80ba6119c02cf37c1acb6c3"

  url "https://github.com/tadashi-aikawa/utsushie/releases/download/v#{version}/UTSUSHIE-#{version}.zip"
  name "UTSUSHIE"
  desc "画面をWebP画像やMP4動画で保存し、コピーとドラッグで共有する macOS 用ツール"
  homepage "https://github.com/tadashi-aikawa/utsushie"

  depends_on macos: :tahoe

  app "UTSUSHIE.app"

  # 自己署名の未公証アプリのため、導入後に quarantine を外す。
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/UTSUSHIE.app"]
  end

  zap trash: "~/.config/utsushie"

  caveats <<~EOS
    UTSUSHIE は自己署名の未公証アプリです。
    初回起動がブロックされた場合は以下で許可してください:
    システム設定 → プライバシーとセキュリティ → 「このまま開く」
  EOS
end
