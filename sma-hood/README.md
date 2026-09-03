# SMA Hood — capuz de antena a 45°, colado com PU

Leva o conector **SMA fêmea de painel** para uma face inclinada a **45°** sobre a
parede externa da caixa hermética, sem cotovelo e sem adaptador de RF. A peça é
**toda fechada** — a única abertura é o furo do SMA — e é fixada **só com cola PU**,
por uma saia ranhurada que contorna a base. Nenhum parafuso, nenhum furo lateral.

![capuz](hood_iso.png)

## Três versões, o mesmo arquivo

![quadrada, compacta e XL](hood_sizes.png)

| | Quadrada | Compacta | XL |
|---|---|---|---|
| Planta com a saia | **38 × 38 mm** | 46 × 38 mm | 66 × 58 mm |
| Altura total | 24,7 mm | 24,7 mm | 34,7 mm |
| Abertura inferior | 21 × 21 mm | 29 × 21 mm | 49 × 41 mm |
| Área de colagem | 799 mm² | 925 mm² | 1557 mm² |
| STL | `sma_hood_sq.stl` | `sma_hood.stl` | `sma_hood_xl.stl` |

Tudo o mais é idêntico nas três: mesmo conector, mesmos 45°, mesma parede de 2,5,
mesma saia de 6 mm com os 3,5 mm de selo contínuo, mesma proporção de colagem
(73% de contato / 27% de ranhura).

**A XL** existe por um motivo de montagem: com 49 × 41 de abertura e mais 10 mm de
pé-direito, o dedo entra inteiro por baixo e segura o corpo do conector enquanto se
aperta a porca do lado de fora. Custa 66 × 58 mm de parede — mais da metade da
largura de uma tampa de 110 × 110 — e ~40% mais filamento.

**A quadrada** iguala o comprimento à **largura** (26), não ao comprimento (34): é a
menor pegada das três na caixa, e a única simétrica em planta. Veja a ressalva abaixo.

## A quadrada: o que muda ao encurtar a base

![corte da quadrada com o conector](hood_sq_section.png)

Encurtar a base de 34 para 26 mm tira 4 mm de cada lado, e **o eixo do boss tem que
recuar junto** — em x = 8, com a borda da frente agora em x = 13, o boss ficaria
pendurado para fora da planta. Recuando os mesmos 4 mm (`boss_x` = 4), a parede da
frente sai **idêntica** à da retangular, 14° com a vertical; só a rampa de trás
encurta, e fica até mais em pé (65° com a horizontal, contra 52° da compacta). Das
três, a quadrada é a mais fácil de imprimir.

**Não dá para simplesmente centrar o boss.** Com `boss_x` = 0 a peça fica uma pirâmide
perfeitamente simétrica, mas a folga atrás do conector, medida no eixo, cai para
**7,9 mm** — menos que a traseira de um SMA de painel com o crimp. Com 4,0 ficam
**12,7 mm**, que é o que o corte acima mostra: porca do lado de fora, sextavado no
rebaixo, corpo/crimp e ~5 mm de cabo reto antes de curvar para a abertura.

É a ressalva real da quadrada: **ela não perdoa um rabicho de traseira longa.** Meça o
seu conector, da face de trás até o fim do crimp; se passar de ~11 mm, use a compacta.

## Cotas

| | Quadrada | Compacta | XL |
|---|---|---|---|
| Planta do corpo | 26,0 × 26,0 | 34,0 × 26,0 | 54,0 × 46,0 mm, canto R7 |
| Planta com a saia | 38,0 × 38,0 | 46,0 × 38,0 | 66,0 × 58,0 mm |
| Altura total | 24,7 | 24,7 | 34,7 mm |
| Centro da face do SMA | 19,0 | 19,0 | 29,0 mm |
| Recuo do eixo (`boss_x`) | 4,0 | 8,0 | 8,0 mm |
| Canais radiais na saia | 10 | 12 | 20 |

Comum às três:

| | |
|---|---|
| Inclinação | **45°** em relação à superfície colada |
| Face do SMA | Ø16,0 plana, perpendicular ao eixo da antena |
| Furo do SMA | Ø6,50, chanfro 0,5 na face externa |
| Rebaixo sextavado | 8,41 entre faces × 2,0 de profundidade, **voltado para dentro** |
| Parede | 2,5 mm no corpo; 3,0 mm na face do SMA |
| Saia | 6,0 mm de avanço, 2,6 → 2,0 mm de espessura, chanfro 0,6 na aresta |
| Passo dos canais radiais | ~10,5 mm — o número acompanha o perímetro |

As cotas do conector são as **mesmas medidas no flange do [Baton Node](../)**
(`wisblock_sled.scad`): mesmo SMA fêmea de painel, mesma técnica de travamento.

## Como funciona

![corte](hood_section.png)

O sextavado fica **por dentro**: o corpo do conector assenta no rebaixo e não gira
enquanto se aperta a porca do lado de fora — exatamente como no cap do cano. Sobra
**1,0 mm de furo redondo** na face externa, onde entram a arruela e a porca.

A montagem é feita **antes de colar**, com a peça na mão:

1. Furar a caixa **dentro da área da abertura** (21 × 21, 29 × 21 ou 49 × 41), com o
   próprio capuz servindo de gabarito: apoiar, contornar a parede interna a lápis,
   furar no meio da marca. **Ø5 basta** — veja a ordem de montagem abaixo.
