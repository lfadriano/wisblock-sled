// =====================================================================
//  SMA Hood — capuz de antena a 45 graus, colado com PU
//
//  Cobre um furo feito na parede externa da caixa hermetica e leva o
//  conector SMA femea de painel para uma face inclinada a 45 graus. O
//  pigtail sobe de dentro da caixa, atravessa o furo e e' rosqueado na
//  parede superior do capuz; a antena fica a 45 graus, sem cotovelo e
//  sem adaptador.
//
//  A peca e' TODA FECHADA: unica abertura e' o furo do SMA na face
//  inclinada. Embaixo e' vazada (a cavidade fica sobre o furo da caixa)
//  e as laterais nao tem furo nenhum — nada de parafuso, a fixacao e'
//  so' de cola PU pela saia.
//
//  Referencia de forma: babyape-ii-vtx-sma-mount (holder de VTX de FPV),
//  sem os dois olhais de M3.
//
//  ATENCAO: depois de colado, a cavidade do capuz passa a fazer parte do
//  volume interno da caixa (elas se comunicam pelo furo do pigtail). A
//  estanqueidade do conjunto passa a depender da vedacao sob a arruela
//  do SMA — mesma tecnica do cap do Baton Node: PU sob a arruela.
// =====================================================================

// ---------------- variantes ----------------
// Tres versoes da MESMA peca, saindo deste mesmo arquivo:
//
//   (nada)          compacta,   46 x 38 x 24,7 mm com a saia
//   -D xl=true      XL,         66 x 58 x 34,7 mm
//   -D square=true  quadrada,   38 x 38 x 24,7 mm
//
// A XL existe por um motivo de montagem: com a abertura de 49 x 41 e mais
// 10 mm de pe direito, o dedo entra por baixo e segura o corpo do conector
// enquanto se aperta a porca do lado de fora. Na compacta (29 x 21) da' para
// enfiar so' a ponta do dedo.
//
// A quadrada iguala o comprimento a' LARGURA (o menor dos dois), nao ao
// comprimento: 26 x 26 de corpo em vez de 34 x 26. Fica a menor das tres na
// caixa. O que ela cobra esta' anotado em boss_x, logo abaixo.
xl          = false;
square      = false;
grow_xy     = xl ? 20.0 : 0.0;   // acrescimo na planta, nos dois sentidos
grow_h      = xl ? 10.0 : 0.0;   // acrescimo na altura

// ---------------- conector (cotas medidas, as mesmas do wisblock_sled) --
sma_hole_d  = 6.50;   // furo da rosca
sma_hex_af  = 8.41;   // sextavado do conector, ENTRE FACES
sma_hex_dep = 2.00;   // profundidade do rebaixo sextavado (fica por DENTRO)
sma_cham    = 0.50;   // chanfro de entrada, na face de fora
face_t      = 3.00;   // espessura da parede no furo do SMA

// ---------------- inclinacao e boss ----------------
tilt        = 45;     // graus em relacao a' superficie colada
boss_d      = 16.0;   // Dia da face plana onde a arruela e a porca assentam
boss_len    = 8.0;    // comprimento do cilindro do boss, ao longo do eixo
top_h       = 19.0 + grow_h;  // altura do CENTRO da face do SMA acima da caixa
// Deslocamento do eixo no sentido em que a antena aponta. Na quadrada o eixo
// RECUA os mesmos 4 mm que a borda da frente recuou (17 -> 13), de modo que a
// parede da frente sai identica a' da retangular: 14 graus com a vertical.
// Nao da' para simplesmente centrar o boss na quadrada. Centrado (boss_x = 0),
// a folga atras do conector, medida no eixo, cai para 7,9 mm — menos que a
// traseira de um SMA de painel com o rabicho. Com 4,0 ficam 12,7 mm.
boss_x      = square ? 4.0 : 8.0;

