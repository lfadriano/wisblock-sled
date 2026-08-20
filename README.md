# WisBlock Sled — cano PVC 40 mm

Berço ("sled") impresso em 3D que desliza por atrito dentro de um cano de PVC de
**40 mm externo / 34,5 mm interno**, carregando:

- uma **RAK19007 WisBlock Base** (60 × 30 mm) parafusada nos furos M2 originais;
- uma **célula 18650** em suporte com mola serpentina *print-in-place*;
- um **conector SMA fêmea** de painel num flange circular Ø34,4 mm que fecha a ponta.

Dimensões finais: **200,5 × 34,62 × 25,21 mm**.

O modelo é paramétrico em OpenSCAD e **não redesenha** as peças de terceiros: ele
importa os STLs originais e faz união/recorte sobre eles, preservando furos,
standoffs e o mecanismo da mola exatamente como projetados.

## Compilando

Os dois STLs importados são de terceiros e **não estão neste repositório**. Baixe-os
e coloque em `vendor/` com estes nomes:

| Arquivo em `vendor/` | O que é |
|---|---|
| `Wisblock_Plate_V1.1.stl` | placa de montagem WisBlock (Ethernet/POE) |
| `18650_V2.STL` | suporte de 18650 com mola impressa |

```sh
openscad -o dist/Wisblock_Sled.stl wisblock_sled.scad
```

## Impressão

**Deitado, com a face plana no leito. Não imprima em pé.** A mola do suporte
comprime ao longo do comprimento (X); deitada, as camadas ficam no plano do
movimento. Em pé, X passa a ser a direção de empilhamento e a mola delamina.

O suporte da bateria encaixa num **recorte passante** da placa, com a face inferior
no mesmo plano da base — assenta direto no leito e **não precisa de suporte**. A
mola imprime apoiada, em vez de sobre ponte.

Testado em PLA.

## Parâmetros principais

| Parâmetro | Valor | Observação |
|---|---|---|
| `fit_clear` | `-0.12` | negativo = **interferência** contra o cano. `-0.18` aperta mais |
| `wall_base` | `3.0` | **não aumentar**: reduz o vão interno e prende a PCB |
| `wall_tip` | `1.8` | ponta da asa; abaixo de 1,6 o PLA quebra na raiz |
| `fillet` | `3.0` | filete na raiz da asa — principal reforço anti-quebra |
| `disc_flat` | `true` | corta o disco em z=0 → base plana, sem suporte |
| `cable_swap` | `true` | inverte de que lado sai cada passagem de cabo |
| `tail_len` | `15.0` | prolongamento após a bateria, com furos de braçadeira |

## Decisões de projeto que não são óbvias

- **Asas por interferência, não por folga.** A v1 usava +0,20 mm de folga e ficava
  solta. Interferência de 0,25 mm com ponta de 1,4 mm quebrava na raiz ao simples
  aperto de dedo — em PLA a falha é *entre camadas*, no canto vivo. A solução foi o
  filete de 3 mm na raiz (cabe inteiro **abaixo** da PCB), ponta de 1,8 mm e
  interferência menor (0,12 mm).
- **A espessura da raiz da asa é limitada pela PCB**, não pela resistência: engrossar
  `wall_base` para 4,0 mm derrubaria o vão interno de 28,18 para 26,41 mm.
- **Os furos M2 são reabertos depois do filete**, senão ele obstrui parafuso.
- **Recorte passante em vez de degrau** para o suporte da bateria: elimina suporte de
  impressão, deixa a mola apoiada no leito e aumenta a folga ao cano para 3,37 mm.
- **Convenção de lados:** "esquerda" = y baixo, "direita" = y alto. O lado y alto é
  identificável por um furo M2 solitário a 1,70 mm da borda (y = 28,08).

## Licença

O `wisblock_sled.scad` é do autor deste repositório. Os STLs importados de `vendor/`
mantêm as licenças originais de seus autores e não são redistribuídos aqui; o STL
compilado em `dist/` é obra derivada deles.
