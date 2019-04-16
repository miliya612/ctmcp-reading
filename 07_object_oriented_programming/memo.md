- **オブジェクト指向プログラミング**
  - 情報工学で最も成功・浸透した
  - 1960年代に起源
    - Simula67
      - 初のOOP言語
      - Algol60の子孫
      - 1967年に誕生
    - C++
      - 工業的な普及を推進
      - 1980年代初期に誕生
      - Simulaの影響
    - Smalltalk-80
      - 1980年に公開
      - Simulaの影響
  - 最も普及しているプログラミング言語はオブジェクト指向
    - Java
    - C++
  - 基底言語がOOであることを暗に仮定しているツールや方法論が存在
    - 言語独立(language-independed)の設計支援
    - UML
    - デザインパターン
  - OOPの理解は実情不十分
    - 本章のポイント
      - 他の計算モデルとの関係
      - 正確なSemantics
      - 動的型付けの可能性
      - OOPのよって行われる設計上の選択
      - 選択のトレードオフ

#### オブジェクト指向プログラミングの原則

- OOPの計算モデル
  - 状態ありモデル
  - プログラムは相互作用するデータ抽象の集まり、として考える
    - データ抽象の構築方法は様々
      - cf. 6.4節
    - 多様性に秩序をもたらすのがOOP
- OOPの原則
  - データ抽象はデフォルトで*状態あり*であるべき
    - プログラムのモジュラ性のため、明示的状態が重要
      - cf. 6.2節
    - プログラムを独立の部分の集合として書ける
    - 各部分はI/Fを変えずに拡張できる
    - OOPと対象的な原則のメリットも重要
      - デフォルトで宣言的なプログラミング
        - 推論が簡単
          - cf. 4.8.5節
        - 分散プログラミングにとって自然
          - cf. 11章
      - 使いやすくあるべき
        - (?:使いやすさとは、「自然に」書けると同義でよい？)
  - PDAスタイルのデータ抽象がデフォルトであるべき
    - 多態性と継承を促進するため
      - 多態性
        - cf. 6.4節
        - プログラムの責任を各部分に適切に分散できる
      - 継承
        - 抽象を漸増的に構築できる
        - **class**の言語抽象を追加

## 7.1. 継承

- 継承の基礎概念
  - いろいろなデータ抽象にはかなり共通部分が多い
  - e.g. 集合(Set)
    - Set-likeな抽象は多くある
      - 基本的性質: 要素の集まり
      - 要素の追加、削除ができる
    - 振る舞いは抽象によって異なる
      - LIFOの順に追加、削除
      - FIFOの順に追加、削除
      - 順序関係なく追加、削除
      - ...
    - 基本的性質は全てのSet-likeな抽象で共有される
      - 複製なしに実装したい
        - 複製
          - プログラムが長くなる
          - 1つの変更を全てに適用しなければならない
          - 似ているようで少しずつ違う
- 継承のメリット
  - コード重複を減らす
  - 様々なデータ抽象の間の関係を明らかにする
    - データ抽象の漸増的定義: **class**
      - あるデータ抽象を定義する際、他のデータ抽象(parent)を継承(inherit)するように行う
      - 他のデータ抽象(parent)と大体同じ機能を持ち、拡張や変更があり得る
      - 祖先との相違点のみを記述する
    - OOP: classを言語抽象に加える
      - 変形によって新しいclassを定義
        - 1つ以上の既存のクラスが拡張と変更の記述を加えられ、新しいclassとなる
      - 構文操作としての変形
        - 新しいclassの構文が基のclassから得られる
      - 変形のSemanticsを定義
        - class値を入力として定義、新しいclass値を返す関数
- 取扱に注意が必要
  - parent classを十分知った上で変形を定義する必要がある
    - class不変表明を簡単に破る恐れがある
  - 継承を使うこと==あるcomponentに対して追加でI/Fを開くこと
    - 対向componentが生きている間はI/Fを維持する必要がある
  - classを定義するときのデフォルトはfinal(終端)とするべき
    - 他のclassに継承を禁ずる
    - 継承を可能にするには、明示的な行動を要求するように寄せるべき
- アプリケーションの共有部分を括りだす可能性を増やす
  - メリット: 共通部分が全体で1つしか存在しないことを確実にする
  - デメリット: 抽象の理解、維持が困難になる恐れ
    - ある抽象の実装をプログラムの到るところにばら撒くことになる
    - 実装の在り処が複数箇所に存在する
    - parentの抽象を考慮する必要が出てくる
    - オブジェクトコードしかないclassから継承する場合もある
  - 控えめに使うべき
- 継承の代用としてのcomponentベースプログラミング
  - 直接componentを用いて合成する
  - 別のcomponentをカプセル化するcomponentを定義し、変更した機能を提供しようとする考え方で対応する
  - 継承とcomponent compositionのトレードオフ
    - 抽象を拡張する際に考えるべきこと
    - 継承
      - 柔軟性に富む
      - クラス不変表明を破ることがある
    - component composition
      - 柔軟性に欠ける
      - component不変表明を破ることはない
- 継承: ソフトウェア再利用の問題は片付くと*信じられていた*
  - **ソフトウェアフレームワーク**
    - サードパーティにライブラリを配布する
    - 凡用的に作られたソフトウェア・システム
    - フレームワークの具体化(?:==利用？)
      - 凡用的パラメータに実際の値を与えること
      - 凡用class or 抽象classと継承を用いて実現


## 7.2. 完全なデータ抽象としてのclass

- オブジェクト概念の核心
  - カプセル化されたデータに統制あるアクセスをする
  - 振る舞いはclassによって規定される
- class
  - あるデータ抽象の漸増的定義
  - 他のクラスの変更としての定義
- classを定義するための概念の集合
  - **完全データ抽象**
    - あるclassが単体であるデータ抽象を定義することを許す概念
      - classを作り上げる様々な要素を定義
        - **method**
        - **attribute**
        - **property**
        - 初期化の方法
      - 動的型付けを利用する
        - 第一級のメッセージと第一級のattributeを与える
        - 静的型付けでは実現し難い強力な多態性を得られる
        - 自由度が増す分、正しく使うには注意が必要
  - **漸増的データ抽象**
    - 継承関連の全ての概念
    - あるclassが既存のclassにどのように関係するか

### 7.2.1. 例

- オブジェクトシステムの中でclassとobjectがどのように動くかを見る
- *class*宣言が言語構文として存在するとする
  - 第一級の値
    - 文としても式としても*class*構文を使える

```
class Counter
   attr val
   meth init(Value)
      val:=Value
   end
   meth browse
      {Browse @val}
   end
   meth inv(Value)
      val:=@val+Value
   end
end
```

- 実行時に実行される
  - class値を生成し、Counterに束縛する
- `Counter`を `$`に置き換えれば、宣言が式の中で使える
- 宣言をプログラムの先頭におけば、残りの部分を実行する前にclassが宣言される
  - ありふれた振る舞い
  - (?:残りの部分で利用可能になるってこと？)