// ---------------- corpo ----------------
wall        = 2.5;
base_w      = 26.0 + grow_xy;
base_l      = square ? base_w : 34.0 + grow_xy;  // no sentido da inclinacao (X)
base_r      = 7.0;    // raio de canto da planta
base_h      = 3.0;    // trecho reto (vertical) na base, antes da rampa

// ---------------- saia de colagem ----------------
skirt_w     = 6.0;    // quanto a saia avanca alem da parede
skirt_t     = 2.6;    // espessura junto a' parede
skirt_e     = 2.0;    // espessura na ponta (a saia e' uma rampa)
skirt_ch    = 0.6;    // chanfro na aresta inferior externa

// ---------------- profundidade traseira ----------------
// A parede de TRAS (a oposta a' ponta da antena) avanca back_gain para dentro
// da footprint da saia, e a saia encurta exatamente o mesmo tanto naquele lado.
// O contorno externo da peca nao muda — o que se ganha de cavidade sai da saia,
// nao da base. A face da frente fica fixa.
//
// So' a quadrada precisa: nas outras a base ja' e' longa atras do boss e a
// folga no eixo passa dos 50 mm. Na quadrada ela vai de 12,7 para 19,6 mm.
//
// O padrao na quadrada e' o deslocamento CHEIO (back_gain = skirt_w): a parede
// para exatamente onde a saia terminava, e a face posterior fica sem saia. Nao
// e' de graca — a faixa colada de tras cai de 8,5 para 2,5 mm (so' o anel da
// parede, sem ranhura), e a traseira e' justamente o lado que o peso da antena
// tenta descolar. Vale porque a conta e' folgada: uma antena de 30 g com o
// centro de massa a ~40 mm da a' faixa de tras algo como 6 kPa de tracao,
// contra 1-2 MPa que o PU aguenta. Quem quiser a faixa de volta usa 3,0 ou 4,0
// e perde 3 mm de cavidade.
back_gain   = square ? skirt_w : 0.0;
back_skirt  = skirt_w - back_gain;   // saia que resta na face posterior
x_front     = base_l/2;              // borda da frente, FIXA
x_back      = base_l/2 + back_gain;  // borda de tras do corpo
assert(back_gain >= 0 && back_gain <= skirt_w, "back_gain tem que ficar entre 0 e skirt_w");

// A parede posterior sobe VERTICAL (90 graus com a base) ate' back_wall_h, e do
// alto dela o teto sai reto para o boss. Sem isso a rampa comeca na propria
// aresta da base e come' a parte de cima da cavidade.
//
// Duas alturas fazem sentido, e a diferenca entre elas e' precisar de suporte:
//
//  back_h_45  = altura em que o teto sai a 45 graus, PARALELO ao eixo da antena.
//               45 graus e' o limite auto-suportado, entao imprime sem suporte.
//  back_h_top = sobe ate' o PONTO MAIS ALTO DO CONECTOR (o topo do boss). O teto
//               vira uma face PLANA na mesma altura, a parede termina em 90 graus
//               e a peca NAO fica mais alta — o boss ja' estava nessa cota. E' o
//               maximo de cavidade que cabe no mesmo envelope, e cobra um vao
//               horizontal no teto: precisa de suporte.
//
// O suporte aqui e' removivel sem drama, porque a peca e' vazada embaixo: ele
// entra e sai pela propria abertura de colagem.
back_h_45   = top_h + (boss_d/2 - (x_back + boss_x)*sin(tilt))/cos(tilt);
back_h_top  = top_h + (boss_d/2)*sin(tilt);
back_wall_h = square ? back_h_top : 0;   // 0 = rampa desde a aresta da base
// Espessura do bloco que gera a parede em pe'. Tem que ser MAIOR que wall com
// folga: o gerador da cavidade e' o mesmo bloco erodido de wall em todas as
// direcoes, inclusive na face da frente. Com 3,0 o bloco erodido saia vazio (ou,
// se a erosao da frente fosse esquecida, o canto de cima da cavidade encostava na
// lateral inclinada do corpo e a parede caia para 1,4 mm). Com 2*wall + 3 sobram
// 3 mm de bloco erodido e a parede fica nos 2,5 em todo o teto. Acima de 8 o
// ganho de cavidade ja' e' de 2% e so' engorda a peca.
back_slab   = 2*wall + 3.0;

