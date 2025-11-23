# Story and Quiz − Terminology

---

### 統計学のことば

**私「コーヒー飲む？お父さん」**

お父さん「ああ、ありがとう。おいしいね」

**私「うん、あったまるよね。そういえばこの前出たワクチンってすごいね。有効率95%だって」**

お父さん「そうだね。でもさ、ワクチンの有効率って意外と計算が難しいんだよ。プラセボに比べてって意味だから」

**私「ん？100人いたら95人に効くって意味じゃないの？」**

お父さん「違う違う。プラセボの効果に比べて、どのくらい感染を予防できるっていう意味のパーセントなんだ。論文ではともかく日常会話では誤解されやすい言葉だよね」

<aside>
<img src="https://www.notion.so/icons/alert_blue.svg" alt="https://www.notion.so/icons/alert_blue.svg" width="40px" /> **割合を比較する指標**

医学では分野によってさまざまな指標が用いられており、特に割合を比較する指標はわかりにくいものが少なくありません。群1のリスク（割合）を$\pi_1$、群2のリスク（割合）を$\pi_2$とすると、各指標の計算式は、以下の通りです。なお、これらの指標を使うときは、どちらの群を基準に比較しているかを意識することが大切です。NNTを計算するときは$\pi_1>\pi_2$、

- リスク差（絶対リスク減少）: ${\pi_1}-{\pi_2}$
- リスク比: $\frac{\pi_1}{\pi_2}$
- Number needed to treat（NNT）:  $\frac{1}{\pi_1-\pi_2}$
- ワクチン有効率（相対リスク減少）: $\frac{\pi_2-\pi_1}{\pi_2}$
</aside>

**私「へー、確かにパーセントっていわれるとただの割合と思いがちだよね。お父さんって、頭の中にいつもこんな計算式があるの？いきなり式が出てくると違和感あるなあ。統計学と医学ってだいぶ雰囲気が違うね」**

お父さん「もう慣れちゃったのかもね。でも、式で書かないと、ワクチン有効率がなんなのか、わからないでしょ」

**私「確かにね。数字だけみると、レトリックに騙されちゃいそう。そうだ、いろいろ統計用語を説明してくれたでしょ。正直いって実感がわかないのもあったんだ。よければ統計用語を日常用語で言い換えてみてくれないかな」**

お父さん「時間があるからいいよ、いくつかやってみようか。五十音順に並べるね」

αエラー　alpha error

治療が本当は効かないのに有効と考えたり、関連がないのにあると判断してしまったりする類の誤り。偽陽性といってもよい。p値などを用いて5%以下に抑えることが、医学研究の慣習になっている

一般化線型モデル　generalized linear model

「回帰モデル」の一種で、回帰分析、分散分析、ロジスティック回帰などの統計手法の総称。統計ソフトウェアでは”GLM”という略称がよく用いられる

打ち切り　censoring

生存時間データを測定するとき、ある特定の時点で観察が妨げられ、その時点以降に関心のあるイベントが発生したであろうことしかわからなくなること

回帰モデル　regression model

ある変数が他の変数とどのような関連にあるのかを調べるための統計手法。回帰分析と同義だが、「分析」は統計手法を指すニュアンスがあるのに対して、「モデル」というとなんらかの数式や確率分布を意味することが多い。

片側p値　one-sided p-value

相関には、正の相関と負の相関があるが、そのうちのどちらかにしか関心がないとき用いられるp値のこと。片側ではなく両側p値を用いることが一般的

競合リスク　competing risk

生存時間データを測定するときに、それが起こると関心のあるイベントが観察されなくなる、競合するイベントのこと

Cox回帰　Cox regression

1972年にCox教授が発明し、大流行した統計手法。回帰モデルの一種だが、一般化線型モデルではない。生存時間をアウトカムとして扱い、生存曲線の差をハザード比として要約したり、様々な因子が生存時間と関連があるかどうか検討するために利用される

サンプルサイズ設計　sample size calculation

対象者数などの研究の規模を決めること。たとえば、効果サイズ、αエラー、βエラー（または検出力）を設定することで、研究に必要な対象者数を計算できる

推定目標（エスティマンド）　estimand

臨床試験で治療を始めた後に、有害事象が生じたり、治療を中止したりすると、その試験でどのような治療効果を調べたいのか曖昧になる。推定目標とは、その研究でなにを推定したいのかを意味する統計用語。臨床試験では、計画段階で推定目標を決めておくことが、ICH E9ガイドラインにより求められている

生物統計家　biostatistician

