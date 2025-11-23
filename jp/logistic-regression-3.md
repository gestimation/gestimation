# Story and Quiz − Logistic regression III

【キーワード: リスクの指標と効果の指標, 一般化線型モデル, 推定論】　【難易度: ★★★】

### 数式を使ってロジスティック回帰を教えてよ

お父さん「ロジスティック回帰はね、医学研究でよく使うから知っておいた方がいいよ。簡単にいうと、2値データのための回帰モデルの一種。ストーマ造設、年齢、性別、年収といった共変量が、復職の有無のような2通りの値をとるアウトカムとどの程度相関するかを、調べることができる」

**私「もうちょっと統計っぽく教えてよ」**

お父さん「ん？統計手法には、パラメトリック法とノンパラメトリック法があるけど、ロジスティック回帰はパラメトリックモデルの一種として位置づけられる。最近の教科書では、一般化線型モデルのひとつとして扱われることが多いかな」

**私「そういうんじゃなくてさ。最初から順序立てて教えてほしいっていうか」**

お父さん「数式使っていいの？」

**私「うん。数式でてくると、ところどころわからないんだけど。ごまかされるのもいやだから、一度正式な説明を聞いてみたいって思って」**

お父さん「じゃあ定義から話すかな」

::: callout-note

<img src="https://www.notion.so/icons/alert_blue.svg" alt="https://www.notion.so/icons/alert_blue.svg" width="40px"/> **ロジスティック回帰**

アウトカム$Y_1,Y_2,...,Y_N$が、0または1で表される個人の反応の有無を表す2値変数で、$\Pr (Y_i=1)=\pi_i$という確率で独立に分布しているとします。このとき$N$人の対象者の同時分布は

$\Pr (Y_1=y_1,...,Y_N=y_N)=\prod_{i=1}^N {\pi_i}^{y_i} (1-\pi_i)^{1-y_i}$

という2項分布の積の形で表現できます。

この分布は、個人レベルの$N$個のパラメータ$\pi_i$によって規定されます。しかし、そのすべてを推定したいわけではありません。$\pi_i$に関連する$p-1$個の共変量$X_{i,1},X_{i,2},...,X_{i,p-1}$が測定されており、両者の関連の強さに関心があるとします。このとき

$\log(\frac{\pi_i}{1-\pi_i})=\beta_0+\beta_1X_{i,1}+...+\beta_{p-1}X_{i,p-1}$

という関係が成り立つ確率分布をロジスティック回帰といいます。

この式の係数$\beta_0,\beta_1,...,\beta_{p-1}$を回帰係数（regression coefficients）、特に$\beta_0$を切片項（intercept）といいます。正規分布は平均と分散というパラメータで形状が決まりますよね。それと同じように、ロジスティック回帰の確率分布は、回帰係数というパラメータによって規定されます。

:::

**私「ふむふむ。まず、**$Y_1,Y_2,...,Y_N$っていうのは、$N$人の対象者の復職の有無みたいなものね。その同時分布の式が出てきた。つまり、ロジスティック回帰も、確率分布の一種なんだ」

お父さん「そう。ただし、確率分布の式に、共変量$X_{i,1},X_{i,2},...,X_{i,p-1}$が含まれていて、アウトカムと共変量の関連の強さを、回帰係数が決めるんだ。確率分布に含まれる未知数のことを、統計学ではパラメータと呼んでいる。そしてパラメータの関数として、確率分布を書くことができるものを、パラメトリックモデルっていうんだ。こういう風に考えると、パラメータを推定したり、推定値に信頼区間をつけたりすることが、統計解析の目標になるよね。もうひとつ知っておいてほしいのが、アウトカムと共変量の関係は、ロジット関数で結びつくと仮定していること」

::: callout-note

<img src="https://www.notion.so/icons/alert_blue.svg" alt="https://www.notion.so/icons/alert_blue.svg" width="40px"/> **リンク関数とロジット関数**

個人レベルのパラメータと共変量との関係を結びつける1対1の単調な変換

