# Ichiran

Ichiran is a collection of tools for working with text in Japanese language. It contains experimental segmenting and romanization algorithms and uses open source [JMdictDB](http://edrdg.org/~smg/) dictionary database to display meanings of words.

The web interface is under development right now. You can try it at [ichi.moe](http://ichi.moe).

(This repository contains an addition to the CLI code that includes a personal feature. When segmenting large sentences it is easy to lose context of the current glossary item in the larger sentence. This addition prints the sentence with parenthesis added around the current glossary element in the sentence.)

## Dockerized version

Docker builds the same as the original repository
Build (executed from the root of this repo):

```
docker compose build
```

Start containers (this will take longer for the first time, because the db will get imported from the dump here, and other ichiran initializations will also get done here):

```
docker compose up

```

Enter the sbcl interpreter (with ichiran already initialized):

```
$ docker exec -it ichiran-master-4-main-1 ichiran-cli -i "静岡県や茨城県では、急に風が強くなって、家が壊れたりトラックが倒れたりする被害が出ました。"
```

Ichiran cli:

```
*(静岡県)や茨城県では、急に風が強くなって、家が壊れたりトラックが倒れたりする被害が出ました。*
 shizuokaken  静岡県 【しずおかけん】
1. [n] Shizuoka Prefecture (Chūbu area)


*静岡県(や)茨城県では、急に風が強くなって、家が壊れたりトラックが倒れたりする被害が出ました。*
 ya  や
1. [prt] 《used for non-exhaustive lists related to a specific time and place》 such things as ...; and ... and
2. [prt] 《after the dictionary form of a verb》 the minute (that) ...; no sooner than ...; as soon as
3. [cop] be; is
4. [int] 《punctuational exclamation in haiku, renga, etc.》 o; oh
5. [int] 《interjection expressing surprise》 huh; what
6. [int] hi
7. [int] yes; what?
8. [prt] 《indicates a question》 yes?; no?; is it?; isn't it?


*静岡県や(茨城県)では、急に風が強くなって、家が壊れたりトラックが倒れたりする被害が出ました。*
 ibarakiken  茨城県 【いばらきけん】
1. [n] Ibaraki prefecture


*静岡県や茨城県(では)、急に風が強くなって、家が壊れたりトラックが倒れたりする被害が出ました。*
 de wa  では Compound word: で + は
 * で
1. [prt] 《indicates location of action》 at; in
2. [prt] 《indicates time of action》 at; when
3. [prt] 《indicates means of action》 by; with
[ Conjugation: [cop] Conjunctive (~te) Affirmative Plain
  だ : be; is ]
 * は  [suffix]: topic marker particle 


*静岡県や茨城県では、(急に)風が強くなって、家が壊れたりトラックが倒れたりする被害が出ました。*
 kyūni  急に 【きゅうに】
1. [adv] swiftly; rapidly; quickly; immediately; hastily; hurriedly
2. [adv] suddenly; abruptly; unexpectedly
3. [adv] sharply (of a slope, bend, etc.); steeply


*静岡県や茨城県では、急に(風が強くなって)、家が壊れたりトラックが倒れたりする被害が出ました。*
 kazegatsuyokunatte  風が強くなって 【かぜがつよくなって】 Compound word: 風が強く + なって
 * 風が強く 【かぜがつよく】
[ Conjugation: [adj-i] Adverbial
  風が強い 【かぜがつよい】 : windy; windswept; blowy ]
 * なって  [suffix]: to become ... 
[ Conjugation: [v5r] Conjunctive (~te) Affirmative Plain
  成る 【なる】 : to become; to get; to grow; to turn; to reach; to attain ]


*静岡県や茨城県では、急に風が強くなって、(家)が壊れたりトラックが倒れたりする被害が出ました。*
 ie/uchi  <1>. 家 【いえ】
1. [n] house; residence; dwelling
2. [n] family; household
3. [n] lineage; family name
<2>. 家 【うち】
1. [n] one's house; one's home; one's family; one's household
2. [n] house


*静岡県や茨城県では、急に風が強くなって、家(が)壊れたりトラックが倒れたりする被害が出ました。*
 ga  が
1. [prt] indicates the subject of a sentence
2. [prt] 《literary in modern Japanese; usu. written as ヶ in place names》 indicates possession
3. [conj,prt] but; however; (and) yet; though; although; while
4. [prt] and
5. [prt] used after an introductory remark or explanation
6. [prt] 《after the volitional or -まい form of a verb》 regardless of ...; whether ... (or not); no matter ...
7. [prt] indicates a desire or hope
8. [prt] 《at sentence end》 softens a statement
9. [prt] 《at sentence end》 indicates doubt
10. [prt] 《after a noun at the end of an interjection》 indicates scorn


*静岡県や茨城県では、急に風が強くなって、家が(壊れたり)トラックが倒れたりする被害が出ました。*
 kowaretari  壊れたり 【こわれたり】

[ Conjugation: [v1] Alternative (~tari) Affirmative Plain
  壊れる 【こわれる】 : to be broken; to break; to fall apart; to collapse; to be destroyed; to be damaged ]


*静岡県や茨城県では、急に風が強くなって、家が壊れたり(トラック)が倒れたりする被害が出ました。*
 torakku  トラック
1. [n] truck; lorry


*静岡県や茨城県では、急に風が強くなって、家が壊れたりトラック(が)倒れたりする被害が出ました。*
 ga  が
1. [prt] indicates the subject of a sentence
2. [prt] 《literary in modern Japanese; usu. written as ヶ in place names》 indicates possession
3. [conj,prt] but; however; (and) yet; though; although; while
4. [prt] and
5. [prt] used after an introductory remark or explanation
6. [prt] 《after the volitional or -まい form of a verb》 regardless of ...; whether ... (or not); no matter ...
7. [prt] indicates a desire or hope
8. [prt] 《at sentence end》 softens a statement
9. [prt] 《at sentence end》 indicates doubt
10. [prt] 《after a noun at the end of an interjection》 indicates scorn


*静岡県や茨城県では、急に風が強くなって、家が壊れたりトラックが(倒れたり)する被害が出ました。*
 taoretari  倒れたり 【たおれたり】

[ Conjugation: [v1] Alternative (~tari) Affirmative Plain
  倒れる 【たおれる】 : to fall (over, down); to collapse; to take a fall; to topple ]


*静岡県や茨城県では、急に風が強くなって、家が壊れたりトラックが倒れたり(する)被害が出ました。*
 suru  する
1. [vs-i] to do; to carry out; to perform
2. [vs-i] to cause to become; to make (into); to turn (into)
3. [vs-i] to serve as; to act as; to work as
4. [vs-i] to wear (clothes, a facial expression, etc.)
5. [vs-i] 《as 〜にする,〜とする》 to judge as being; to view as being; to think of as; to treat as; to use as
6. [vs-i] 《as 〜にする》 to decide on; to choose
7. [vs-i,vi] 《as 〜がする》 to be sensed (of a smell, noise, etc.)
8. [vs-i,vi] to be (in a state, condition, etc.)
9. [vs-i,vi] to be worth; to cost
10. [vs-i,vi] to pass (of time); to elapse
11. [vs-i,vt] 《as AをBにする》 to place, or raise, person A to a post or status B
12. [vs-i,vt] 《as AをBにする》 to transform A to B; to make A into B; to exchange A for B
13. [vs-i,vt] 《as AをBにする》 to make use of A for B; to view A as B; to handle A as if it were B
14. [vs-i,vt] 《as AをBにする》 to feel A about B
15. [suf,vs-i] verbalizing suffix (applies to nouns noted in this dictionary with the part of speech "vs")
16. [aux-v,vs-i] creates a humble verb (after a noun prefixed with "o" or "go")
17. [aux-v,vs-i] 《as 〜うとする,〜ようとする》 to be just about to; to be just starting to; to try to; to attempt to


*静岡県や茨城県では、急に風が強くなって、家が壊れたりトラックが倒れたりする(被害)が出ました。*
 higai  被害 【ひがい】
1. [n] (suffering) damage; injury; harm


*静岡県や茨城県では、急に風が強くなって、家が壊れたりトラックが倒れたりする被害(が)出ました。*
 ga  が
1. [prt] indicates the subject of a sentence
2. [prt] 《literary in modern Japanese; usu. written as ヶ in place names》 indicates possession
3. [conj,prt] but; however; (and) yet; though; although; while
4. [prt] and
5. [prt] used after an introductory remark or explanation
6. [prt] 《after the volitional or -まい form of a verb》 regardless of ...; whether ... (or not); no matter ...
7. [prt] indicates a desire or hope
8. [prt] 《at sentence end》 softens a statement
9. [prt] 《at sentence end》 indicates doubt
10. [prt] 《after a noun at the end of an interjection》 indicates scorn


*静岡県や茨城県では、急に風が強くなって、家が壊れたりトラックが倒れたりする被害が(出ました)。*
 demashita  出ました 【でました】

[ Conjugation: [v1] Past (~ta) Affirmative Formal
  出る 【でる】 : to leave; to exit; to go out; to come out; to get out ]
```