医学・生命科学における統計専門家のことだが、バイオインフォマティシャン、データサイエンティスト、疫学者とは、所属学会やコミュニティーが異なる。狭い意味では、臨床試験を専門とする統計プロフェッショナルのことを指し、そのための資格（試験統計家認定制度）もあるくらいだが、生物（bio）という接頭辞がついているためわかりにくい

生存曲線　survival curve

横軸に時間を、縦軸にその時点で生存している割合を図示したグラフのこと。がんや循環器疾患など多くの疾患領域で、臨床試験の結果は生存曲線として示されることが多いため、生存曲線の正しい見方を知っておくとよい

効果サイズ　effect size

治療の効果の大きさや、治療を比較したときの差のこと。サンプルサイズ設計では、効果サイズの値を設定しなければならないが、そもそもそれを知りたいから研究をするのだから悩ましい。このジレンマを皮肉って、「サンプルサイズから逆算して出した集積可能な差のこと」といった人もいる

代替エンドポイント　surrogate endpoint

治療が患者の予後に与える効果を調べるとき、臨床的に意味のある指標が得られないことがある。そのような状況で代わりに用いられるエンドポイントやアウトカムのこと。たとえばがん臨床試験では、奏効率が全生存期間の代替エンドポイントとして用いられてきたが、延命効果があるかどうかを必ずしも反映しないという批判も多い

デザイン　design

統計学では昔から実験計画のことを”design”と呼んできたが、それが転じて、研究立案やその際に決めるべき要素を意味するようになった。ランダム化臨床試験、調査、コホート研究などは、デザインの一種

バイアス　bias

一般的には偏った見方や行動を指す言葉だが、統計学では、推定値が真値（推定目標）からずれる傾向やその程度の意味で用いられる。データを集めた後にバイアスがあることがわかったとしても、対処は難しい

比　ratio

ある量を別の量で割ることで求められる指標。割合と率は比の一種

p値　p-value

研究結果をみるとき、真っ先に見てしまいがちな数字。p値が0.05より小さいと、誤差を越えた関連があるとみなされる

Fine-Grayモデル　Fine-Gray model

1999年にFine教授が発明した、Cox回帰を拡張した統計手法。競合リスクを含む生存時間データがアウトカムのときの回帰モデルの一種

βエラー　beta error

サンプルサイズ設計の鍵になる数字。せっかく臨床試験を行ったのに、真に効く治療を有効性がないと判断してしまう確率のこと。データをたくさん集めることができ、βエラーが低いことを、「検出力が高い」という

ランダム化　randomization

新規治療と標準治療のように、介入の効果を比べたいとき、どの介入を受けるかをランダム（無作為）に決める操作のこと。バイアスが生じないようにする工夫のひとつ

率　rate

一定時間に事象が生じるスピードを表す指標。疫学では、人年法（発生数/観察人年）で計算される。人数を人数×年で割っているため、単位は1/年（より一般には1/時間）

両側p値　two-sided p-value

相関には、正の相関と負の相関があるが、両方に関心があるとき用いられるp値のこと。片側ではなく両側p値を用いることが一般的

ロジスティック回帰　logistic regression

ある事象が生じる確率と、他の変数との関連を調べるための統計手法。2値データがアウトカムのときの回帰モデルの一種。回帰係数の指数（exponential）をとることでオッズ比を計算できる

割合　proportion

全体に対してそれが占める分量を表す指標。2値データや分類データを要約するために用いられる。人数を人数で割っているため、単位がキャンセルして単位を持たない（無単位）

<aside>
<img src="https://www.notion.so/icons/help-alternate_blue.svg" alt="https://www.notion.so/icons/help-alternate_blue.svg" width="40px" /> **最後にクイズです**

以下の4つの単語は、正式な統計用語ではありませんが、しばしば臨床試験の文献で目にするものです。このうち、誤りとはいえないものはどれでしょう。

1. サンプル数
2. COX回帰
3. OS曲線
4. *T*検定

- **正解と解説**
    
    正解は3です。
    
    サンプルサイズのことをサンプル数と表記している文献がありますが、サンプル数は臨床試験でいえば群の数に相当するので、用法として誤りです。Coxは人名なので、1文字目以外は大文字ではありません。OS曲線は、overall-survival curveの意味ととれなくはないので、誤りとはいえないでしょう。*t*検定のことを*T*検定と表記するケースも目にします。*T*検定は、*t*検定とは別の統計手法として存在するのですが、臨床試験では使われないため誤記でしょう。
    
</aside>

