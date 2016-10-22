#!/usr/bin/env ruby

# copied manually from "subcatalog" by @esuji
src = <<_EOS
A-21a
茶川 描@ティアA21a
@tygwa_17
A-47a
ぽーひー↑COMITIA118:A47a
@po_hi_
D-15b
エビ桃＠ﾃｨｱ D15b
@ebimomomo
H-44b
まつだひかり●ｺﾐﾃｨｱ118 H44b
@niko9_niku9
K-50a
さつよ・ティアK50a
@satuyo_satuyo
K-55a
クサダ : コミティア118/ K55a
@ku_sa_da
L-28b
ぬ太郎 COMITIA:L28b
@nutaronutaro
L-39b
轟木@TIA118 L39b
@hinata_todoroki
Q-07b
時田コミティアQ07bです
@tokitadesu
Q-15a
やしろ醤油コミティア/Q15a
@yashirosyouyu
R-49b
クダン【ティアR49b】
@kudan_052
S-20a
くまみ(10/23コミティアS20a)
@kumami_
S-47a
衆道士ペドフェチ（コミティアＳ４７ａ
@hihonsyudo
V-43a
内田美奈子@10/23ｺﾐﾃｨｱV43a
@zerra01
X-04b
寿@COMITIA118[X04b]
@KOTOBUKI_TL
X-51a
中野ティアX51a
@pisiinu
X-51b
さんかくやま　コミティアX51b
@sankakuyama
X-52b
２５５@コミティアX52b
@nikokosan
X-53b
がい子くじん■コミティアX53b
@gaiko_kujin
Y-44a
こーわ@コミティアY44a
@kowa
Z-26b
ザシャ@ティアZ26b
@zasha_turbo
う-69b
やいぎ/comitia:う69b
@_yaigi
く-09a
桐沢十三10/23コミティアく09a
@paulowniamarsh
く-63b
ぺよだ☻コミティアく63b
@peyoda4
く-70b
Masami.H.M%ティアく70b
@Lavendelstrauss
く-72b
とよ田みのる＠コミティアく72b
@poo1007
く-83a
清田聡comitia118く83a
@seitty
け-01b
めそめそ＠コミティアけ01b
@mesomesopom
こ-22a
にし🚃10/23コミティアこ22a
@2outni4
こ-30b
すいめんか～＠ティアこ30ｂ
@suimentou
さ-06a
戸塚こだま コミティアさ06a
@tsukatan
さ-15b
じょぶじゅん。秋ティアさ15ｂ
@JoveJun
さ-30a
しおやてるこ@ｺﾐﾃｨｱ118さ30a
@shiochin
し-02a
メカBoo＠ｺﾐﾃｨｱし02a
@mechaboo
し-10a
たいぼく@ｺﾐﾃｨｱし10a
@taiboku
し-31a
喬文＠コミティア118 し31a
@JugglingPilaf
し-47a
smison@ティアし47a
@smison
し-47b
はら@tia118し47b
@pcphr
_EOS

File.open('./build/fav.html', 'w') do |f|
  f.puts <<-_HTML
<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
    <link type="text/css" rel="stylesheet" media="all" href="css/map.css" />
    <link type="text/css" rel="stylesheet" media="all" href="css/spaces.css" />
    <title>comitia 118</title>
  </head>
  <body>
    <h1>マップ画像は、まっしろブログ <a href="https://masshiro.wpblog.jp/comitia118-map/">https://masshiro.wpblog.jp/comitia118-map/</a> 様からお借りしました。</h1>
    <ul>
  _HTML

  space = name = id = ''
  src.each_line do |line|
    case line
      when /^(.-\d+)[ab]$/
        space = $1
      when /^(@\w+)$/
        f.puts "      <li id=\"#{space}\" title=\"#{name.chomp}\">★ #{name.chomp}</li>"
      when /(.+?)([@＠%↑\/【（\(☻■●・。🚃1$]|comitia|tia|コミティア|ティア)/i
        name = $1
    end
  end

  f.puts <<-_HTML
    </ul>
  </body>
</html>
  _HTML
end
