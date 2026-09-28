// =====================================================================
//  Berco de face vertical  —  WisMesh no poste · Manaus
//
//  Aperta os 106 mm finais de um tubo Ø31,7 x 1,7 e apresenta uma face
//  VERTICAL com o gabarito do fundo da caixa Rohdbox (93 x 74).
//  A caixa fica EM PE ao lado do topo do poste, com a face superior no
//  nivel da boca do tubo — e' de la' que a antena sai, sem poste ao lado.
//
//  O alojamento do poste e' CEGO: o tubo entra por baixo e o rebordo
//  ENCOSTA no teto. Tres ganhos de uma vez:
//    - 6 m de tubo em pe deixam de ser calha de chuva
//    - o conjunto APOIA em vez de depender de atrito: 160 mm2 de coroa,
//      0,09 MPa com o peso montado, nao flui nem a 60 C
//    - na montagem a altura sai sozinha, basta enfiar ate' bater
//
//  DUAS METADES DIFERENTES: half=0 leva a placa, half=1 e' a contra-peca.
//
//  O passante M5 fica NO PLANO DE PARTICAO, meia canaleta em cada metade.
//  Ele nao segura peso (quem segura e' o batente); cuida de rotacao e de
//  arranque — a 40 m/s a chapa inclinada gera ~45 N de sustentacao contra
//  15 N de peso, entao sobram 30 N puxando para cima.
//
//  IMPRESSAO: DEITADO sobre a face de particao (print_ready ja' faz isso).
//  Nesta orientacao:
//    - as ORELHAS de aperto assentam no leito. Em pe elas ficariam em
//      balanco, blocos de 12 mm com nada embaixo
//    - a altura cai de 110 para 33 mm: nada de peca alta e estreita
//    - a placa de fixacao fica DEITADA, entao a flexao dela (peso da caixa
//      e vento na chapa) trabalha DENTRO da camada, nao atravessando-a —
//      o que importa com o bico limitado a 240 C
//    - o alojamento do poste vira um ARCO auto-sustentado, que fecha
//      progressivamente. Espere um pouco de barriga na chave do arco; nao
//      atrapalha, porque quem aperta e' o parafuso e sobram 2 mm de folga
//      entre as metades. Se ficar raspando, e' lixa
//
//    openscad -D half=0 -o berco_placa.stl   berco_vertical.scad
//    openscad -D half=1 -o berco_contra.stl  berco_vertical.scad
// =====================================================================

half     = 0;        // 0 = metade com a placa | 1 = contra-peca
print_ready = true;

// ---------------- poste ----------------
pole_d   = 31.70;    // MEDIDO
pole_fit = 0.20;
wall     = 6.00;
// O corpo desce ate' o MESMO nivel da placa. Antes ele parava em -106 enquanto
// a espinha e a placa iam a -110, e como o furo do poste e' cortado atraves
// delas, a metade com placa ficava com 104 mm de canal contra 100 da outra —
// meia-lua visivelmente mais curta numa das duas.
body_z0  = -110.0;   // = plate_z0
cap_t    = 6.00;     // teto do alojamento: tampa a boca do tubo

// ---------------- particao ----------------
gap      = 2.00;

// ---------------- placa de fixacao da caixa ----------------
box_x    = 93.0;     // gabarito do FUNDO da caixa (cota gravada na peca)
box_z    = 74.0;
box_d    = 4.50;
plate_w  = 116.0;    // 116 deixa 9,25 mm de material alem do furo
plate_y0 = 24.0;
plate_t  = 10.0;
plate_z0 = -110.0;
plate_r  =    5.0;   // raio dos cantos da placa
spine_w  = 44.0;     // espinha que liga a placa ao corpo
spine_y0 =  1.0;

// ---------------- orelhas de aperto ----------------
// [RAIZ, PONTA] — nesta ordem, sempre. A raiz e' o valor de menor |x|, e e' nela
// que o alargamento entra. Antes a lista era [[10,40],[-40,-10]], com a raiz no
// segundo valor da orelha de -x: ela alargava na PONTA, ficava de fora do corpo
// e as duas saiam assimetricas.
ear_x    = [[10,40],[-10,-40]];
ear_t    = 12.0;
ear_h    = 16.0;     // altura na ponta livre
// A orelha e' o ponto mais solicitado da peca: o aperto do M5 a flexiona com a
// alavanca de ~7 mm, e nesta orientacao a carga ATRAVESSA camada. Alargar so' a
// RAIZ, onde o momento e' maximo, leva Z de 384 para 576 mm3 — 34% menos tensao —
// sem mexer na ponta nem no furo. O contorno cai no plano da camada, entao
// arredondar e alargar nao custam suporte nem ponte.
ear_fl   = 12.0;     // meia-altura na raiz (24 no total)
ear_flen = 12.0;     // COMPRIMENTO do alargamento a partir da raiz (era uma
                     // posicao absoluta em x, que nao espelhava)
ear_r    =  4.0;     // raio dos cantos
ear_z    = [-32.0, -82.0];
ear_d    = 5.50;     // M5
ear_bx   = 28.0;

// ---------------- passante no poste ----------------
thru_d   = 5.20;
thru_z   = -49.0;    // -49 e nao -60: com a raiz alargada a orelha de baixo
                     // passou a ocupar z -86..-62, e o furo antigo encostava nela

$fn = 96;

// =====================================================================
bore_d = pole_d + pole_fit;
body_d = bore_d + 2*wall;
br     = body_d/2;
y0     = gap/2;
s      = (half==0) ? 1 : -1;    // lado que esta metade ocupa