// ---------------- ranhuras para o PU ----------------
// Mesma logica do WisMesh Foot: o PU cura dentro do sulco e trabalha como
// rebite; os canais radiais deixam o excesso escapar em vez de formar bolha.
// A diferenca aqui e' que a junta tambem VEDA: por isso a faixa mais interna
// fica continua, sem nenhuma ranhura cruzando-a.
seal_band   = 1.00;   // offset onde comeca o primeiro anel; tudo para dentro
                      // disso e' contato continuo (a barreira de agua)
groove_w    = 0.90;
groove_d    = 0.90;
ring_gap    = 1.10;   // contato entre os dois aneis
// Canais radiais, do 1o anel para a borda. O numero acompanha o perimetro
// para manter o passo em ~10,5 mm em qualquer variante (e par, para a peca
// nao ficar assimetrica): 12 na compacta, 20 na XL, 10 na quadrada.
rad_pitch   = 10.5;
rad_peri    = 2*((x_front+x_back-2*base_r)+(base_w-2*base_r)) + 2*PI*(base_r+3);
rad_n       = 2*round(rad_peri/(2*rad_pitch));
rad_w       = 0.90;
// Balanco da face de colagem (925 mm2 no total): 73% de contato direto e 27% de
// ranhura (~225 mm3 de PU alojado) — bem mais conservador que os 39/46 do pezinho,
// porque esta junta cola, VEDA e ainda segura o momento da antena.

// ---------------- visualizacao ----------------
show_antenna = false;  // fantasma da antena, so' para conferir a folga
ant_d        = 10.0;
ant_l        = 60.0;

$fn = 96;

// =====================================================================

sma_hex_cc = sma_hex_af/cos(30);   // Dia circunscrito do sextavado
inner_l    = x_front + x_back - 2*wall;
inner_w    = base_w - 2*wall;
top_max    = top_h + (boss_d/2)*sin(tilt);
band_w     = wall + skirt_w;       // largura total da face de colagem

echo(str("capuz ",xl?"XL":(square?"quadrado":"compacto"),": planta ",base_l," x ",base_w," + saia -> ",
         base_l+2*skirt_w," x ",base_w+2*skirt_w," mm"));
echo(str("altura total ",top_max," mm; centro da face do SMA a ",top_h," mm"));
echo(str("face do SMA: Dia ",boss_d,", parede ",face_t," -> hex de ",sma_hex_dep,
         " por dentro + ",face_t-sma_hex_dep," mm de furo redondo"));
echo(str("sextavado: entre faces ",sma_hex_af,"  circunscrito ",sma_hex_cc));
echo(str("area interna (onde furar a caixa): ",inner_l," x ",inner_w," mm"));
if(back_gain > 0)
    echo(str("parede de tras avancada ",back_gain," mm; saia posterior ",back_skirt,
             " -> faixa colada de ",wall+back_skirt," mm naquele lado"));
if(back_wall_h > 0)
    echo(str("parede posterior em pe' ate' ",back_wall_h," mm (90 graus com a base)",
             back_wall_h >= back_h_top-0.01 ? " = topo do boss: teto PLANO, pede suporte"
                                           : str("; teto a 45 graus se <= ",back_h_45)));
echo(str("canais radiais: ",rad_n," (passo de ",rad_peri/rad_n," mm)"));
echo(str("face de colagem: faixa de ",band_w," mm na frente e nas laterais",
         back_gain>0 ? str(", ",wall+back_skirt," mm atras") : "",
         "; contato continuo de ",wall+seal_band," mm antes do 1o anel"));

