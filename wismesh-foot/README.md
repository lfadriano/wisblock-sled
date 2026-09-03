# WisMesh Foot — pezinho avulso, colado com PU

Alternativa à [bandeja gradeada](../wismesh-grid/): em vez de parafusar uma placa
inteira, colam-se **6 pezinhos** direto na placa laranja, um por furo do conjunto
WisMesh. Permite posicionar o conjunto onde se quiser dentro da caixa.

![face de colagem](foot_base.png)

Peça: **Ø13 × 9 mm**. Os seis são idênticos — os seis pontos do WisMesh usam o mesmo
M2.5 — então o STL traz **uma unidade só**; duplique no fatiador.

## Cotas

| | |
|---|---|
| Base (colagem) | Ø13,0 × 3,0 mm, com chanfro de 0,6 na borda |
| Torre | Ø6,0 × 6,0 mm, filete de 1,2 na raiz |
| Altura total | **9,0 mm** |
| Furo | Ø2,3 (rosca direta M2.5), **cego**, 6,5 de profundidade |
| Fundo maciço | **2,5 mm** |

## O furo é cego, de propósito

Na bandeja o furo é passante. Aqui não pode ser: o pé é colado direto sobre a placa
laranja, então um furo passante deixaria o parafuso tocar (ou furar) a placa. Ficam
**2,5 mm de fundo maciço** — com M2.5 × 6 e PCB de 1,0 mm, o parafuso penetra 5,0 e
ainda sobram 1,5 mm de fundo.

## Altura escolhida para casar com a bandeja

Os 9,0 mm dão a **mesma altura livre** da solução com bandeja:

| | Bandeja | Pezinhos |
|---|---|---|
| Placa laranja | 2,5 | 2,5 |
| Bandeja | 3,0 | — |
| Torre / pé | 6,0 | 9,0 |
| **Total do fundo** | **11,5** | **11,5** |

Acima dos 8 mm que a documentação da caixa exige para os pinos de solda e para a
câmara de ar do amplificador de 1 W.

## Ranhuras de colagem

A face de colagem tem **2 anéis concêntricos** (r = 3,10 e 5,30) e **6 canais
radiais**, todos com 0,9 mm de largura e 0,9 de profundidade. Os anéis dão ancoragem
mecânica — o PU cura dentro do sulco e trabalha como rebite — e os canais radiais
deixam o excesso escapar em vez de formar bolha sob o pé.

Duas decisões medidas, não estimadas:

- **Largura de 0,9 mm.** Com 1,3 a área de contato direto caía para **25%**, pouco
  para o pé assentar plano. Com 0,9 fica em **39% de contato e 46% de ranhura**
  (~55 mm³ de PU alojado), que é o equilíbrio.
- **Os canais começam em r = 2,20**, não no centro. Partindo do centro, os seis se
  cruzariam ali e esvaziariam justamente o miolo da face — que é onde a junta cola
  mais solicitada trabalha.

## Montagem

1. Marcar na placa laranja as 6 posições do gabarito WisMesh (ver a tabela de furos
   no [README da bandeja](../wismesh-grid/#gabarito-de-furos-do-conjunto-wismesh))
2. Aplicar PU na face ranhurada e assentar cada pé
3. Curar com o conjunto **desparafusado** — usar a própria PCB como gabarito de
   alinhamento, apoiada sem aperto, evita que os pés curem fora de esquadro
4. Parafusar o WisMesh com 6 × **M2.5 × 6 mm**

## Impressão

**PETG, ABS ou ASA** — a caixa é hermética e fica no sol. Assenta plano no leito pela
face de colagem, sem suporte; as ranhuras ficam na primeira camada e imprimem como
vãos rasos. As torres saem na vertical.
