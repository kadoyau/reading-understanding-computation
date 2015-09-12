### 書籍：[Tom Stuart "アンダースタンディング コンピュテーション"](http://www.oreilly.co.jp/books/9784873116976/) 読書ログリポジトリ
- shortcut.rb
  - 書籍内で実装している意味論のコード
- probrem.rb
  - 実装した意味論を試すための問題（文とか式とか）のコード

### 実行環境
- irbではなくpryを使う（syntax highlightしてくれるから）．
  - irbの導入については [Rubyistよ、irbを捨ててPryを使おう - TIM Labs](http://labs.timedia.co.jp/2011/12/rubyist-should-use-pry.html) を参照のこと．
- pryはsyntax highlightとかを実現するために（IRBと違って）単純にinspect()が呼ばれない．
- 代わりにpretty_inspectが呼ばれる．なので，明示的にinspect()を呼ぶことにする．
  - 参考：[Conflicting output for the same ruby code in irb and pry - Stack Overflow](http://stackoverflow.com/questions/17013948/conflicting-output-for-the-same-ruby-code-in-irb-and-pry)
- Pry::ColorPrinter.ppが呼ばれていて，こいつが余計な整形している模様
  - 当該コード：[pry/color_printer.rb at 3156f10d5569c5604576e6c2ea11fee2af6cf4e5 · pry/pry](https://github.com/pry/pry/blob/3156f10d5569c5604576e6c2ea11fee2af6cf4e5/lib/pry/color_printer.rb)