// Planta da PAREDE do corpo, dilatada/erodida de o. Assimetrica em X: a borda
// de tras esta' em -x_back e a da frente em +x_front.
module outline(o=0)
    offset(r=o) offset(r=base_r)
        translate([(x_front-x_back)/2, 0])
            square([x_front+x_back-2*base_r, base_w-2*base_r], center=true);

// Planta do ENVELOPE (borda externa da saia). Nao depende de back_gain: o que a
// parede de tras avanca, a saia encurta, e o contorno externo fica o mesmo.
module env(o=0)
    offset(r=o) offset(r=base_r)
        square([base_l-2*base_r, base_w-2*base_r], center=true);

// referencial do SMA: origem no CENTRO DA FACE, +Z saindo pela antena
module on_axis(){ translate([boss_x,0,top_h]) rotate([0,90-tilt,0]) children(); }

// a fatia de tras da planta, gerador da parede em pe'
module back_region(o=0)
    intersection(){
        outline(o);
        translate([-x_back+o-1, -base_w]) square([back_slab+1, 2*base_w]);
    }

module body(){
    hull(){
        // o chanfro da base fica dentro da saia enquanto ela existir; no
        // deslocamento cheio ele e' a aresta externa da face posterior
        linear_extrude(skirt_ch) outline(-skirt_ch);
        translate([0,0,skirt_ch]) linear_extrude(base_h-skirt_ch) outline(0);
        if(back_wall_h > base_h)
            translate([0,0,skirt_ch]) linear_extrude(back_wall_h-skirt_ch) back_region(0);
        on_axis() translate([0,0,-boss_len]) cylinder(h=boss_len, d=boss_d);
    }
}

// cavidade: os mesmos geradores erodidos de wall, e aberta para baixo
module cavity(){
    hull(){
        translate([0,0,-1]) linear_extrude(base_h-wall+1) outline(-wall);
        if(back_wall_h > base_h)
            translate([0,0,-1]) linear_extrude(back_wall_h-wall+1) back_region(-wall);
        on_axis() translate([0,0,-boss_len]) cylinder(h=boss_len-face_t, d=boss_d-2*wall);
    }
}

module skirt(){
    hull(){
        linear_extrude(skirt_t) outline(0);
        translate([0,0,skirt_ch]) linear_extrude(skirt_e-skirt_ch) env(skirt_w);
        linear_extrude(skirt_ch) env(skirt_w-skirt_ch);
    }
}

module sma_cuts(){
    on_axis(){
        // furo passante da rosca
        translate([0,0,-face_t-12]) cylinder(h=face_t+12.01, d=sma_hole_d);
        // chanfro de entrada, na face de fora
        translate([0,0,-sma_cham]) cylinder(h=sma_cham+0.01, d1=sma_hole_d, d2=sma_hole_d+2*sma_cham);
        // rebaixo sextavado, aberto para DENTRO: trava o corpo do conector
        // enquanto se aperta a porca do lado de fora
        translate([0,0,-face_t-12]) cylinder(h=12+sma_hex_dep, d=sma_hex_cc, $fn=6);
    }
}

// faixa 2D entre dois offsets da planta
module band(a,b) difference(){ outline(b); outline(a); }

module glue_grooves(){
    r1 = seal_band;                       // 1o anel
    r2 = seal_band + groove_w + ring_gap; // 2o anel
    translate([0,0,-0.01]) linear_extrude(groove_d+0.01){
        band(r1, r1+groove_w);
        band(r2, r2+groove_w);
        // canais radiais: do 1o anel para fora, atravessando a borda
        intersection(){
            band(r1, skirt_w+1);
            union(){
                for(i=[0:rad_n-1])
                    rotate([0,0,i*360/rad_n])
                        translate([-rad_w/2,0]) square([rad_w, base_l]);
            }
        }
    }
}

module sma_hood(){
    difference(){
        union(){ body(); skirt(); }
        cavity();
        sma_cuts();
        glue_grooves();
    }
}

sma_hood();

if(show_antenna)
    %on_axis() cylinder(h=ant_l, d=ant_d);
