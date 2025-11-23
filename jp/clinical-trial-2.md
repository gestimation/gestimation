# Story and Quiz − Statistics II

【キーワード: OS/PFS/DFS/奏効率, p値, 生存時間データ, 臨床試験】　【難易度: ★★】

### 正しくp値を解釈するための考え方

お父さん「JCOG9502の論文で生存曲線とp値の話をしたことがあったよね（Sasako, et al. 2006）。そのとき、気になったんだけどさ。どうしてp値が0.05より小さいと統計学的に有意って言ったの？」

**私「それがルールなんじゃないの？」**

お父さん「そこはね、論文の読み方を間違えてる。質問していい？論文に目を通すとき、最初にAbstract（抄録）を読むでしょ。次にどこを読む？」

**私「Results（結果）。だってどういう結果だったかはやく知りたいもん」**

お父さん「うんうん、その気持ちはすごくわかる。でも、p値を見るときに限っては、正しく解釈するために、事前にMethods（方法）を読んでおく必要がある。科学コミュニティのなかで、p値について誤解が多いことが問題視されていて、アメリカ統計協会（ASA）が、統計を専門としない研究者、実務家、サイエンスライター向けの声明を出したことがある。そのきっかけは、2014年2月のASAフォーラムにこんな投稿がなされたことだった」

**私「なんだこの禅問答」**

Q. Why do so many colleges and grad schools teach p ≤ 0.05?（なぜ多くの大学、大学院で「p ≤ 0.05」と教えているのか？）

A. Because that’s what the scientific community and journal editors use（なぜなら科学コミュニティと雑誌編集者が依然として0.05を使っているからである）

Q. Why do so many people still use p ≤ 0.05?（なぜ多くの人々が「p ≤ 0.05」を依然として使うのか？）

A. Because that’s what they were taught in college or grad school（なぜなら彼らが大学、大学院でそう教わったからである）

::: callout-note
<img src="https://www.notion.so/icons/alert_blue.svg" alt="https://www.notion.so/icons/alert_blue.svg" width="40px"/> **統計的有意性とp値に関するASA声明**

あらゆる科学論文でp値が用いられていますが、p値が誤用されたり、研究結果の解釈に悪い影響を与えたりする弊害が指摘されています。典型的なものを挙げると、研究で小さいp値が得られると、それだけで重要な知見が得られたとみなされたり、機械的にp値が0.05より小さいというだけで意思決定がなされたりするケースは、皆さんもよく目にするのではないでしょうか。

ASAは2016年に、定量的研究の実施とその解釈を改善するため、p値の適正な使用と解釈に関する6つの原則をまとめました（Wasserstein and Lazar 2016）。以下に引用します。

1.  p値はデータと特定の統計モデル（訳注:仮説も統計モデルの要素の1つ）が矛盾する程度を示す指標の1つである
2.  p値は、調べている仮説が正しい確率や、データが偶然のみで得られた確率を測るものではない
3.  科学的な結論や、ビジネス、政策における決定は、p値がある値（訳注:有意水準）を超えたかどうかにもとづくべきではない
4.  適正な推測のためには、すべてを報告する透明性が必要である
5.  p値や統計的有意性は、効果の大きさや結果の重要性を意味しない
6.  p値は、それだけでは統計モデルや仮説に関するエビデンスの、よい指標とはならない

統計学の教科書では、p値と帰無仮説の関係を中心に説明しています。しかしp値を解釈するとき大切なのは、帰無仮説だけではありません。ASA声明の趣旨は、研究計画やデータの収集から結果の報告に至るまで、統計解析の背景にあるあらゆる情報を利用しなければ、p値は正しく解釈できないということです。

原則4に注目してみましょう。ASA声明では、原則4の解説として「複数のデータ解析を実施して、そのうち特定のp値のみを報告することは、報告されたp値を根本的に解釈不能としてしまう」と述べています。かみ砕いて言うと、たくさんp値があると、そのなかで都合のいいp値を採用してしまいますよね。このような、いいとこどりの解析は、科学者の間で意識的にも無意識にも広く行われていて、偽陽性（false positive）の研究結果 ばかりが報告される一因ではないか、という問題意識を統計学者はもっています。この問題は、統計学で多重性（multiplicity）や選択的推論（selective inference）と呼ばれています。
:::

お父さん「JCOG9502論文についてもう少し説明するね。Statistical Analysis（統計解析）のところを読み返してみて。alpha error（αエラー）っていうのは、有意水準とも言うけど、どちらもp値と比べる水準のこと」

After 8 years of slow accrual, the JCOG data and safety monitoring committee approved an amendment to the sample size and analysis plan. The amended sample size was 250, with one-sided alpha error of 0.1 and beta error of 0.2, with a 12-year accrual period (in total) and 8-year follow-up.（JCOG9502論文\[Sasako, et al. 2016\]の”Statistical Analysis”から抜粋）

**私「p値を0.1と比べるってこと？0.05じゃないの？」**

お父さん「登録が難航したため、苦肉の策で有意水準を0.1に緩めたみたい。本当は試験途中に有意水準は変えるべきではないんだけど、それでも重要な知見だから、こうして論文として多くの人に読まれているわけだよね」

**私「読み飛ばしてた。自由すぎるなJCOG」**