echo(str("furo do poste Ø",bore_d,"  corpo Ø",body_d,"  pega ",-body_z0," mm"));
echo(str("teto do alojamento em z=",body_z0+ -body_z0-cap_t == 0 ? 0 : -cap_t,"  (cap de ",cap_t," mm)"));
echo(str("gabarito da caixa ",box_x," x ",box_z," -> furos em (+-",box_x/2,", ",-55+box_z/2," e ",-55-box_z/2,")"));
echo(str("canal do poste: de ",body_z0," a ",-cap_t," = ",-body_z0-cap_t," mm nas DUAS metades"));
echo(str("placa ",plate_w," x ",-plate_z0," x ",plate_t," cantos R",plate_r,"  -> material alem do furo: ",plate_w/2-box_x/2-box_d/2," mm"));
echo(str("orelha: ponta ",ear_h," -> raiz ",2*ear_fl,", cantos R",ear_r,
    "  | modulo na raiz ",2*ear_fl*ear_t*ear_t/6," mm3 (era ",ear_h*ear_t*ear_t/6,")"));
echo(str("passante em z=",thru_z,"; orelha de baixo vai de ",ear_z[1]+ear_h/2-ear_fl," a ",ear_z[1]+ear_h/2+ear_fl,
    " -> ",(thru_z+2.6 < ear_z[1]+ear_h/2+ear_fl) ? "*** ENCOSTA NA ORELHA ***" : "livre"));
echo(str("apoio do rebordo do tubo: ",3.1416/4*(pole_d*pole_d-(pole_d-2*1.7)*(pole_d-2*1.7))," mm2"));

// perfil da orelha no plano XZ (que e' o plano da CAMADA na impressao):
// alargada na raiz, reta na ponta, cantos arredondados.
module orelha2d(xr, xf){
    d  = (xf > xr) ? 1 : -1;      // direcao da raiz para a ponta
    xm = xr + d*ear_flen;         // onde o alargamento termina
    offset(r=ear_r) offset(delta=-ear_r)
        polygon([[xr, ear_fl], [xm, ear_h/2], [xf, ear_h/2],
                 [xf, -ear_h/2], [xm, -ear_h/2], [xr, -ear_fl]]);
}

module orelha(x0, x1, z0, lado)
    translate([0, lado>0 ? y0 : -y0-ear_t, z0+ear_h/2]) rotate([-90,0,0])
        linear_extrude(ear_t) rotate([0,0,0]) orelha2d(x0, x1);

// retangulo de cantos arredondados, exato: hull de 4 circulos.
// (nao uso par de offset() — ele desloca a cota, medi +2,00 mm com delta)
module rrect(w, h, r)
    hull() for(sx=[-1,1], sy=[-1,1])
        translate([sx*(w/2-r), sy*(h/2-r)]) circle(r=r);

// placa de fixacao da caixa, com os cantos em R5
module placa()
    translate([0, plate_y0, 0]) rotate([-90,0,0]) linear_extrude(plate_t)
        translate([0, -plate_z0/2]) rrect(plate_w, -plate_z0, plate_r);

module meio_espaco()  // mantem so' o lado desta metade
    translate([-200, s>0 ? y0 : -200-y0, -300]) cube([400, 200, 400]);

module corpo(){
    intersection(){
        // ORDEM IMPORTA: soma corpo + orelhas + espinha + placa e SO' ENTAO
        // corta o furo do poste. Cortando antes, a espinha (que vai de y=1 a
        // y=24, e o furo so' alcanca y=15,95) reentupia a meia-lua desta
        // metade e o tubo nao entrava.
        difference(){
            union(){
                translate([0,0,body_z0]) cylinder(h=-body_z0, d=body_d);
                for(z=ear_z, xr=ear_x) orelha(xr[0], xr[1], z, s);
                if(half==0){
                    translate([-spine_w/2, spine_y0, plate_z0])
                        cube([spine_w, plate_y0-spine_y0+0.01, -plate_z0]);
                    placa();
                }
            }
            // Alojamento CEGO do poste: teto em z = -cap_t.
            // O corte comeca em plate_z0, e nao em body_z0: a espinha e a
            // placa descem 4 mm ALEM do corpo, e cortando so' a partir do
            // corpo sobravam 3 mm entupindo a boca do alojamento.
            translate([0,0,plate_z0-1]) cylinder(h=-plate_z0-cap_t+1, d=bore_d);
            // chanfro de entrada, na boca de baixo
            translate([0,0,plate_z0-0.01]) cylinder(h=2.5, d1=bore_d+3, d2=bore_d);
        }
        meio_espaco();
    }
}

module peca() difference(){
    corpo();
    // furos das orelhas
    for(z=ear_z, bx=[-ear_bx, ear_bx])
        translate([bx, s>0 ? y0-1 : -y0-ear_t-1, z+ear_h/2]) rotate([-90,0,0])
            cylinder(h=ear_t+2, d=ear_d);
    // passante, meia canaleta no plano de particao
    translate([-br-2, 0, thru_z]) rotate([0,90,0]) cylinder(h=2*br+4, d=thru_d);
    // gabarito da caixa, na placa
    if(half==0)
        for(x=[-box_x/2, box_x/2], z=[-55+box_z/2, -55-box_z/2])
            translate([x, plate_y0-1, z]) rotate([-90,0,0])
                cylinder(h=plate_t+2, d=box_d);
}

// print_ready: deita sobre a face de particao. Rotacao oposta em cada
// metade, porque elas ocupam lados opostos do plano.
if(print_ready) translate([0,0,-y0]) rotate([(half==0) ? 90 : -90, 0, 0]) peca();
else peca();