<aside>
<img src="https://www.notion.so/icons/help-alternate_blue.svg" alt="https://www.notion.so/icons/help-alternate_blue.svg" width="40px" /> **もうひとつクイズです**

この人は誰でしょう。

1. Kaplan
2. Meier
3. Cox
4. Wilcoxon

![330px-Nci-vol-8182-300_david_cox.jpg](Story%20and%20Quiz%20%E2%88%92%20Terminology/330px-Nci-vol-8182-300_david_cox.jpg)

- **正解と解説**
    
    この方がCox先生です。
    
    [David Cox (statistician) - Wikipedia](https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FDavid_Cox_(statistician)&psig=AOvVaw03oC1_8ftWce7mfJGOJchO&ust=1664605885062000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCOCwqqXyu_oCFQAAAAAdAAAAABAD)
    
</aside>

### Continuation  of their story

[Story and Quiz − Introduction](https://www.notion.so/Story-and-Quiz-Introduction-1c572d2fdd924a4da0327887ebad0b5f?pvs=21) 

[Story and Quiz − Study design I](https://www.notion.so/Story-and-Quiz-Study-design-I-bcc40603f7b34ab5be012f43d619c450?pvs=21) 

[Story and Quiz − Study design II](https://www.notion.so/Story-and-Quiz-Study-design-II-47134668e81348c5826191446dd58c8e?pvs=21) 

[Story and Quiz − Study design III](https://www.notion.so/Story-and-Quiz-Study-design-III-cc2ef90f6f3a42a4bda20fe9c2bea0db?pvs=21) 

[Story and Quiz − Statistics I](https://www.notion.so/Story-and-Quiz-Statistics-I-aa68feae2b9f46efb96163ae3636c488?pvs=21) 

[Story and Quiz − Statistics II](https://www.notion.so/Story-and-Quiz-Statistics-II-c0cce3bf59ad42e2ad1729a4592a6438?pvs=21) 

[Story and Quiz − Statistics III](https://www.notion.so/Story-and-Quiz-Statistics-III-05e6e28ce96f476cb4f736c0139fdb4d?pvs=21)

[Story and Quiz − Logistic regression I](https://www.notion.so/Story-and-Quiz-Logistic-regression-I-9da4a5317bdc454a95b30fdc76f5d769?pvs=21) 

[Story and Quiz − Logistic regression II](https://www.notion.so/Story-and-Quiz-Logistic-regression-II-494341dfe5fa4b11a5ac796486df95a4?pvs=21) 

[Story and Quiz − Logistic regression III](https://www.notion.so/Story-and-Quiz-Logistic-regression-III-70d0995a006e4ab2a929d382880daccc?pvs=21) 

[Story and Quiz − Causal inference I](https://www.notion.so/Story-and-Quiz-Causal-inference-I-1b6dd1d913bc4b109c95a62d51e191f3?pvs=21) 

[Story and Quiz − Causal inference II](https://www.notion.so/Story-and-Quiz-Causal-inference-II-5bf03a705dca4e88a9bbe4d16bc0e43a?pvs=21) 

[Story and Quiz − Causal inference III](https://www.notion.so/Story-and-Quiz-Causal-inference-III-92ef16219c434a5a89c63aaa513a86bb?pvs=21) 

[Story and Quiz − Publishing a paper I](https://www.notion.so/Story-and-Quiz-Publishing-a-paper-I-21ec004317c94340808da6a1f9af97d9?pvs=21) 

[Story and Quiz − Publishing a paper II](https://www.notion.so/Story-and-Quiz-Publishing-a-paper-II-c81c994e3eb649b982a356da1b80de86?pvs=21) 

[Story and Quiz − Publishing a paper III](https://www.notion.so/Story-and-Quiz-Publishing-a-paper-III-2b6ac56a72b6442a93494a73f735eef6?pvs=21)

### Continuation of their story

[Study design I](study-design-1.md)
[Study design II](study-design-2.md)
[Study design III](study-design-3.md)
[Study design IV](study-design-4.md)
[Clinical trial I](clinical-trial-1.md)
[Clinical trial II](clinical-trial-2.md)
[Clinical trial III](clinical-trial-3.md)
[Epidemiology I](epidemiology-1.md)
[Epidemiology II](epidemiology-2.md)
[Epidemiology III](epidemiology-3.md)
[Epidemiology IV](epidemiology-4.md)
[Causal inference I](causal-inference-1.md)
[Causal inference II](causal-inference-2.md)
[Causal inference III](causal-inference-3.md)
[Causal inference IV](causal-inference-4.md)