$g(\pi_i)=\beta_0+\beta_1X_{i,1}+...+\beta_{p-1}X_{i,p-1}$

のことを、一般にリンク関数（link function）といいます。ロジスティック回帰のリンク関数は、定義で述べた通り

$g(\pi_i)=\log(\frac{\pi_i}{1-\pi_i})$

です。この関数はロジット関数と呼ばれ、ロジスティック回帰を特徴付けています。

:::

**私「単に関数に名前をつけただけでしょ。もうちょっと解説が欲しいなあ」**

お父さん「そうだよね。ロジット関数も関数の一種だから、グラフにした方が特徴がつかみやすい。次の説明だとどうかな」

::: callout-note

<img src="https://www.notion.so/icons/alert_blue.svg" alt="https://www.notion.so/icons/alert_blue.svg" width="40px"/> **ロジット関数の形状**

仮に共変量が1個で、連続データだったとしましょう。確率$\pi_i$と共変量$X_i$の関係は、ロジット関数を通じて

$\log(\frac{\pi_i}{1-\pi_i})=\beta_0+\beta_1X_{i}$

という式で表されることになります。

図は、このロジット関数の$\exp(\beta_1)$の値を5、10、20、200と設定して、$X_i$を0から1までの範囲で変化させたプロットです。$\exp(\beta_1)$は、$X_i$が1SD変化したときのオッズ比に相当します。つまり、図でもっとも傾きの小さい黒い曲線は、オッズ比5のときのものです。この曲線はそれほど変化が急にはみえませんが、医学研究ではオッズ比5でもかなり強い関連です。

このように、ロジット関数はS字型の曲線を表しています。X軸方向にどんな値をとったとしても、Y軸方向の変化は0から1の範囲に収まることが、特徴のひとつです。そして、曲線の傾きは回帰係数$\beta_1$によって決まります。

![プレゼンテーション1.png](logistic-regression-3.png)

:::

**私「やっとイメージがわいた。ロジット関数って、確率と共変量との関係を表してるんだ。どれくらい年齢が上がると、復職できる確率が下がるか、みたいなことね」**

お父さん「そういうこと」

::: callout-note
<img src="https://www.notion.so/icons/help-alternate_blue.svg" alt="https://www.notion.so/icons/help-alternate_blue.svg" width="40px"/> **最後にクイズです**

脳卒中発症の有無をアウトカム、LDLコレステロールを共変量としてロジスティック回帰を当てはめたとします。LDLコレステロールの単位をmg/dLからmmol/Lに変換したとき、オッズ比は何倍になるでしょうか。ただし

LDLコレステロール(mmol/L) =LDL コレステロール(mg/dL) ×0.02586

という関係が成り立ちます。

1.  0.02586倍
2.  1/0.02586倍
3.  変化しない
4.  1、2、3すべて誤り
:::

::: {.callout-note collapse="true" title="解答を表示"}
**正解は4です。**

これは単位を換算にするにはどうすればよいかという問題です。ある共変量*X*の効果は、回帰係数*β*との積（*βX*）で表され、それは共変量の単位によらず一定ですよね。このことに気づくと、答えに近づきます。*X*の単位を定数倍すると、*β*は定数分の一に換算されます。ただし、ロジスティック回帰では、回帰係数からロジット関数を経由してオッズ比を求めるため、単位を換算するには、1/0.02586乗のようにべき乗の操作をすることになります。
:::

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

[Regression I](logistic-regression-1.md)

[Regression II](logistic-regression-2.md)

[Regression III](logistic-regression-3.md)

[Regression IV](logistic-regression-4.md)

[Causal inference I](causal-inference-1.md) 

[Causal inference II](causal-inference-2.md) 

[Causal inference III](causal-inference-3.md) 

[Causal inference IV](causal-inference-4.md)

[Publish a paper I](publish-a-paper-1.md)

[Publish a paper II](publish-a-paper-2.md)

[Publish a paper III](publish-a-paper-3.md)

[Publish a paper IV](publish-a-paper-4.md)
