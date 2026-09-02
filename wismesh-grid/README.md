# WisMesh 1W Grid Tray — Rohdbox 110×110×60 IP68

Bandeja gradeada para montar o conjunto **WisMesh 1 Watt Booster**
(RAK19007 + RAK3400 + RAK13302) e duas células 18650 dentro de uma caixa
hermética Rohdbox de 110 × 110 × 60 mm.

![layout](grid_layout.png)

A bandeja é parafusada **sobre** a `placa_laranja_gabarito`, com parafuso passante
até os pilares da caixa, e é toda vazada — braçadeiras de nylon passam por qualquer
vão, o que dispensa pontos de amarração dedicados.

Tamanho: **88 × 88 × 9 mm** (bandeja de 3 mm + torres de 6 mm).

## Gabarito de furos do conjunto WisMesh

Este é o dado que mais custou a levantar, então fica registrado. São **6 pontos**,
com furo de **2,3 mm** para o M2.5 cortar a própria rosca no plástico:

| # | x | y | Origem |
|---|---|---|---|
| 1 | 3,81 | 4,08 | RAK19007 (placa mãe) |
| 2 | 3,81 | 26,08 | RAK19007 |
| 3 | 55,81 | 4,08 | RAK19007 |
| 4 | 57,81 | 28,08 | RAK19007 |
| 5 | **75,40** | **2,20** | extensão RAK13302 |
| 6 | **75,40** | **23,20** | extensão RAK13302 |

Duas armadilhas aqui:

- **A extensão não está alinhada com a placa mãe.** Os furos do RAK13302 ficam em
  y = 2,2 e 23,2 (span 21 mm), cerca de 1,9 mm abaixo dos y = 4,08 / 26,08 da
  RAK19007. Não é um retângulo contínuo de 6 furos.
- **O padrão da placa mãe não é simétrico**: o quarto furo é (57,81; 28,08), não
  (55,81; 26,08) como a simetria sugeriria.

Procedência: os furos 1–4 vêm do modelo oficial do RAK19007 e foram validados numa
peça já impressa e montada. Os furos 5–6 foram confirmados em **três modelos
independentes** de terceiros feitos para este mesmo conjunto (`adapter3`,
`341board`, `carlon-v6`), que concordam em x = 75,0–75,5 e span 21,0 mm.

> Atenção a uma divergência na documentação da caixa, que informa "26 mm centro a
> centro no eixo Y, recuados 2,0 mm". Furos com esse padrão existem na RAK19007,
> mas têm **Ø2,14** — são pequenos para M2.5. Os de montagem são os Ø2,70, com span
> de 22 mm. Usar 26 mm faria os parafusos não coincidirem.

## Fixação na caixa

4 furos Ø3,6 em quadrado de **64 × 64 mm**, coincidentes com os Ø3,45 da placa
laranja (que estão em 18/82 no sistema dela).

A posição da PCB foi **escolhida por busca**, não por estética: com `pcb_y = 44` o
conjunto ocupa y 44–74 e não cobre nenhum dos furos de fixação (y = 12 e 76),
deixando os quatro acessíveis com a chave. A torre mais próxima de um furo fica a
**1,8 mm** livre do reforço — sem colisão. Em posições vizinhas as torres da extensão chegavam a
2,9 mm de um furo, sobrepondo o reforço.

As células passam por cima dos furos de y = 12, então esses levam **rebaixo de
6,2 × 2,0 mm**: a cabeça do parafuso fica sob a superfície e não empurra a bateria.

## Ordem de montagem

Importa, porque a bandeja fica sob os componentes:

1. Parafusar a bandeja na placa laranja / pilares da caixa (4 × M3)
2. Parafusar o WisMesh nas 6 torres (M2.5, rosca direta)
3. Assentar o par de 18650 entre as guias e amarrar com braçadeiras pelos vãos

## Câmara de ar

A documentação da caixa exige **≥8 mm** livres sob a placa, para os pinos de solda
não tocarem o plástico e para dissipar o calor do amplificador de 1 W. Aqui:
placa laranja 2,5 + bandeja 3,0 + torre 6,0 = **11,5 mm**.

## Parâmetros

| Parâmetro | Valor | Notas |
|---|---|---|
| `grid_x` / `grid_y` | 88,0 | 1 mm de folga por lado sobre a laranja de 90 × 90 |
| `tower_h` | 6,0 | altura livre sob a PCB |
| `tower_id` | 2,30 | rosca direta M2.5 |
| `fix_span` | 64,0 | quadrado de fixação da caixa |
| `n_cell` | 8 | vãos por lado; o vão (7,43 mm) é calculado para fechar exato |
| `bar_w` | 2,4 | largura da barra da grade |
| `bat_l` / `bat_w` | 67 / 38 | faixa das duas 18650, em y 4..42 (fora da moldura) |

## Impressão

Mesma recomendação do sled: **PETG, ABS ou ASA** — a caixa é hermética e fica no
sol. Assenta plana no leito, sem suporte. As torres imprimem na vertical.
