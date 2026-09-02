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

- **Pilares dos cantos** → os 4 cantos são recortados, deixando a peça em forma de
  cruz com 4 abas retas. Recuo de **8,1 mm** nas bordas de X e **17,1 mm** nas de Y,
  resultando em abas de 81,9 e 63,9 mm.
- **Colunas do meio de cada aba** → 4 colunas de 9,7 mm de largura que exigem
  **9,3 mm** de recuo. Um círculo de Ø9,7 com centro a 4,45 mm da borda produz
  exatamente essa profundidade e essa largura ("quase meia lua").

O contorno é construído **parametricamente a partir dos recuos**, não copiado do
`placa_laranja_gabarito.stl` — ver a divergência abaixo. Também não leva boleado por
offset: medi que qualquer par `offset()/offset()` desloca o recuo (+2,00 mm usando
`delta`, +0,46 usando `r`), e aqui a cota é o que desvia dos pilares, então ela
manda. Os recuos saem exatos em 8,10 e 17,10.

> **Os recortes das colunas engolem os 4 furos periféricos** que a placa laranja tem
> no meio de cada aba (a 3,125 mm da borda, para as travas de pressão). Eles caem
> dentro da área removida, portanto a bandeja não os reproduz.

## Divergência entre o STL do gabarito e a placa física

Vale registrar, porque custou algumas idas e voltas:

| | `placa_laranja_gabarito.stl` | Placa física (paquímetro) |
|---|---|---|
| Lado | **90,000** (exato, bbox 4,875–94,875) | **99,8** |
| Recuo das abas | 8,000 / 16,750 | **8,1 / 17,1** |
| Span dos furos centrais | 64,000 | 64 (não muda — é a caixa que manda) |
| Recorte das colunas | **ausente** | 9,3 de profundidade |

O arquivo é um **gabarito reduzido**, não a placa. Os **recuos** das abas coincidem
nos dois (8,0 vs 8,1 e 16,75 vs 17,1), e é por isso que são a medida boa. Já as
"abas de 74 e 56 mm" que apareciam na documentação em texto foram calculadas com
lado 90,2 — correto para o gabarito, errado para a placa.

Outras duas coisas medidas no STL que não se sustentam na peça física: a assimetria
de 0,125 mm no padrão de furos (artefato de modelagem — na placa é simétrico) e a
ausência do recuo das colunas.

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

| | y |
|---|---|
| Pack de baterias | 14 – 34 |
| WisMesh | 36 – 66 |
| Livre para cabos e antena | 66 – 90 |

A posição da PCB foi **escolhida por busca**, verificando em cada candidata que as
seis torres caem sobre material (não nos recortes) e que nenhuma invade o reforço de
um furo de fixação nem um recorte de coluna. Em `pcb = (9; 36)` a folga mínima é
**4,3 mm**.

### O pack fica empilhado

O pack é de duas 18650 **uma sobre a outra** (18,6 de largura × 37,2 de altura), não
lado a lado. Isso não é preferência: com as células lado a lado (38 mm) mais a PCB
(30 mm), a área entre as abas não acomoda as duas coisas sem que um furo de fixação
caia no caminho da torre da extensão. Empilhado, o consumo em Y cai para 20 mm.

As guias laterais têm **6 mm** de altura, porque um pack estreito e alto tomba fácil.

## Fixação

4 furos Ø3,6 em quadrado de **64 × 64 mm**, com recuo de 17,05 (simétrico).

Os de y = 17,05 ficam sob o pack, então levam **rebaixo de 6,2 × 2,0 mm**: a cabeça
do parafuso fica sob a superfície e não empurra a célula. Os de y = 81,05 ficam
livres acima da PCB.

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
| `rec_major` / `rec_minor` | 8,1 / 17,1 | recuo dos recortes dos cantos |
| `col_d` / `col_prof` | 9,7 / 9,3 | largura e recuo das colunas do meio das abas |
| `fix_span` | 64,0 | quadrado de fixação da caixa |
| `tower_h` | 6,0 | altura livre sob a PCB |
| `tower_id` | 2,30 | rosca direta M2.5 |
| `n_cell` | 9 | vãos por lado; o vão (7,46 mm) é calculado para fechar exato |
| `bat_w` | 20,0 | pack empilhado |
| `bat_rail` | 6,0 | altura das guias do pack |

## Impressão

Mesma recomendação do sled: **PETG, ABS ou ASA** — a caixa é hermética e fica no
sol. Assenta plana no leito, sem suporte. As torres imprimem na vertical.