2. Passar a **ponta IPEX** do pigtail pelo furo, de fora para dentro da caixa.
3. Enfiar o conector no capuz por baixo, encaixar o sextavado no rebaixo, e apertar
   arruela + porca por fora, **com PU sob a arruela**.
4. Colar o capuz.

> **A ordem importa.** Passando a ponta IPEX pelo furo, o furo da caixa só precisa
> deixar o **cabo** passar (Ø5). Se você tentar enfiar o conector já montado de
> dentro para fora, o furo tem que engolir o sextavado (Ø9,71 nas quinas), vira um
> Ø11 e você perde a folga que sobra para o PU vedar em volta do cabo.

> **Depois de colado, a cavidade do capuz vira parte do volume interno da caixa** —
> as duas se comunicam pelo furo do pigtail. A estanqueidade do conjunto passa a
> depender da vedação sob a arruela do SMA. Vede também em volta do cabo, no furo da
> caixa. Se a caixa tem válvula respiro PTFE, ela continua fazendo o trabalho para o
> volume somado.

## A saia

![face de colagem](hood_glue.png)

A face de colagem é uma faixa de **8,5 mm de largura** (2,5 da parede + 6,0 da saia)
contornando toda a peça, com **2 anéis** e canais radiais, todos de 0,9 × 0,9. Mesma
lógica do [WisMesh Foot](../wismesh-foot/): o PU cura dentro do sulco e trabalha como
rebite; os canais radiais deixam o excesso escapar em vez de formar bolha.

**A diferença é que aqui a junta também veda.** Por isso a faixa mais interna — os
**3,5 mm** que envolvem a abertura — é **contato contínuo**, sem nenhuma ranhura
cruzando: é a barreira de água. Todos os sulcos ficam para fora dela, e os canais
radiais correm do primeiro anel **para a borda externa**, nunca para dentro.

| | Quadrada | Compacta | XL |
|---|---|---|---|
| Face de colagem | 799 mm² | 925 mm² | 1557 mm² |
| Selo contínuo (interno) | 305 mm² (38%) | 361 mm² (39%) | 641 mm² (41%) |
| Contato total | 582 mm² — **73%** | 675 mm² — **73%** | 1144 mm² — **73%** |
| Ranhura | 217 mm² (27%) | 250 mm² (27%) | 413 mm² (27%) |
| PU alojado | ~195 mm³ | ~225 mm³ | ~372 mm³ |

Os 73% de contato são bem mais conservadores que os 39% do pezinho, de propósito:
esta junta faz três coisas ao mesmo tempo — colar, vedar e resistir ao **momento da
antena**, que numa haste a 45° é o esforço que realmente tenta descolar a peça. A
proporção é a mesma nas três versões; o número de canais radiais acompanha o
perímetro para manter o passo em ~10,5 mm, e é sempre par, para a peça não sair
assimétrica.

A saia é uma **rampa** (2,6 mm junto à parede, 2,0 na ponta) com chanfro de 0,6 na
aresta inferior externa: o chanfro vira reservatório para o cordão de PU que se passa
por fora, contornando a peça depois de assentada.

## Gerar

```sh
openscad                 -o sma_hood.stl    sma_hood.scad
openscad -D xl=true      -o sma_hood_xl.stl sma_hood.scad
openscad -D square=true  -o sma_hood_sq.stl sma_hood.scad
```

Parâmetros que valem mexer:

| | |
|---|---|
| `square` | iguala o comprimento à largura (26 × 26 de corpo) |
| `xl` | +10 de altura, +20 na planta |
| `grow_xy` / `grow_h` | os acréscimos da XL, para um tamanho intermediário |
| `boss_x` | recuo do eixo; mexer junto com a planta, veja a seção da quadrada |
| `tilt` | 45 → 30 ou 60, se quiser outra inclinação |
| `boss_d` | Ø da face plana — aumente se a base da sua antena for larga |
| `skirt_w` | avanço da saia; mais área de cola, peça mais larga |
| `show_antenna` | fantasma Ø10 × 60 para conferir a folga |

Para outro conector, medir e ajustar `sma_hole_d`, `sma_hex_af` e `sma_hex_dep`.

## Impressão

**PETG, ABS ou ASA** — fica no sol, exposto, e é PU colado. Evite PLA.

**Imprima sobre a face de colagem, sem suporte.** É a orientação certa por três
motivos: a face que precisa sair plana encosta no leito; a cavidade fecha em cúpula,
com as paredes inclinadas para dentro e nada de bridge; e o teto da cavidade, no
fundo do boss, é justamente o plano de 45°, que é o limite auto-suportado. As
ranhuras saem na primeira camada, como vãos rasos.

A parede mais deitada é a rampa de trás: **65° com a horizontal na quadrada, 52° na
compacta, 50° na XL** — quanto mais espalhada a peça, mais perto do limite dos 45°.
As três imprimem sem suporte, mas se o seu perfil tiver refrigeração fraca, olhe essa
região na primeira peça XL.

Perímetros: 3 ou mais. A parede é de 2,5 mm e o esforço aqui é de flexão na raiz do
cone — vale mais perímetro que preenchimento. 20–25% de infill.

Depois de imprimir, **passe a peça no plano** (lixa 220 sobre um vidro) antes de
colar: qualquer *elephant foot* na saia tira a peça de esquadro e a antena sai torta.
