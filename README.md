### 読書ログリポジトリ
書籍：[Tom Stuart "アンダースタンディング コンピュテーション"](http://www.oreilly.co.jp/books/9784873116976/)

### 実行方法
irbではなくpryを使う（ハイライトされるから）
Pryはsyntax highlightとかを実現するために（IRBと違って）単純にinspect()が呼ばれない．代わりにpretty_inspectが呼ばれる．
- [Conflicting output for the same ruby code in irb and pry - Stack Overflow](http://stackoverflow.com/questions/17013948/conflicting-output-for-the-same-ruby-code-in-irb-and-pry)

なので，明示的にinspect()を呼ぶことにする．

### 補足
`#inspect' は自分のオブジェクトを展開するので `to_s` メッセージが送られます．

#### 蛇足
Pry::ColorPrinter.ppが呼ばれていて，こいつが余計な整形している
- [pry/color_printer.rb at 3156f10d5569c5604576e6c2ea11fee2af6cf4e5 · pry/pry](https://github.com/pry/pry/blob/3156f10d5569c5604576e6c2ea11fee2af6cf4e5/lib/pry/color_printer.rb)

#### 参考
- [Rubyistよ、irbを捨ててPryを使おう - TIM Labs](http://labs.timedia.co.jp/2011/12/rubyist-should-use-pry.html)