お父さん「あとさ、ASA声明の原則4を念頭に置いて、JCOG9502の図Aと図Bを見てみてよ。生存曲線が2本、p値が4つ示されているよね。この複数のp値は、どう読み解けばいいかわかる？」

![](clinical-trial-2.png)

**私「それが知りたくて、お父さんに質問したんだけど、わかってる？図Aのp値と図Bのp値については、私もちゃんと考えてたよ。図Aの方を見ればいいんでしょ。JCOG9502の主要エンドポイントはOSで、図Aが全生存曲線だもの。でも図Aだけでも片側と両側があるじゃない。ここが意味不明で、考えこんじゃった」**

お父さん「それはそんなに難しくない。臨床試験で、試験治療群と標準治療群の成績を比べるとするでしょ。試験治療群が勝ったときだけ、有意差があったって宣言するのが、片側p値。どちらの群が勝っていても、統計的に有意かどうか判定するのが、両側p値だよ」

**私「論文を読むと、JCOG9502のプロトコール上、LTAが試験治療、THが標準治療とされてたんだよな。LTAの方が、侵襲性が高いからかな。だからLTA群の予後がいいっていう結果でないと、有意差ありって宣言しないわけだ。これって普通？」**

お父さん「いや？両側p値を使うのが普通。でもJCOGが行っている臨床試験は、試験治療群の成績が、標準治療群よりいいかどうかを調べるっていうポリシーだから、片側p値を使ってる。片側p値で有意じゃなかったら、標準治療を使い続けるから、それでいいんだって。この論文の両側p値は参考値みたいだね。つまり、有効性の主たる判断には、図Aの片側p値だけが用いられることになる」

**私「ストーマ造設あり・なしと復職状況の関係なら、意味から考えても両側p値ってことね。よくわかりました」**

::: callout-note
<img src="https://www.notion.so/icons/alert_blue.svg" alt="https://www.notion.so/icons/alert_blue.svg" width="40px"/> **片側p値と両側p値**

p値と仮説検定（hypothesis test）は、研究仮説が正しいかどうかについて、二者択一の判断をするための統計手法です。なんだか難しそうなので、例え話で説明しましょう。

コイン投げをして、6回連続で表が出たとします。このコインは、イカサマコイン（表が出る確率が1/2でない）でしょうか？p値では以下のように考えます。表が出る確率は1/2という仮説の下で、6回連続で表の確率は(1/2)の6乗で0.0156ですよね。6回連続で裏の確率は同じく0.0156です。すなわち、このような極端なデータが得られる確率は、足してp=0.0312と極めて低いことが分かります。このような極端なデータが得られるのはおかしくはありませんか？従って、このコインにはイカサマがある、というのが、p値を用いて仮説（表が出る確率は1/2）を否定するときのロジックです。

片側（one-sided）p値と両側（two-sided）p値は、コインの片側（表だけ）をみるか、両側（表と裏）をみるかに、それぞれ対応しています。コイン投げの例え話でいえば、片側p値はp=0.0156、両側p値はp=0.0312です。

JCOG9502に戻って考えてみましょう。仮説検定では3段階の手続きを行います。まず、仮説を設定します。JCOG9502では、真実は「LTA群はTH群に比べ全生存期間を延長する効果がある」と「効果がない」の2通りがあり得ます。仮説検定では、「効果がない」という仮説に注目して、帰無仮説（null hypothesis）と呼びます（こちらが、表が出る確率が1/2に対応します）。

次に、帰無仮説の下でデータがどのように分布するかを調べます。仮に、同じ対象者167人の試験を1000回繰り返したと想像してみてください。仮に効果がなかったとしても、ランダム誤差のため、LTA群の生存曲線の方がよい場合もあれば、TH群の方がよい場合もあるでしょう。しかし1000回繰り返した結果は、差がないという結果を中心に分布するはずです。そこで、この1000回の分布と、実際に観察されたデータとを比べp値を計算します。

p値とは、帰無仮説が正しい、つまり生存曲線に差がない、という仮定の下で、実際に観察された2本の生存曲線の差よりも、極端な差が観察される確率のことです。もしp値が小さければ、こんなに確率の低いことが起きるわけがない、だから生存曲線に差がないというそもそもの前提条件が間違いだ、という判断になるわけです。逆に、p値が大きければ、当たり前のことが起きたという意味になります。
:::

::: callout-note
<img src="https://www.notion.so/icons/help-alternate_blue.svg" alt="https://www.notion.so/icons/help-alternate_blue.svg" width="40px"/> **最後にクイズです**

非劣性試験や同等性試験を除くほとんどのランダム化臨床試験で、両側p値が用いられている理由として正しいものは、次のうちどれでしょうか。

1.  試験治療が優れていたとしても、劣っていたとしても、差があるなら結論を出したいから
2.  統計学者の間の決まりごと
3.  世界中の臨床試験で統一した方が、混乱が少ないから
4.  ランダム誤差は、平均の上方向と下方向の両方のばらつきを生じるから
:::

::: {.callout-note collapse="true" title="解答を表示"}
**正解は3です。**

これは歴史的経緯によるものです。1998年にICH E9ガイドラインが策定されたとき、米国、欧州、日本の規制当局で、両側p値を基本にすることが合意されました（吉村2003）。
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