- 文が書けるところなら宣言はどこでも書ける
  - 手続きの中に書く
    - 手続きが呼ばれるたびに新しい別のclassが生成される
    - パラメータ化されたclassを作る際に使う書き方

```
C={New Counter init(0)}
{C inc(6)} {C inc(6)}
{C browse}
```

- **オブジェクト適用(object application)**
  - `{C inc(6)}`
    - `inc(6)`というメッセージがobjectによって、対応するmethodを起動するのに使用される
  - データフロー実行は有効

```
% 動かない例
local X in {C inc(X)} X=5 end
{C browse}

% 動く例
declare S in
local X in
   thread
      {C inc(X)}
      S=unit
   end
   X=5
end
{Wait S}
{C brose}
```

### 7.2.2. 例のsemantics

- 明示的状態を持つ高階プログラミングの応用
- `class`構文を使わないとこうなる(状態ありモデル)
  - class: attributeの集合とmethodの集合を含むレコード
  - attribute名: リテラル
  - method
    - 手続き。
    - メッセージとobject状態の2つの引数を持つ
    - セル代入を使ってattributeへの代入を行う `val:=`
    - セルアクセスを用いてattributeにアクセスする `@val`

```
local
   proc {Init M S}
      init(Value)=M in (S.val):=Value
   end
   proc {Browse2 M S}
      {Browse @(S.val)}
   end
   proc {Inc M S}
      inc(Value)=M in (S.val):=@(S.val)+Value
   end
in
   Counter=c(attrs:[val] methods:m(init:Init browse:Browse2 inc: Inc))
end
```

- 関数`new`の定義
  - classからobjectを生成する
    - objectのstateを生成する
    - 引数1つの手続き`Obj`を定義する
    - object `Obj`を初期化して返す
    - objectのstate `S`
      - レコード
      - attributeごとにセルを保持する
      - 字句的スコープによって`Obj`内部に隠蔽される

```
fun {New Class Init}
   Fs={Map Class.attrs fun {$ X} X#{NewCell _} end}
   S={List.toRecord state Fs}
   proc {Obj M}
      {Class.methods.{Label M} M S}
   end
in
   {Obj Init}
   Obj
end
```

### 7.2.3. classとobjectを定義すること

- class
  - データ構造
  - objectの内部状態(attribute)・振る舞い(method)・継承元のclass・およびその他の性質と操作を定義
- classの具体化
  - 1つのclassには複数のobjectが存在できる
  - 異なるアイデンティティを持つ
    - 内部状態に異なる値を持つ
  - objectの振る舞いはclass定義に従う
  - `New`によって生成
    - `MyObj={New MyClass Init}`
  - 引数にメッセージを渡して呼び出し
    - `{MyObj M}`
    - メッセージ`Init`と`M`の表現はレコード(?:とは)
    - 手続き呼び出しに似ている
      - 呼び出し結果が返るのはmethodが実行し終わったとき

### 7.2.4. class member

- class member
  - OO用語
  - classにおいて定義された、objectのどれもが持つ成分のこと
- 3種類のmember
  - **属性(attribute)**
    - `attr`で定義
    - セルを用いて実現される
    - classの具体化(object)の状態の一部を含む
    - **インスタンス変数**と呼ばれることも
    - 任意の言語実体を持てる
    - 自身のclass定義と、それを継承するclassからのみ可視である
    - どのobjectもattributeの別の集合を持つ
      - (?:object同士でattributeは共有されない)
    - attributeの更新
      - 代入文 `<expr>1 := <expr>2`
        - `<expr>2`を計算した結果を、`<expr>1`を計算して得られる名前を持つattributeに代入する
      - アクセス操作 `@<expr>`
        - `<expr>`を計算して得られる名前を持つattributeにアクセスする
        - 字句的にclass定義に内包される任意の式の中で利用できる
          - 特にclassの内部で定義される手続きの中で使える
      - 交換操作
        - 代入 `<expr>1:=<expr>2`が式として用いられるとき
          - e.g. `<expr>3=<expr>1:=<expr>2`
            - 3つの式を計算
            - `<expr>3`と`<expr>1`の内容を単一化
            - 新しい内容を`<expr>2`にアトミックにセット
  - **method**
    - `meth`で定義
    - objectに付随して呼ばれる一種の手続き
    - objectのattributeにアクセスできる
    - 頭部と本体で出来ている(?:)
      - 頭部
        - ラベル(atomか名前)と引数の集合
          - 引数は異なる変数
    - method頭部はパターンに、メッセージはレコードに似てる
      - 表現力を豊かに
  - **property**
    - `prop`で定義
    - objectの振る舞いを変化させる
    - propertyの例
      - `locking`
        - 各objectに新しいロックを生成する
        - `lock...end`でアクセスできる
      - `final`
        - classを **終端class(final class)** にする
        - 継承できないようにする
        - 特別な理由がない限りclassはfinalにすべき
    - attributeとmethod labelはリテラル
      - 構文的にatomであればatomとなる
      - 構文的に識別子(英大文字から始まる)であれば、新しい名前を生成する
      - スコープはclass定義内となる
      - 名前を用いてobjectのセキュリティを制御できる

### 7.2.5. attributeを初期化すること

- attributeの初期化の仕方について
  - **object単位**
    - objectごとにattributeに異なる値を与える
    - class定義で初期化を行わない場合
      - `Apt1`, `Apt2`がそれぞれ異なる未束縛の変数を参照する

```
class OneApt
   attr streetName
   meth init(X) @streetName=X end
end
Apt1={New OneApt init(drottninggatan)}
Apt2={New OneApt init(rueNeuve)}
```

  - **class単位**
    - classから生成した全てのobjectが、同じattributeに同じ値を持つ
    - class定義で `:`を使って初期化する
      - 参照する未束縛の変数は、1つのobjectで束縛されると、全てがその影響を受ける
    - 注: `@wallColor=white` `wallColor:=white`を混同しないこと
      - セルへの束縛と、変数への代入

```
class YorkApt
   attr
      streetName:york
      streetNumber:100
      wallColor:_
      floorSurface:wood
   meth init skip end
end
Apt3={New YorkApt init}
Apt4={New YorkApt init}
```

  - **ブランド単位**
    - brand
      - 継承とは異なる方法で関連付けられたclassの集合
    - あるbrandに属する全てのclassのあるattributeに同じ値を与える

```
L=linux
class RedHat attr ostype:L end
class SuSE attr ostype:L end
class Debian attr ostype:L end
```

### 7.2.6. 第一級メッセージ

- 原則
  - メッセージはレコード
  - method頭部はあるレコードにマッチする
- オブジェクト呼び出しの種類(`{Obj M}`を例として)
  - **メッセージとしての静的レコード**
    - `M`がコンパイル時に分かっているレコード
    - `{Counter inc(X)}`
  - **メッセージとしての動的レコード**
    - `M`が変数で、実行時に計算されるレコードを参照する場合
    - 動的型付けが許される
    - 実行時に新しいレコード型を生成することがあり得る
