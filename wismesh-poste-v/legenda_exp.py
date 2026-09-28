#!/usr/bin/env python3
# Recorta o render de explodido.scad e cola a legenda da ferragem embaixo.
#   openscad -o /tmp/exp.png explodido.scad --imgsize=2600,1950 --projection=p \
#            --camera=1120,-1450,820,0,200,-35 --colorscheme=Tomorrow
#   python3 legenda_exp.py /tmp/exp.png   ->  p_exp.png
import sys
from PIL import Image, ImageDraw, ImageFont
S = sys.argv[1] if len(sys.argv) > 1 else '/tmp/exp.png'
im = Image.open(S).convert('RGB'); bg = im.getpixel((2,2)); px = im.load(); W,H = im.size
d0 = lambda p: abs(p[0]-bg[0])+abs(p[1]-bg[1])+abs(p[2]-bg[2])
xs=[];ys=[]
for y in range(0,H,2):
    for x in range(0,W,2):
        if d0(px[x,y])>12: xs.append(x); ys.append(y)
m=26
im = im.crop((max(0,min(xs)-m), max(0,min(ys)-m), min(W,max(xs)+m), min(H,max(ys)+m)))
cw,ch = im.size; print('figura', im.size)

LEG = [
 ("1", "4 x  M5 x 35 inox A2   +  2 arruelas grandes Ø15  +  porca nyloc M5",
       "fecha as duas metades do berço pelas orelhas.  Cabeça no bolsão atrás da placa, porca por fora"),
 ("2", "1 x  M5 x 55 inox A2   +  2 arruelas grandes Ø15  +  porca nyloc M5",
       "passante: atravessa o berço E o poste furado.  Não segura peso — cuida de rotação e arranque"),
 ("3", "4 x  M4 x 20 inox A2   +  2 arruelas Ø9  +  porca nyloc M4",
       "caixa → placa do berço, no gabarito 93 x 74 do fundo.  Cabeça DENTRO da caixa"),
 ("4", "4 x  M4 x 16 inox A2   +  arruela grande Ø12 (DIN 9021)",
       "de dentro da caixa, sobe pelo furo Ø7,5 da tampa e rosca na porca aprisionada (5)"),
 ("5", "4 x  porca M4 DIN 934  (sextavada comum, 7,0 x 3,2)",
       "aprisionada na bolsa lateral do suporte em L.  Entra ANTES de parafusar — depois não entra mais"),
 ("6", "4 x  inserto de latão M4 8 x 6",
       "assentado a quente na face da rampa do suporte em L.  Furo Ø5,60 — confirmar no cupom"),
 ("7", "4 x  M4 x 12 inox A2   +  arruela Ø9  +  trava química",
       "chapa de alumínio → insertos (6).  Nyloc não serve aqui: a rosca é cega"),
]
F  = "/System/Library/Fonts/Supplemental/Arial.ttf"
FB = "/System/Library/Fonts/Supplemental/Arial Bold.ttf"
fn = ImageFont.truetype(FB, 32); ft = ImageFont.truetype(FB, 22)
fs = ImageFont.truetype(F, 21);  fh = ImageFont.truetype(FB, 24)
lh = 58; pad = 30
legh = 52 + len(LEG)*lh + 18
Wf = max(cw, 1240); Hf = ch + legh
out = Image.new('RGB',(Wf,Hf),(250,250,249))
out.paste(im, ((Wf-cw)//2, 0))
d = ImageDraw.Draw(out)
y = ch + 6
d.line([pad, y, Wf-pad, y], fill=(205,208,211), width=2)
h1 = "FERRAGEM — tudo em inox A2"
d.text((pad, y+14), h1, font=fh, fill=(30,34,38))
d.text((pad + d.textlength(h1, font=fh) + 24, y+18),
       "aço carbono conduziria 3x mais calor para dentro da caixa", font=fs, fill=(105,110,116))
for i,(n,t,s) in enumerate(LEG):
    yy = y + 56 + i*lh
    d.text((pad+2, yy-4), n, font=fn, fill=(193,18,31))
    d.text((pad+42, yy),    t, font=ft, fill=(30,34,38))
    d.text((pad+42, yy+27), s, font=fs, fill=(105,110,116))
out.save('p_exp.png'); print('ok', out.size)
