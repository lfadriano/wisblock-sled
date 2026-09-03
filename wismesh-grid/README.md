# WisMesh 1W Grid Tray — Rohdbox 110×110×60 IP68

Bandeja gradeada para montar o conjunto **WisMesh 1 Watt Booster**
(RAK19007 + RAK3400 + RAK13302) e um pack de duas 18650 dentro de uma caixa
hermética Rohdbox de 110 × 110 × 60 mm.

![layout](grid_layout.png)

A bandeja é parafusada **sobre** a placa laranja, com parafuso passante até os
pilares da caixa, e é toda vazada — braçadeiras de nylon passam por qualquer vão, o
que dispensa pontos de amarração dedicados.

Tamanho: **98,1 × 98,1 × 9 mm** (bandeja de 3 mm + torres de 6 mm).

## Contorno

O contorno **não é um quadrado**. A caixa tem estruturas que vão do fundo até a
tampa, e a placa precisa desviar de duas famílias delas:

- **Pilares dos cantos** → os 4 cantos são recortados, deixando 4 abas retas. Recuo
  de **13,20 mm** em Y e **22,25 mm** em X, com o canto do recorte em **meia lua
  R7** (não em ângulo reto). Isso reproduz as abas medidas: 73,4 e 55,3 na placa.
- **Colunas do meio de cada aba** → 4 colunas de 9,4 mm de largura, com **8,3 mm**
  de profundidade. O slot termina **reto (90°) na borda** e é boleado só no fundo.

O contorno é construído **parametricamente a partir dos recuos**, não copiado do
`placa_laranja_gabarito.stl` — ver a divergência abaixo.

Os recuos vieram das **abas medidas no paquímetro** (73,4 e 55,3 num lado de 99,8),
que são auto-consistentes: (99,8 − 73,4)/2 = 13,20 e (99,8 − 55,3)/2 = 22,25.
Conferido no mesh, as abas saem exatas em **71,70** e **53,60** (a bandeja é 1,7 mm
menor que a placa).

> **Os recortes das colunas engolem os 4 furos periféricos** que a placa laranja tem
> no meio de cada aba (a 3,125 mm da borda, para as travas de pressão). Eles caem
> dentro da área removida, portanto a bandeja não os reproduz.

## Divergência entre o STL do gabarito e a placa física

Vale registrar, porque custou algumas idas e voltas:

| | `placa_laranja_gabarito.stl` | Placa física (paquímetro) |
|---|---|---|
| Lado | **90,000** (exato, bbox 4,875–94,875) | **99,8** |
| Recuo das abas | 8,000 / 16,750 | **13,20 / 22,25** |
| Canto do recorte | ângulo reto | **meia lua R7** |
| Span dos furos centrais | 64,000 | **59,60** |
| Recorte das colunas | **ausente** | 8,0 de profundidade |

O arquivo **não representa a placa**: além do lado, divergem os recuos, o span dos
furos, o formato do canto e a existência dos recortes das colunas. Tudo o que a
bandeja usa hoje vem de medição no paquímetro.

Uma nota sobre as três medidas do span dos furos: a distância direta entre eles dá
59,6, a diagonal de 83,4 implica 58,97 e o recuo de 19,7 implica 60,4 — 1,43 mm de
espalhamento. Usei a **medida direta**, por ser a mais confiável das três.

## Gabarito de furos do conjunto WisMesh

São **6 pontos**, com furo de **2,3 mm** para o M2.5 cortar a própria rosca:

| # | x | y | Origem |
|---|---|---|---|
| 1 | 3,81 | 4,08 | RAK19007 (placa mãe) |
| 2 | 3,81 | 26,08 | RAK19007 |
| 3 | 55,81 | 4,08 | RAK19007 |
| 4 | 57,81 | 28,08 | RAK19007 |
| 5 | **75,40** | **2,20** | extensão RAK13302 |
| 6 | **75,40** | **23,20** | extensão RAK13302 |

Duas armadilhas:

- **A extensão não está alinhada com a placa mãe.** Os furos do RAK13302 ficam em
  y = 2,2 e 23,2 (span 21 mm), ~1,9 mm abaixo dos y = 4,08 / 26,08 da RAK19007.
