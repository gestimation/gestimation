# Story and Quiz − Epidemiology II

【キーワード: 2値・分類データ, リスクの指標と効果の指標, 生存時間データ, 論文の書き方】　【難易度: ★★★】

### リスクと時間の関係

**私「お父さんさ、さっき寄与割合を計算してるのをみてて思ったんだけどね。またわからないことがあるんだ」**

お父さん「なに？」

**私「がん検診後、10年、12年、20年って見ていくと、寄与割合が変わるって話だったでしょ。リスクには時間の概念があるって。あれって、2値データじゃなくて生存時間データになってない？ていうか、あれは生存曲線か」**

お父さん「そうだよ。リスクと生存曲線は表裏一体なんだ」

**私「寄与割合とかリスク比とかって、時間とともに変化するっていうけど、ハザード比は変化しないんだっけ」**

お父さん「変化しない。正確にいうと、生存曲線をみると変化している状況もあり得るんだけど、無理やり時間を通じてハザード比は一定と仮定して、計算してる」

**私「リスク比は変化するけどハザード比は変化しないの？ぴんとこないなあ」**

お父さん「えーっと、教科書通りに説明するとこうなるんだけど」

::: callout-note
<img src="https://www.notion.so/icons/alert_blue.svg" alt="https://www.notion.so/icons/alert_blue.svg" width="40px"/> **リスクと生存曲線・ハザード比の関係**

**生存曲線とハザードの関係**

Kaplan-Meier曲線もまた、割合の一種と考えることができますが、見え方がずいぶん違います。つまり、Kaplan-Meier曲線はグラフですし、時間の概念が含まれたりします。さらに、Kaplan-Meier曲線は、そもそも2値データではなく生存時間データに用いられる手法ですし、ハザード比との関係が重要です。ここでは、ハザードが時間を通じて一定という単純な状況で、そのあたりを整理しましょう。

Kaplan-Meier曲線は、生存時間データから計算された推定値を、時間軸（*x*軸）に沿ってグラフにしたものです。これを数式で書くなら、「生存曲線を時間*x*の関数*S*(*x*)で表す」ということになります。

関数*S*(*x*)を具体的に書くこともできます。生存時間が、ハザードが時間を通じて一定ということは、指数分布に従うと仮定したことになります（これはKaplan-Meier曲線とは別ものです）。指数分布の形状を決めるパラメータ（ハザード）を、*λ*で表します。このとき指数分布の生存関数とハザードには、以下のような関係があります。

$S(x)=\mathrm{exp}(-\lambda x)$

さて、ハザードは生存曲線が下がるスピードを決める数値です。生存時間がどのくらいの長さなのかは、中央値で測ることができます。生存時間中央値*M*は、生存確率50%つまり*S*(*x*)=0.5になるような時間*x*のことです。つまり、指数分布では$0.5=\mathrm{exp}(-\lambda M)$と関係が成り立つので、生存時間中央値*M*は、ハザード*λ*から以下のように計算することができます。

$M=\frac{\mathrm{log}(0.5)}{\lambda}\approx\frac{0.7}{\lambda}$

最後に、時点*x*の疾患リスクを*π*とすると、リスクとハザードは、以下の式で結びついています。

$\pi=1-S(x)=1-\mathrm{exp}(-\lambda x)$

**リスクとハザード比の関係**

次に、群1と群2のアウトカムを比較する状況を考えましょう。群1の時点*x*の疾患リスクを$\pi_1$、群2の時点*x*の疾患リスクを$\pi_2$とします。さらに、それぞれの群のハザードを$\lambda_1$と$\lambda_2$、生存時間中央値を$M_1$と$M_2$とします。

上で述べた関係式を適用すると、指数分布の下で、ハザード比は以下のように表現することができます。

-   ハザード比（指数分布を仮定）

    $HR=\frac{\lambda_1}{\lambda_2}=\frac{M_2}{M_1}=\frac{\mathrm{log}(\pi_1)}{\mathrm{log}(\pi_2)}$

**比例ハザード性**

指数分布では、ハザードは時間を通じて一定でした。その一方で、Cox比例ハザードモデルでは、ハザードを時間の関数$\lambda_1(x)$と$\lambda_2(x)$と考え、しかも両者が比例関係にあると仮定します。

-   ハザード比（比例ハザード性を仮定）

    $HR=\frac{\lambda_1(x)}{\lambda_2(x)}$
:::

**私「わからん。数式はわからん」**

お父さん「そう？数学の難しさ自体は高校レベルなんだけど。きっと理解しにくいのは、数式がデータ上のどういう概念を結びつけているのかっていう部分なんだだと思うんだけど。そこは慣れるしかないなあ」

::: callout-note
<img src="https://www.notion.so/icons/help-alternate_blue.svg" alt="https://www.notion.so/icons/help-alternate_blue.svg" width="40px"/> **最後にクイズです**

Kaplan-Meier法による生存曲線の推定が妥当な状況として正しいのは、次のうちどれでしょうか。

1.  生存時間が正規分布するとき
2.  打ち切りの理由が疾患の悪化によらないとき
3.  2群の打ち切り確率に統計学的な有意差がなかったとき
4.  試験治療群とコントロール群の間で比例ハザード性が成り立つとき
:::

::: {.callout-note collapse="true" title="解答を表示"}
**正解は2です。**

    Kaplan-Meier法では、生存時間が正規分布したり、比例ハザードが成り立ったりする必要はありません（これは*t*検定やCox回帰の前提条件ですね）。疾患の悪化に伴って、試験の途中で患者が追跡できなくなると、推定された生存曲線にバイアスが生じてしまいます。2群の生存曲線を比べるとき、それぞれの群の打ち切り確率を比較することがあります。有意差があればバイアスがあるといえますが、たとえばサンプルサイズが小さいときは有意差が出ませんから、Kaplan-Meier法が妥当という証拠にはなりません。逆にいうと、打ち切りがランダムに起きていることが、Kaplan-Meier法でもっとも重要な仮定です。
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

[Causal inference I](causal-inference-1.md)

[Causal inference II](causal-inference-2.md)

[Causal inference III](causal-inference-3.md)

[Causal inference IV](causal-inference-4.md)

[Publish a paper I](publish-a-paper-1.md)

[Publish a paper II](publish-a-paper-2.md)

[Publish a paper III](publish-a-paper-3.md)

[Publish a paper IV](publish-a-paper-4.md)