- method定義の種類
  - **固定引数リスト**
    - method頭部は、ラベルの後にかっこで囲まれた引数の列
    - 頭部`foo(a:A b:B c:C)`はパターンで、メッセージに正確にマッチする必要がある
      - ラベル`foo`とアリティ`[a b c]`が一致
    - フィールド名の順序は任意
    - 1つのclass内であるラベルを持つmethodはユニーク
    ```
    meth foo(a:A b:B c:C)
      % method body
    end
    ```
  - **可変引数リスト**
    - method頭部が`...`で終わる
      - 任意のメッセージを受け入れることを意味する
        - 少なくとも明示された引数を持つ
        - ラベルが一致しているべき
        - アリティはメッセージのアリティの部分集合であるべき
    ```
    meth foo(a:A b:B c:C ...)
      % method body
    end
    ```
  - **変数からのmethod頭部の参照**
    - method頭部全体を変数によって参照できる
      - 可変引数リストの場合特に有用
    - 変数 `M`はメッセージ全体をレコードとして参照する
      - スコープはメソッド本体内
    ```
    meth foo(a:A b:B c:C ...)=M
      % method body
    end
    ```
  - **オプショナル引数**
    - ある引数についてデフォルトを定める
    - メッセージで指定がないと、デフォルト値が使用される
    - `<=V`: object呼び出し時にフィールド`b`がオプショナルである
    ```
    meth foo(a:A b:B<=V)
      % method body
    end
    ```
  - **private methodラベル**
    - 変数識別子を使って表す
      - methodラベルは名前でもよい
    - 新しい名前が`A`に束縛される
      - class定義の中でのみ可視
      - 意図的に渡す必要がある
    ```
     meth A(bar:X)
       % method body
     end
    ```
  - **動的methodラベル**
    - 実行時にmethodラベルを決める
      - エスケープされた(`!`がついた)変数識別子を用いる
      - classが実行によって定義される
      - ラベルはclass定義実行時に判明している必要がある
    - 変数 `A`に束縛されているものがmethodラベルとなる
      - atomか名前でなければならない
      - 名前だとmethodが安全になる
    ```
    meth !A(bar:A)
      % method body
    end
    ```
  - **otherwise method**
    - `otherwise`をラベルとするmethod
    - 他のどのmethodともマッチしないメッセージを受け取る
    - 1つのclassに1つであるべき
    - 引数は1つであるべき
      - メッセージ全体がレコードとして引数に渡される
    - objectを、任意のメッセージを受け取るようにできる
    - **委譲(delegation)** を実装できる
      - 継承に代わる概念
    - メソッド呼び出しを包む**wrapper**を作るのにも使える
    ```
    meth otherwise(M)
      % method body
    end
    ```
- コンパイラの処理方法(`{Obj M}`を例として)
  - `Obj`と `M`を静的に解析する
  - 決まれば、最適化された高速の`call`命令にコンパイル
  - 決まらなければ、一般のobject呼び出しを行う
    - 同時にcachingを行う
    - 初回呼び出しのみ遅くなる

### 7.2.7. 第一級のattribute

- attribute名は実行時に決められる
  - 任意のattributeにアクセスし、代入するmethodを書ける
    - `get`: 任意の属性にアクセス可能
    - `set`: 任意の属性に代入可能
  - attributeを誰もが扱えるようにする
    - 危険
    - debugに便利

```
class Inspector
  meth get(A ?X)
    X=@A
  end
  meth set(A X)
    A:=X
  end
end
```

### 7.2.8. プログラミング技法

- class概念が持つ構文
  - カプセル化されたstateと、複数の操作を持つデータ抽象を定義する
  - `class`
    - class値を定義し、具体化するとobjectとなる
  - class値
    - 手続き値の利点を全て持つ
      - 手続きに対するプログラミング技法を利用可能
      - 外部参照できる
      - 合成的である
        - 入れ子に出来る
        - classは手続きを内包でき、手続きはclassを内包できる
    - 言語によっては制限されていることも

---

## 7.3. 漸増的データ抽象としてのclass

- 継承
  - OOPがcomponentベースプログラミングに追加した最大のもの
  - 既存classを拡張して漸増的にclassを定義できる
- 継承のための概念の集合
  - **継承グラフ(inheritence graph)**
    - 既存のどのclassを拡張するかを定義
    - 本著のモデルでは、単一継承と多重継承が許される
  - **メソッドアクセス制御(method access control)**
    - 新しいclassと既存のclassのmethodにどのようにアクセスするかを定義
    - 概念
      - 静的束縛
      - 動的束縛
      - `self`
  - カプセル化制御(encapsulation control)
    - プログラムのどの部分がclassのattributeとmethodを見られるかを定義
  - その他
    - `forwarding`, `delegation`, `reflection`

### 7.3.1. 継承グラフ

- 継承
  - 新しいclassではどういうattributeとmethodが利用できるかを定義
  - あるclassで利用できるmethodはclass階層に現れるmethodの優先関係に従って定義される(overriding relation)
    - classCのmethodは、Cのすべての上位classの中にある、同じラベルのmethodをoverrideする
  - 1つ以上のclassから継承できる
    - **単一継承**
    - **多重継承**
  - `from`を用いて継承元classを表現する
  - classAがclassBのsuperclassであること
    - BがAの`from`宣言に現れること
    - BがAの上位classの上位classであること
- 上下関係を持つclass階層
  - 現在のclassをrootとする有向グラフ
  - 辺は下位クラスへと向かう
  - 継承が正しいこと
    - 継承関係が有向で閉路を持たない(acyclic)
      - お互いに継承しあうclassは書けない
    - overrideされたmethodを全て抹消した後に残る各methodは
      - 全て一意のラベルを持たねばならない
      - 同一階層の中の1つのclassでのみ定義される

```
class A1 meth m(...) ... end end
class B1 meth m(...) ... end end
class A from A1 end
class B from B1 end
class C from A B end % NG! meth m is duplicated.
```
```
class A meth m(...) ... end end
class B meth m(...) ... end end
class C from A B end % OK!　two m(...) methods are available (?:override可能だから？)
```

