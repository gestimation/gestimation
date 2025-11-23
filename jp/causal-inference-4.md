# Story and Quiz − Causal inference IV

【キーワード: DAG, 中間媒介因子, 交絡/情報バイアス/選択バイアス, 共変量の選択, 観察研究】　【難易度: ★★★】

### ブロックの意味

**私「お父さんがDAGを説明してくれたときにさ、ブロックって用語が出てきたでしょ。合流点がパスをブロックするとか」**

お父さん「出てきたね」

**私「あれって、因果の流れが止まるって意味だよね」**

お父さん「うーん、その言い回しは厳密じゃない気がするなあ。ブロックは、DAG上のパスの性質について述べたもので、因果関係とは直接関係ない。パスが合流点を含んでいたり、非合流点を交絡因子として調整したりすることを指すんだけど」

**私「合流点があると、そのパスはなにもしなくてもブロックされる。非合流点については、調整するとパスがブロックされるってことね」**

お父さん「うん。専門的には、パスをブロックすると、ノードとノードを”有向分離”できるっていうのがポイントなんだけどなあ。有向分離の定義にも触れておいた方が誤解がなさそうだね」

::: callout-note
<img src="https://www.notion.so/icons/alert_blue.svg" alt="https://www.notion.so/icons/alert_blue.svg" width="40px"/> **有向分離（d-separation）**

DAG上に、異なるノードを要素とする3つの集合があるとし、それぞれをA、B、Cと表す。以下の2条件を満たすとき、CはAとBを有向分離する（Greenland 1999）。

-   AとBを結ぶ合流点を含まないすべてのパスは、Cの要素を含んでいる
-   Cに、AとBを結ぶパス上の合流点が含まれているとする。このとき、合流点を調整することでAとBを結ぶパスが生じたとしても、そのパスはCの別の要素を調整することでブロックできる
:::

**私「話がややこしくなってきた」**

お父さん「そうでしょ。ノードの数が増えると、ノードの集合を考えないといけなくなって、定義が複雑になっちゃう。だから単純なケースで意味を確かめよう。この3つのDAGで、CはEとDを有向分離すると思う？」

![](causal-inference-4-1.png)

**私「まず、EとDを結ぶパスはどのDAGもひとつ。上の2つのDAGは合流点を含んでいないし、パス上にCがある。だから有向分離してるはず。一番下はどうだろう。Cは合流点だし、パスE-C-Dは、別の要素で遮断できないよね。だから有向分離の条件に当てはまらない」**

お父さん「その通り。”共通原因や中間媒介因子で調整するとパスがブロックされる”とか”合流点で調整すると、パスがブロックされなくなる”っていうことを正確に表現すると、上の定義になるってことがわかったでしょ。もう少しDAGが複雑になると、この定義のよさがわかると思う。このDAGで、EとDを有向分離するのは、どのノードの集合だろう」

![](causal-inference-4-2.png)

**私「合流点はないよね。だから有向分離するのはAとC？」**

お父さん「それだけじゃないよね。Aだけ、またはCだけでも、有向分離の条件を満たすでしょ」

**私「確かにそうね。ということは、AとCのどちらかのデータを取っておけば、交絡を調整できるってこと？」**

お父さん「そういうこと。じゃあ次のDAGについて考えようか」

![](causal-inference-4-3.png)

**私「まだやるの？こっちから話しかけといてわるいけど、これで最後ね、お父さん。えっと、この図を考えればいいのね。AとBはそれぞれ有向分離するんじゃない？Cは合流点だから、有向分離できない」**

お父さん「そこまでは正しい。だけど有向分離できるのはそれだけじゃない。AとC、またはBとCはどうだろう。Cは合流点だけど、AまたはBによってパスE←A→C←B→Dは遮断できるでしょ」

**私「なるほど、二つ目の条件を使ったわけだ。丁寧に説明してくれたおかげで、どういうとき有向分離してるかっていうのはわかったつもりだけど。どういう意味があるの、これ？」**

お父さん「今回の話は、ブロックをちゃんと説明するっていうのが目的だったんだけど、ぴんとこなかったかなあ。さっきのDAGについていえば、有向分離できる変数の集合を探すことで、バイアスを防げる交絡因子の組み合わせを見つけられたっていう話の流れだったんだけど。もうひとつだけ付け加えるなら、DAGを確率変数に置き換えると、有向分離は条件付独立性と同じっていうことが知られている。この結果を用いて、因果効果を識別するために必要な交絡因子を見つけることができるんだ（バックドア基準とフロントドア基準）（Pearl 1995）」

::: callout-note
<img src="https://www.notion.so/icons/alert_blue.svg" alt="https://www.notion.so/icons/alert_blue.svg" width="40px"/> **有向分離と条件付独立性**

DAGを用いて、CがAとBを有向分離することが確認できたとする。そのとき、確率変数Cを与えた下で、AとBが条件付独立ということもわかる（Pearl 1995）。
:::

::: callout-note
<img src="https://www.notion.so/icons/help-alternate_blue.svg" alt="https://www.notion.so/icons/help-alternate_blue.svg" width="40px"/> **最後にクイズです**

このDAGの解釈として正しいのはどちらでしょうか。

1.  Cを与えた下で、EとDは条件付独立である
2.  Cを与えても、EとDの間には相関がある

![](causal-inference-4-4.png)
:::

::: {.callout-note collapse="true" title="解答を表示"}
-   **正解と解説**

    正解は2です。

    パスE←C→DはCで遮断できますが、パスE→Dは遮断できません。したがって、CではEとDを有向分離できません。ただし、この場合には、有向分離できない理由は、EとDを結ぶ直接の因果関係が残ってしまうことであるという点に注意してください。EのDへの効果を推定するときには、（パスE→Dがあるかどうかにかかわらず）Cを調整すべきです。
:::

::: callout-note
<img src="https://www.notion.so/icons/help-alternate_blue.svg" alt="https://www.notion.so/icons/help-alternate_blue.svg" width="40px"/> **もうひとつクイズです**

このDAGの解釈として正しいのはどちらでしょうか。

1.  Cで条件付けないとき、EとDは独立である。また、Cを与えた下でも、EとDは条件付独立である
2.  Cで条件付けないとき、EとDには相関がある。一方で、Cを与えた下で、EとDは条件付独立である
3.  Cで条件付けないとき、EとDは独立である。一方で、Cを与えると、EとDの間には相関がある
4.  Cで条件付けないとき、EとDには相関がある。また、Cを与えても、EとDの間には相関がある

![](causal-inference-4-5.png)
:::

::: {.callout-note collapse="true" title="解答を表示"}
**正解は4です。**

この場合、最初のクイズとは違って、EとDを結ぶ直接のパスはありませんが、Cは合流点という問題があります。そのためCで調整すると、E←A→C←B→Dというパスが生じてしまい、やはりCでEとDを有向分離することはできません。
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