- **O padrão da placa mãe não é simétrico**: o quarto furo é (57,81; 28,08), não
  (55,81; 26,08).

Procedência: os furos 1–4 vêm do modelo oficial do RAK19007 e foram validados numa
peça impressa e montada. Os 5–6 foram confirmados em **três modelos independentes**
de terceiros para este mesmo conjunto (`adapter3`, `341board`, `carlon-v6`), que
concordam em x = 75,0–75,5 e span 21,0.

## Layout

A PCB fica **em pé** (`pcb_rot = 90`), ao longo de Y:

| | x | y |
|---|---|---|
| Pack de baterias | 8 – 28 | 14 – 81 |
| WisMesh | 33 – 63 | 9 – 90 |
| Livre para cabos e antena | 63 – 98 | — |

Rodar 90° não é só arranjo: o pack passa a encostar na **aba maior** (71,7 nas bordas
de X, contra 53,6 nas de Y) e a PCB usa a direção em que a peça tem 98,1 mm livres.
A folga mínima entre uma torre e um furo ou recorte sobe de **4,3 para 12,4 mm**.

A posição foi **escolhida por busca**, verificando em cada candidata que as seis
torres caem sobre material (não nos recortes) e que nenhuma invade o reforço de um
furo de fixação nem um slot de coluna.

Para voltar ao arranjo deitado basta `pcb_rot = 0` — os furos e as guias do pack
acompanham.

### O pack fica empilhado

O pack é de duas 18650 **uma sobre a outra** (18,6 de largura × 37,2 de altura), não
lado a lado. Isso não é preferência: com as células lado a lado (38 mm) mais a PCB
(30 mm), a área entre as abas não acomoda as duas coisas sem que um furo de fixação
caia no caminho da torre da extensão. Empilhado, o consumo em Y cai para 20 mm.

As guias laterais têm **6 mm** de altura, porque um pack estreito e alto tomba fácil.

## Fixação

4 furos Ø3,6 em quadrado de **59,6 × 59,6 mm**, com recuo de 19,25 (simétrico).

Os dois de x = 19,25 ficam sob o pack, então levam **rebaixo de 6,2 × 2,0 mm**: a cabeça
do parafuso fica sob a superfície e não empurra a célula. Os de x = 78,85 ficam livres.

## Ordem de montagem

Importa, porque a bandeja fica sob os componentes:

1. Parafusar a bandeja na placa laranja / pilares da caixa (4 × M3)
2. Parafusar o WisMesh nas 6 torres (M2.5, rosca direta)
3. Assentar o pack entre as guias e amarrar com braçadeiras pelos vãos

## Câmara de ar

A documentação da caixa exige **≥8 mm** livres sob a placa, para os pinos de solda
não tocarem o plástico e para dissipar o calor do amplificador de 1 W. Aqui:
placa laranja 2,5 + bandeja 3,0 + torre 6,0 = **11,5 mm**.

## Parâmetros

| Parâmetro | Valor | Notas |
|---|---|---|
| `plate_side` | 99,8 | lado da placa física, medido no paquímetro |
| `grid_gap` | 0,85 | folga da bandeja em relação à placa, por lado |
| `rec_major` / `rec_minor` | 13,20 / 22,25 | recuo dos recortes dos cantos |
| `corner_r` | 7,0 | meia lua do canto do recorte |
| `col_slack` | 1,0 | alargamento do slot sobre a medida da coluna |
| `col_d` / `col_prof` | 10,4 / 8,0 | slot: reto na borda, fundo em semicírculo R5,2 |
| `fix_span` | 59,6 | quadrado de fixação da caixa |
| `tower_h` | 6,0 | altura livre sob a PCB |
| `tower_id` | 2,30 | rosca direta M2.5 |
| `n_cell` | 9 | vãos por lado; o vão (7,46 mm) é calculado para fechar exato |
| `pcb_rot` | 90 | 0 = PCB deitada em X, 90 = em pé em Y |
| `bat_w` | 20,0 | pack empilhado |
| `bat_rail` | 6,0 | altura das guias do pack |

## Impressão

Mesma recomendação do sled: **PETG, ABS ou ASA** — a caixa é hermética e fica no
sol. Assenta plana no leito, sem suporte. As torres imprimem na vertical.