![7-4.png](inkdrop://file:ANpl1RWh4)

#### すべては実行時に

- 遅延エラー検出(late error detection)
  - 正しくない継承を含むclassをコンパイルしても例外は発生しない
  - 実行時に例外を発する
- Mozartシステム: JIT(Just In Time)とAOT(Ahead Of Time)の区別がない
  - コンパイラの役割が小さい
    - 実行分に変更するだけ
    - 言語の意味に関する知識を必要としない
      - 実際は、エラー検出や最適化のために多少は知っている
  - 遅延エラー検出: 言語の動的性格による、Mozartの性質
  - オブジェクトシステムが性格を受け継ぐ
    - methodラベルを実行時に計算するようにできる
  - Mozart: 何でも実行時に考える、と言えるレベル
    - コンパイラは実行時システムの一部
    - class宣言は実行文
    - 生成したclassは値となる
- JITとAOTの区別
  - コンパイラの最適化を助ける
  - C++やJavaは区別する
  - 宣言などのみAOTで実行し、その他はJITで行う
  - プログラム実行の干渉を受けずに宣言を処理できる
    - コード生成の際に強力な最適化を施せる
  - 柔軟性が減少する
    - 凡用性と具体化を妨げる

![7-5.png](inkdrop://file:q-RlGptVv)

### 7.3.2. methodアクセス制御(静的束縛と動的束縛)

- objectの内部で処理を実行している間に、objectの別methodを呼びたい
  - 一種の再起起動
  - 継承が絡むと厄介
    - 新しいclass, super classの両方に同じ名前のmethodがある
    - 呼び分ける必要性が出てくる
      - **静的束縛**
      - **動的束縛**

#### 例

```
class Account
   attr balance:0
   meth transfer(Amt)
      balance:=@balance+Amt
   end
   meth getBal(Bal)
      Bal=@Balance
   end
   meth batchTransfer(AmtList)
      for A in AmtList do {self transfer(A)} end
   end
end

% extended Account: with logging

class LoggedAccount from Account
   meth transfer(Amt)
       % LogObj: ログを保持するobject
      {LogObj addentry(transfer(Amt))}
      ...
   end
end
```

```
LogAct={New LoggedAccount transfer(100)}
```
- `logAct`に`batchTransfer`を呼ぶと、どの`transfer`が呼ばれるか
  - hint: classがデータ抽象をobjectスタイルで定義すると仮定する
  - データ抽象: methodの集合を持つ
    - super classのmethod+新しい`transfer`を含む
  - A. 新しい`transfer`が呼ばれる
    - **動的束縛**
    - `{self transfer(A)}` と書く
  - 動的束縛により、継承を使って`Account`を拡張する可能性が生じる
    - `Account`定義時にはまだ`LoggedAccount`がなかった
  - 新しいclassが元のclassを正しく拡張するデータ抽象であることが保証される
    - 元の抽象の機能を維持しながら新しい機能を追加する
- 新しい`transfer`の定義の中から、古い`transfer`を呼ぶ必要がある
  - 動的束縛では、新しい`transfer`を呼んでしまう
  - **静的束縛**を使う
    - methodが属するclassを明示する
      - `Account,transfer(Amt)`

```
class LoggedAccount from Account
  meth transfer(Amt)
    {LogObj addentry(transfer(Amt))}
    Account,transfer(Amt)
  end
end
```

#### 検討

- 継承におけるoverrideには静的束縛と動的束縛の両方が必要
- **動的束縛**
  - `{self M}`と書く
  - `M`とマッチするメソッドで、現在のobjectから見えるものを選ぶ
  - 既に行われたoverrideを考慮する
- **静的束縛**
  - `C,M`と書く
    - `C`: `M`にマッチするmethodを定義しているclass
  - `M`にマッチするmethodで、classCに見えるものが選ばれる
    - root classからclassCまでのoverrideを考慮に入れる
      - 自分のchildrenは考慮に入れない
- attributeの場合
  - 動的束縛のみが可能
  - 静的束縛はありえない
    - overrideされたattributeは存在しないことに等しい
    - 論理的には、存在するobjectは、すべての継承が行われた結果のclassの具体化である
    - 実際的にはoverrideされたattributeはメモリが割り当てられない

### 7.3.3. カプセル化制御

- カプセル化制御
  - アプリのアーキテクチャに従い、class memberへのアクセスを制限すること
  - memberにはスコープが定義される
    - スコープ: アクセスできる領域
    - プログラムの構造により静的に定義
    - 名前が使用され、動的に定義されることも
- デフォルトスコープ
  - キーワードで変更可能
  - `public` `private` `protected`など
  - 言語によって異なるため、扱いに注意
    - **visibility**の概念

#### privateスコープとpublicスコープ

- 基本的なスコープ
  - `private`
    - object内でしか見えないmember
    - 自らを定義するclass&その上位classで定義されたすべてのmemberが可視である
    - `垂直的可視性`を定義
  - `public`
    - プログラムのどこからでも見えるmember
  - smalltalk, ozの例
    - attributeはprivate
    - methodはpublic
- classをデータ抽象の例に使うのなら、smalltalkやozの扱いが自然
  - attributeはprivate
  - methodはpublic
  - 理由
    - classとそれが定義するデータ抽象は異なるものであるため
      - class
        - あるデータ抽象を、上位classに漸増的に修正を施したものとして定義したもの
        - classの必要性: 抽象を構築している最中のみ
      - データ抽象
        - 漸増的なものではない
        - 自身のattributeとmethodを持つ独立したもの
        - 上位classから受け継ぐものはあるが、classによる新たなattributeやmethodはない
    - attributeはデータ抽象に内部的なものであるため
      - 外から見えるべきものではない
      - `private`スコープの定義
    - methodはデータ抽象の外部I/Fとなる
      - 抽象を参照する全ての実体から見えねばならない
      - `public`スコープの定義

#### その他のスコープを構築すること

- カプセル化を制御するプログラムを書く技法
  - **字句的スコープ(lexical scoping)**
  - **名前値(name value)**
  - privateやpublicスコープはこれらを用いて定義可能
  - 他のスコープも定義できる
    - `private`, `protected` in C++, Java
- 基本的な技法
  - method頭部をatomではなく名前値にする
    - 名前
      - 偽造不能定数
      - 知るには誰かから参照を教えてもらう必要がある
    - 見る必要がある部分にだけ参照を渡せる
    - atomは安全でない
      - 誰かがatomの印字表現を推測して当ててしまったら、アクセス可能になる
    - component間にI/Fをしっかり定めたソフトウェア開発プロジェクトにとって大切
      - 異なるグループによって開発されるオープン分散プロジェクトでは更に重要

#### private method(C++とJavaの意味の)

- C++やJavaの`private`
  - method頭部が名前値
  - スコープがそのclassのインスタンスに限られる
    - 下位classやそのインスタンスからは見えない
  - 本章でサポートする
- 2通りの書き方
  - method頭部に変数識別子を使用するタイプ
    - class内部で名前を暗黙的に定義する

  ```
  class C
    meth A(X)
      % method body
    end
  end
  ```
    - method頭部`A`に名前が束縛
      - class内でしか見えない
      - Cのインスタンスは他のCのインスタンスのmethod `A`を呼べる
      - 下位class定義には見えない
      - *水平的可視性*
      - C++やJavaの`private`
  - method頭部にエスケープされた変数識別子を使用するタイプ
    - 名前が外部から来る
    - `!`: classの外で変数識別子を宣言し、束縛することを示す
    - classが定義されるとき、method頭部は変数に束縛されているものに束縛される
    - 一般的な技法
      - methodを保護するのに使える
      - 機密保護以外の目的にも使える

  ```
  local
    A={NewName}
  in
    class C
      meth !A(X)
        % method body
      end
    end
  end
  ```
     - 変数識別子を使用するタイプと同様
       - class定義時に名前が生成され、method頭部に束縛される
       - 前者はこれの略記
  - methodラベルをプログラマに決めさせること
    - セキュリティポリシーをきめ細かく定義可能
    - methodラベルを知る必要のある実体にだけ渡せる

#### protected method(C++の意味の)

- C++における`protected`
  - 定義されたclassとその下位class、及びそれらのインスタンスだけがアクセス可能であること
  - Smalltalkの`private`とC++/Javaの`private`の組み合わせ
    - 垂直成分と水平成分を併せ持つ
  
  ```
  class C
    attr pa:A
    % protected method A
    meth A(X) skip end
    meth foo(...) {self A(5)} end
  end
  
  class C1 from C
    meth b(...) A=@pa in {self A(5)} end
  end
  ```
  
  - attibute `pa`が`A(X)`の参照を持つため、`protected`として振る舞う
  - 下位classでは、attribute`pa`を通じてラベル`A`のmethodにアクセスする
  - methodラベルも値、attributeに格納できる

#### attributeのスコープ

- 常に`private`
  - methodを通じて`public`にできる
  - 全てのattributeを読み書きする凡用methodを定義できる
    - 動的型付けであることを活かす
    - cf. 2.7.節 `Inspector`
  - atom attribute
    - 推測不可能でないため安全でない
  - `Inspector`を用いても名前は推測できないため、安全(?:)

#### method頭部はatomにするか名前にするか

- デフォルトの挙動
  - atom: プログラム全体で可視
  - 名前: 生成した字句的スコープでしか見えない
- **内部methodには名前を使い、外部methodにはatomを使う**
- method頭部にatomしか許容しない言語
  - smalltalk, c++, java
  - 特殊な操作によってatomの可視性を制御する
    - `private`宣言、`protected`宣言
- 名前は実用的
  - 参照を渡すことで見える範囲を広げられる
  - **資格**ベースの手法は未だ普及していない
    - 名前によって代表されるもの
- 名前とatomのメリット&デメリット
  - atom
    - 印字表現によって一意に識別される
      - ソース、メール、webpageなどに載せられる
      - プログラマが記憶できる
    - メリット: 大きなプログラムの中でどこからでも呼び出せる
  - 名前
    - ぎこちなさ
    - デメリット: プログラム自身で呼び出し側に名前を渡さなければならない
      - プログラマの負担になる
      - プログラムを複雑にする
    - メリット
      - 継承の際に矛盾が生じない(?:)
      - カプセル化を上手く管理できる
        - object参照がobjectの全てのmethodを呼び出す権利を必ずしも持たないため
        - 名前を渡すかどうかで制御できる
      - エラーを起こしにくく、良い構造を実現できる
      - 名前を使いやすくする構文支援が可能
        - 本章: methodラベルを英大文字にする
 
 ### 7.3.4. 転嫁と委譲
 
 - 継承
   - 新しい機能を定義するのに、既存の定義の機能を再利用する方法
   - 元のclassと拡張との間に強い依存が生じる
 - **転嫁(forwarding)**, **委譲(delegating)**
   - 継承よりも緩い関係を利用する
   - objectレベルで定義される
     - classレベルではない
   - object`Obj1`にメッセージ`M`が理解できなければ、`Obj2`に透過的に渡される、ような挙動

(IMG: 7-8)

- `self`の扱い方の違い
  - forwarding
    - `Obj1`と`Obj2`は異なるアイデンティティを保つ
    - `Obj2`の中の`self`呼び出しは`Obj2`を指す
    - `self`を共有しない
  - delegating
    - アイデンティティは`Obj1`しかない
    - `Obj2`の中の`self`呼び出しは`Obj1`を指す
    - `self`を共有する
- どのように表現するか
  - `NewF`, `NewD`を定義
  - 下記を用いる
    - `otherwise` method
    - 値としてのメッセージ
    - classの動的生成


#### forwarding

- objectは他の任意のobjectにforwarding可能
  - `otherwise` methodを使って実装

```
local
   class ForwardMixin
      attr Forward:none
      meth setForward(F) Forward:=F end
      meth otherwise(M)
	 if @Forward==none then raise undefinedMethod end
	 else {@Forward M} end
      end
   end
in
   fun {NewF Class Init}
      {New class $ from Class ForwardMixin end Init}
   end
end

class C1
   meth init skip end
   meth cube(A B) B=A*A*A end
end

class C2
   meth init skip end
   meth square(A B) B=A*A end
end

Obj1={NewF C1 init}
Obj2={NewF C2 init}
{Obj2 setForward(Obj1)}

{Obj2 cube(10 X)} % invoke C1,cube with Obj1
```

#### delegation

- システムを動的に構成するための強力な方法
- object間に階層を構成できる
  - class定義時にclassから継承するのではない
  - object生成時にobjectが別のobjectにdelegateするようにする
- 継承との違い
  - class間ではなく、object間での階層構造を生み出す
  - いつでも変更できる
- `{Obj2 setDelegate(Obj1)}`
  - `Obj1`に処理をdelegateする
  - `Obj1`が`Ojb2`のsuper classとして振る舞う
  - `Obj2`で定義されていないmethodが起動されると、`Obj1`で実行が試みられる
  - delegateの連鎖はどこまでも続く
    - 最上位objectに行き着くまで続く
- 重要な性質
  - `self`がいつまでも保たれる
    - delegate連鎖が始まるobjetが`self`であり続ける
    - state、attributeも始めのobjectのものである
  - 他のobjectは始めのobjectのclassの役割を果たす
  - delegateではattributeではなくmethodが重要

```
local
   SetSelf={NewName}
   class DelegateMixin
      attr this Delegate:none
      meth !SetSelf(S) this:=S end
      meth set(A X) A:=X end
      meth get(A ?X) X=@A end
      meth setDelegate(D) Delegate:=D end
      meth Del(M S) SS in
	 SS=@this this:=S
	 try {self M} finally this:=SS end
      end
      meth call(M) SS in
	 SS=@this this:=self
	 try {self M} finally this:=SS end
      end
      meth otherwise(M)
	 if @Delegate==none then
	    raise undefinedMethod end
	 else
	    {@Delegate Del(M @this)}
	 end
      end
   end
in
   fun (NewD Class init)
      Obj={New class $ from Class DelegateMixin end init}
   in
      {Obj SetSelf(Obj)}
      Obj
   end
end
```

(IMG: table7-2)

- delegateを使用すると、呼び出し方が変わる
  - 適切な言語抽象をもって隠蔽可能

- delegateがどのように働くか

```
% 継承を使った例

class C1NonDel
   attr i:0
   meth init skip end
   meth inc(I) i:=@i+I end
   meth browse {self inc(10)} {Browse c1#@i} end
   meth c {self browse} end
end

class C2NonDel from C1NonDel
   attr i:0
   meth init skip end
   meth browse {self inc(100)} {Browse c2#@i} end
end

% 委譲を使った例

class C1
   attr i:0
   meth init skip end
   meth Inc(I)
      {@this set(i {@this get(i $)}+I)}
   end
   meth browse
      {@this inc(10)}
      {Browse c1#{@this get(i $)}}
   end
   meth c {@this browse} end
end
Obj1={NewD C1 init}

class C2
   attr i:0
   meth init skip end
   meth browse
      {@this inc(100)}
      {Browse c2#{@this get(i $)}}
   end
end
Obj2={NewD C2 init}
{Obj2 setDelegate(Obj1)}
```

- `setDelegate`を再度呼ぶことで、階層関係を更新することができる


### 7.3.5. 内省(reflect)

- 内省的
  - 実行中に実行状態の一部を検査できること
  - 2種類の内省
    - 純粋に静観的
      - 内部状態を読み取るだけで書き換えない
    - 改変的
      - 読み取りと書き込みを行う
  - 抽象の高水準・低水準両方で内省を行える
    - 高水準
      - 意味スタックのエントリをclosureと見る能力
    - 低水準
      - メモリを整数の配列として読む能力

#### メタオブジェクトプロトコル

- OOP: 内省に関して特に豊かである
  - システムが実行中に継承関係を調べ、変更できる
  - objectがどのように実行するかを実行中に基本レベルから変更できる
    - 継承をどのように働かせるか
      - class階層の中でマッチするmethodの探索をどう行うか
    - methodをどのように呼ぶか
- **meta-object protocol**
  - オブジェクトシステムが基本レベルでどのように働くかに関する記述
  - meta-object protocolを変更する能力==オブジェクトシステムを変更する方法
  - 使いみち
    - debug
    - customize
    - 関心の分離
      - method呼び出しに透過的に暗号化を付加
      - 形式を変更
      - ...

#### method wrapping

- meta-object protocolの使いみちの1つ
- method呼び出しに介入して、呼び出し前や後にユーザー定義の操作を行ったり、呼び出しの引数を変更したりする
- method wrappingは簡単に実装できる
  - objectが引数1つの手続きであることを利用する

```
% methodに出入りするたびにそのラベルを表示するTracerの実装
fun {TraceNew Class Init}
   Obj={New Class Init}
   proc {TraceObj M}
      {Browse entering({Label M})}
      {Obj M}
      {Browse exiting({Label M})}
   end
in TracedObj end
```

- `TraceNew`で生成したmethodは`New`で生成したものと同様に振る舞う
  - method呼び出しのみがtraceされる
- 高階プログラミングが用いられている
- 外部参照`Obj`の存在に注意
- 手の込んだwrappingを行うように拡張できる


Traceの別実装: classでwrappingする
```
fun {TraceNew2 Class Init}
   Obj={New Class Init}
   TInit={NewName}
   class Tracer
      meth !TInit skip end
      meth otherwise(M)
	 {Browse entering({Label M})}
	 {Obj M}
	 {Browse exiting({Label M})}
      end
   end
in {New Tracer TInit} end
```

#### オブジェクト状態の内省

- objectの全状態をclassに関係なく読み書きしたい
  - Mozart: class`ObjectSupport.reflect`
  - 3つのmethodを追加
    - `clone(X)`
      - `self`のクローンを生成し、`X`に束縛
      - クローンは新しいObjectで、同じclass, attributeを持つ
    - `toChunk(X)`
      - attributeの現在値を含む保護された値(chunk)を`X`に束縛
    - `fromChunk(X)`
      - objectの状態を`X`にする
      - `X`: `toChunk`によって得られた値
- chunk
  - レコードのようなもの
  - 操作が限られている(保護)
    - 権限のあるプログラムしか中を見られない
  - 安全なデータ抽象を定義可能


```
class Counter from ObjectSupport.reflect
   attr val
   meth init(Value)
      val:=Value
   end
   meth browse
      {Browse @val}
   end
   meth inc(Value)
      val:=@val+Valuie
   end
end

C1={New Counter init(0)}
C2={New Counter init(0)}
% 状態の転送
{C1 inc(10)}
local X in {C1 toChunk(X)} {C2 fromChunk(X)} end　% C2も値10を持つ
```

## 7.4. 継承を使うプログラミング

- OOPによって新たに可能になった新しい技法
  - 継承にまつわること

### 7.4.1. 継承の正しい使い方

- 継承の見方
  - 型と見る
    - classは型で、下位classは部分型と見る
      - e.g. `Window`を継承した`LabeledWindow`
    - 原則
      - classは現実世界の実体あるいはそれらをある程度抽象化したものをモデル化すべき
    - **代替性(substitution property)** を満たす
      - classCのobjectに使える操作は下位classのobjectにも使える
    - 各classが本物のデータ抽象のように自立している
  - 構造と見る
    - プログラムを構造化するためのツールとしてみる
    - **非推奨**
      - classが代替性を満たさないから
      - バグと悪い設計の根源
    - classは足場にすぎず、プログラムを構築するという役目を果たしたら終わり

　#### 例
 
 - 口座classの例
   - 手数料を取る`AccountWithFee`拡張を考える
     - 継承を型ではなく構造として見た例
   - 拡張classでは、基底classの下記代数的原則が崩壊してしまう
     - `(元のbalance) + (入金された額)　= (現在のbalance)`
 - 構造として見る見方
   - オブジェクトシステムそのものの振る舞いを変えたい場合のみ使用すべき
     - 言語実装の専門家によるもの
     - システムの微細を理解する必要がある

#### 契約による設計

- 正しいプログラムを継承を用いて設計すること
  - プログラムの正しさ(仕様通りに動くこと)を証明する
    - 形式的意味に基づいて推論すること
      - 状態ありプログラミング
        - 公理的意味を使って推論(6.6節)
          - 不変表明の証明
        - 代数的規則を使って推論することも(Accountの例)
- **契約による設計**
  - 形式的仕様のための技法に基づく
  - Bertrand Meyerによる
  - Eiffel言語に実装
- 中心となる考え方
  - データ抽象には抽象の設計者とユーザーの間の契約が含まれる
  - ユーザーは抽象を正しく呼ぶことを保証しなければならない
  - 見返りとして抽象は正しく振る舞う
  - 全ての関係は契約を守ることが期待される
    - 契約
      - 代数的規則
      - 前条件と後条件の関係
        - ユーザー
          - 前条件に責任を持つ
          - 操作を呼ぶ前に前条件が真であることを保証する
        - 抽象の実装
          - 後条件に責任を持つ
          - 操作から戻るとき、後条件が常に真であることを保証する
  - データ抽象はユーザーが契約を守っているかどうかチェックする
    - 前条件と後条件を使っている場合
      - ユーザーとデータ抽象の境界で前条件をチェックするだけ
      - データ抽象の中では前条件は正しいと仮定できる
        - 実装がシンプルになる
      - コンパイル時、実行時にも行える
        - できればコンパイル時にチェックすることが望ましい
        - 前条件の表現力の豊かさとコンパイルのチェック可能性の関係は興味深い研究分野

#### 訓話

- OOPの誤用が原因の1つとなり失敗したプロジェクト
  - 代替性が成り立たないことが多発した
    - あるclassのobjectでは正しく動くルーチンが、下位classのobjectでは動かない
  - 小さな問題を修正するのに、下位classを作って修正した
    - classを修正するのではなく、パッチをあてる下位classを定義した
    - objectの起動がパッチの個数分遅くなる
    - 階層が不要に深くなり、複雑さがました
- 教訓
  - **継承を正しく使え**
    - **代替性を尊重せよ**
    - **新しい機能を追加するために使え**
      - 欠陥classにパッチを当てるために用いるな
    - **共通デザインパターンを学べ**

#### リエンジニアリング

- 継承の正しくない使い方など、アーキテクチャ上の問題を解決するのに使える
- ソースコードを変更することで性質のいくつかを改良しようとすること
  - システムアーキテクチャ
  - モジュラ性
  - 性能
  - 可搬性
  - ドキュメンテーションの品質
  - 新技術の使用
  - ...
- 失敗したプロジェクトを蘇生させることはできない
  - 病気を防ぐような設計をしておくべき
  - 要求の変更に適応できるようにシステムを設計するのが最善

### 7.4.2. 型に従って階層を構成すること

- 再起のあるプログラムの良い書き方
  - データ構造の型を定義する
  - 型に従って再帰的プログラムを構成する

- list型の例

```
<List T> ::= nil
              | T '|' <List T>
```

- リスト抽象をClassとして表現する
  - 代替性を尊重した自然な設計
  - `ListClass`: **抽象Class(abstract class)**
    - 定義されないままのmethodがあるようなClass
    - 具体化できない
      - methodを欠いているため
    - 抽象Classを継承して別のClassを定義し、欠けているmethodを追加しようという考え方
  - `NilClass`, `ConsClass`: **具体Class(concrete class)**
    - 抽象Classで欠けているmethodを定義する

```
class ListClass
   meth isNil(_) raise undefinedMethod end end
   meth append(_ _) raise undefinedMethod end end
   meth display raise undefinedMethod end end
end

class NilClass from ListClass
   meth init skip end
   meth isNil(B) B=true end
   meth append(T U) U=T end
   meth display {Browse nil} end
end

class ConsClass from ListClass
   attr head tail
   meth init(H T) head:=H tail:=T end
   meth isNil(B) B=false end
   meth append(T U)
      U2={@tail append(T $)}
   in
      U={New ConsClass init(@head U2)}
   end
   meth display {Browse @head} {@tail display} end
end

L1={New ConsClass
    init(1 {New ConsClass
	    init(2 {New NilClass init})})}
L2={New ConsClass init(3 {New NilClass init})}
L3={L1 append(L2 $)}
{L3 display} % => 1, 2, 3, nil
```

### 7.4.3. 凡用class

- **凡用class(generic class)**
  - データ抽象の機能の一部しか定義しないclass
  - object生成に使う前に完成しなければならない
- 定義する方法
  - 継承を利用
    - OOPでよく使う
    - 高階プログラミングの構文的変種に過ぎない
  - 高階プログラミングを利用

#### 継承を使うこと

- OOPにおいてclassを凡用的にすること
  - 抽象classを用いる
- ListをSortする抽象Class`GenericSort`
  - クイックソートを使用
  - bool型比較演算子`less`を必要とする
    - ソートするデータの型に定義は依存する
- 具体Class
  - `less`の定義を追加する
    - 整数
    - 有理数
    - 文字列
    - ...
  - 

```

class GenericSort
   meth init skip end
   meth qsort(Xs Ys)
      case Xs
      of nil then Ys = nil
      [] P|Xr then S L in
	 {self partition(Xr P S L)}
	 {Append {self qsort(S $)}
	  P|{self qsort(S $)} Ys}
      end
   end
   meth partition(Xs P Ss Ls)
      case Xs
      of nil then Ss=nil Ls=nil
      [] X|Xr then Sr Lr in
	 if {self less(X P $)} then
	    Ss=X|Sr Ls=Lr
	 else
	    Ss=Sr Ls=X|Lr
	 end
	 {self partition(Xr P Sr Lr)}
      end
   end
end
```

```
class IntegerSort from GenericSort
   meth less(X Y B)
      B=(X<Y)
   end
end

class RationalSort from GenericSort
   meth less(X Y B)
      '/'(P Q)=X
      '/'(R S)=Y
   in B=(P*S<Q*R) end
end
```

#### 高階プログラミングを使うこと

- classは第一級の値
  - 引数を持ち、その引数で特殊化したclassを返す関数を定義できる
- 関数`ProcSort`
  - bool型比較演算子を引数とする
  - 引数の演算子をもって特殊化したソートクラスを返す

```
fun {MakeSort Less}
   class $
      meth init skip end
      meth qsort(Xs Ys)
	 case Xs
	 of nil then Ys = nil
	 [] P|Xr then S L in
	    {self partition(Xr P S L)}
	    {Append {self qsort(S $)}
	     P|{self qsort(S $)} Ys}
	 end
      end
      meth partition(Xs P Ss Ls)
	 case Xs
	 of nil then Ss=nil Ls=nil
	 [] X|Xr then Sr Lr in
	    if {self less(X P $)} then
	       Ss=X|Sr Ls=Lr
	    else
	       Ss=Sr Ls=X|Lr
	    end
	    {self partition(Xr P Sr Lr)}
	 end
      end
   end
end
```

有理数は`/`をラベルとする対で表す

```
IntegerSort = {MakeSort fun {$ X Y} X<Y end}
RationalSort = {MakeSort fun {$ X Y}
			    '/'(P Q) = X
			    '/'(R S) = Y
			 in P*S<Q*R end}

ISort={New IntegerSort init}
RSort={New RationalSort init}
{Browse {ISort qsort([1 2 5 3 4] $)}}
{Browse {RSort qsort(['/'(23 3) '/'(34 11) '/'(47 17)] $)}}
```

#### 検討

- 継承を使って、ある操作を別の操作につなぐ(plug in)
  - 高階プログラミングの1つの形式と言える
  - 第1の操作を第2の操作に渡している
- 違いは？
  - 継承階層は一般にコンパイル時に定義されなければならない
    - 静的凡用性
    - コンパイラ
      - 最適化されたコードを生成できる
      - エラーチェックを施せる
  - 高階プログラミング
    - 動的凡用性
    - より柔軟に振る舞う


### 7.4.4. 多重継承

### 7.4.5. 多重継承に関するおおざっぱな指針

- 完全に独立の2つの抽象を結合するときはうまくいく
  - 共通点のない抽象
- 共通点のある抽象の場合は困難
  - 好ましくない相互作用が生まれる
  - 同じclassを継承しているかどうかに関わらず、共通概念があれば避けた方がよい
- 兄弟関係にある2classの親classにattributeがある場合は困難
  - **実装共有問題**
    - 共有の祖先に重複して操作を施す恐れがある
    - 初期化のときに起こりがち
      - 2回上位classを初期化してしまう
  - 解決策
    - 重複を避ける
    - そもそも継承しない
- 名前衝突が起こる場合は注意が必要
  - 同レベルの上位classに同じmethodラベルがあるとき
    - 衝突を起こしたmethodをoverrideする局所的methodを定義すべき
  - method頭部に名前値を使うと衝突を避けられる
    - mixin classで有用
      - 多重継承を行うことが多い
      - 既存のclassに機能追加するが、classの内容について知る必要のないclass

 ### 7.4.6. class図の目的
 
 - アプリケーションのclass構造を視覚化するツール
 - UML手法の核心として使われる
 - 限界
   - classの機能を記述しない
     - methodが不変表明を必要としても、class図には現れない
   - アプリケーションの動的な振る舞いを表せない
     - 時間とともに発展していく様子など
     - フェーズごとに対応するclass図が変わることも
     - アプリケーションが並列的で独立した部分が協調して相互作用することが多い(?:)
   - アプリケーションのcomponent階層の1レベルしかモデル化しない
     - 上手く構造化されたアプリケーションは階層的に分解される
       - classとobjectは階層の底辺近くに位置する
       - class図は底辺近くの分解のみを表現する
 - 限界を緩和するツール
   - **相互作用図**
     - 動的振る舞いの一部を図化する
   - **パッケージ図**
     - 階層の上部にあるcomponentを図化する

### 7.4.7. デザインパターン

- 本著で既に触れたデザインパターン
  - 宣言的プログラミングにおいて、型の構造に従って関数を構成する規則
    - 複雑な再帰的データ構造を使うプログラムが、データ構造の型を見ることで簡単に書ける
    - 型定義がプログラムの構造に反映する
  - 機能を安全な覆いに包むことでデータ抽象を安全にする
    - 抽象が行う処理とは独立
    - どんな抽象に対してもうまくいく

#### 合成パターン

- **合成パターン(composite pattern)**
  - objectの階層を構築する
  - 葉を定義するclassが与えられたとき、木を定義するのに継承をどう使うかを示す
    - 木を定義するclassを返す
  - 高階プログラムに似ている？
    - classを受け取り、別のclassを返す関数を定義する
  - たいていのOOP言語では許されていない関数定義の方法
    - classを第1級の値と考えないため
    - 関数が引数のclassの上位classを定義することとなるため
      - 下位classは定義できるが、上位classを定義できない
- デザインパターン
  - 思考整理の方法
  - 言語の支援は必要ないもの


## 7.5. 他の計算モデルとの関係

- OOP
  - 明示的状態と一緒に使われる
  - 特徴: 多態性、継承を用いる
    - 多態性: 一般的な技法、OOPに限ったものではない
  - 継承に焦点を当てる
- 継承
  - 新しい概念ではない
  - `class`言語抽象をどのように定義するのか、ということから浮かび上がってくる
- 継承が他の高階技法とどのように関係するのか
- *Everything should be an object*について吟味する

### 7.5.1. objectベースプログラミングとcomponentベースプログラミング

- objectベースプログラミング
  - 継承抜きのOOP
  - class構文ありのcomponentベースプログラミング
- 特徴
  - 状態をカプセル化する
  - 状態への複数の操作を定義するのに便利な記法
  - object抽象が簡単になる
    - 継承がない
      - overrideの問題がない
      - 多重継承の複雑さがない
      - 静的束縛と動的束縛の区別がない


### 7.5.2. 高階プログラミング

- OOPと高階プログラミングは密接に関係している
- e.g. ソートルーチン
  - 順序関数によってパラメータ化されている
  - 順序関数を与えることで新しいソートルーチンが生成される

```
% === routine定義 ===
% 高階プログラミング
proc {NewSortRoutine Order ?SortRoutine}
  proc {SortRoutine InL OutL}
    % ... {Order X Y}が順序を決める
  end
end

% OOP
proc SortRoutineClass
  attr ord
  meth init(Order)
    ord:=Order
  end
  meth sort(InL OutL)
    % ... {@ord order(X Y $)}が順序を決める
  end
end


% === 順序関数定義 ===
% 高階プログラミング
proc {Order X Y ?B}
  B=(X<Y)
end

% OOP
class OrderClass
  meth init skip end
  meth order(X Y B)
    B=(X<Y)
  end
end


% === sort routineの具体化 ===
% 高階プログラミング
SortRoutine={NewSortRoutine Order}

% OOP
SortRoutine={New SortRoutineClass init({New OrderClass init})}
```

#### オブジェクト指向プログラミングが加えた装飾

- OOPが高階プログラミングを装飾している(embellish)
  - 手続き抽象だけでなく、付加的なイディオムの集まりを定義した豊かな抽象
- 特徴
  - 明示的状態が定義でき、簡単に使える
  - 同じ明示的状態を共有する複数のmethodを簡単に定義できる
    - objectを起動する(?:呼ぶ)と、それらのうちの1つが選ばれる
  - classが用意されている
    - class
      - methodの集合を定義し、具体化できる
      - インスタンスごとに新しい明示的状態が生成される
      - 手続きを返す手続き
  - 継承が用意されている
    - 既存のmethodの集合から、methodを拡張、修正、組み合わせることで新しいmethodの集合を定義する
    - 静的束縛と動的束縛の貢献
  - 様々な度合いのカプセル化が定義できる
    - attributeとmethodについて定義できる
    - `private` `public` `protected` ...
- 根本的に新しい機能を用意するものではない
  - 有用なイディオム
- (?:歴史的に？本書の流れから？)既存の概念を用いて完全に定義できる
  - 高階プログラミング
  - 明示的状態
  - 名前値
- 豊富な記法: 諸刃の剣
  - プログラミング作業に有用な抽象
  - semanticsが複雑、推論が困難
- プログラム構造が著しく簡単になる場合にのみOOPを用いるべき
  - 密接に関連するデータ抽象の集合がある
  - 明らかに継承の必要がある場合
- もっと簡単なプログラミング技法を使用する選択肢も持つべき

#### 共通の限界

- 全てのオブジェクトシステムが高階プログラミングに近いわけではない
- 機能が無かったり、使いづらかったりする
  - 値としてのclass
    - classが実行時に生成され、引数として渡され、データ構造に格納できる
  - 完全字句的スコープ
    - 外部参照を含む手続き値を言語が支援していること
    - 手続き、classのスコープの中でclassを定義できる
    - Java
      - 手続き値は内部classのインスタンス
      - 長ったらしい
  - 第一級のメッセージ
    - メッセージのラベルとmethodのラベルはコンパイル時に分かっている必要がある
    - 制限を取り払う方法
      - メッセージは実行時に計算できる任意の値でよい、とする
    - SmalltalkやJavaにこの機能がある
      - 普通の静的method起動よりも長ったらしい
      - e.g. classに`batching`処理を追加する(?:)
  - 手続き値はobjectとしてコード化できる(?:)
    - objectのattributeがその手続き値の外部参照を表す
    - methodの引数がその手続き値の引数
  - 凡用手続きは抽象classとしてコード化できる
    - 

