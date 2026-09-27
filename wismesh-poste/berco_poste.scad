// =====================================================================
//  Berco do poste  —  WisMesh no poste, Manaus
//
//  Aperta o topo de um tubo de ferro Ø31,7 x 1,7 e apresenta uma
//  PRATELEIRA com o gabarito do fundo da caixa Rohdbox (93 x 74).
//
//  A caixa fica CENTRADA SOBRE o poste, nao pendurada ao lado. Isso so'
//  e' possivel porque a antena vai na tampa da caixa e o poste nao
//  precisa continuar para cima. O ganho e' grande: o balanco de 76 mm
//  some, e com ele o momento de 4,5 N.m que a prateleira teria que
//  aguentar em ASA quente. Sobra carga axial e um momento pequeno.
//
//  A prateleira ainda TAMPA a boca do tubo, que num poste de 6 m em pe
//  e' entrada de agua garantida.
//
//  DUAS METADES IDENTICAS: imprima este arquivo duas vezes.
//
//  Modelado JA NA POSICAO DE IMPRESSAO (prateleira no leito, corpo
//  subindo). Montado, fica de cabeca para baixo: o poste entra por cima
//  neste desenho, por baixo na realidade.
//
//    openscad -o berco_poste.stl berco_poste.scad
// =====================================================================

// ---------------- poste ----------------
pole_d   = 31.70;  // MEDIDO. Parede de 1,7 (nao entra na conta, o aperto
                   // e' leve: quem segura de verdade e' o passante)
pole_fit = 0.20;
wall     = 6.00;
body_h   = 100.0;  // 3x o diametro do poste: pega de sobra

// ---------------- particao ----------------
gap      = 2.00;   // folga entre as duas metades, para o aperto fechar

// ---------------- prateleira ----------------
// Gabarito do FUNDO da caixa: 93 (X) x 74 (Y) entre eixos, retangulo.
// Cota gravada na propria peca pelo fabricante e conferida por foto:
// razao medida 1,2588 contra 93/74 = 1,2568, e as duas escalas batendo
// a 0,16% - prova de que as duas cotas descrevem o MESMO retangulo.
box_x    = 93.0;
box_y    = 74.0;
box_d    = 4.50;   // passagem folgada de M4 (furo da caixa mede ~4,3)
shelf_x  = 112.0;  // 112 e nao 104: deixa 7,2 mm de material alem do furo
shelf_y  = 52.0;   // por metade -> 104 montado
shelf_t  = 10.0;
shelf_r  = 8.0;

// ---------------- orelhas de aperto ----------------
ear_x0   = 10.0;   // comeca DENTRO do corpo, para soldar bem nele
ear_x1   = 38.0;
ear_t    = 12.0;   // espessura, medida a partir do plano de particao
ear_h    = 16.0;
ear_z    = [28.0, 76.0];
ear_bolt = 5.50;   // M5
ear_bx   = 28.0;   // posicao do furo em X

// ---------------- passante no poste ----------------
// Aperto de plastico RELAXA no calor. Atrito sozinho um dia cede e o
// conjunto desce ou gira. Furar o tubo (parede de 1,7, furo facil) e
// cravar um M5 transforma isso em cisalhamento no aco.
thru_d   = 5.20;
thru_z   = 60.0;

$fn = 96;

// =====================================================================
bore_d = pole_d + pole_fit;
body_d = bore_d + 2*wall;
body_r = body_d/2;
y0     = gap/2;

echo(str("furo do poste Ø",bore_d,"  corpo Ø",body_d,"  pega ",body_h," mm"));
echo(str("prateleira ",shelf_x," x ",shelf_y," x ",shelf_t," por metade (",shelf_x," x ",2*shelf_y," montado)"));
echo(str("gabarito da caixa ",box_x," x ",box_y," -> furos em (+-",box_x/2,", ",box_y/2,")"));
echo(str("material entre o furo da caixa e a borda da prateleira: ",shelf_x/2 - box_x/2 - box_d/2," mm"));
echo(str("altura total da metade: ",shelf_t + body_h));

module shelf2d()
    offset(r=shelf_r) offset(delta=-shelf_r)
        translate([-shelf_x/2, y0]) square([shelf_x, shelf_y]);

module metade(){
    union(){
        // prateleira, no leito
        linear_extrude(shelf_t) shelf2d();
        // corpo: meia casca acima dela
        translate([0,0,shelf_t]) intersection(){
            difference(){
                cylinder(h=body_h, d=body_d);
                translate([0,0,-1]) cylinder(h=body_h+2, d=bore_d);
                // chanfro de entrada do poste, no topo
                translate([0,0,body_h-2.5]) cylinder(h=2.6, d1=bore_d, d2=bore_d+3);
            }
            translate([-body_d, y0, -1]) cube([2*body_d, 2*body_d, body_h+2]);
        }
        // orelhas
        for(z = ear_z) translate([0,0,shelf_t]) intersection(){
            union(){
                translate([ ear_x0, y0, z]) cube([ear_x1-ear_x0, ear_t, ear_h]);
                translate([-ear_x1, y0, z]) cube([ear_x1-ear_x0, ear_t, ear_h]);
            }
            translate([-body_d, y0, -1]) cube([2*body_d, 2*body_d, body_h+2]);
        }
    }
}

difference(){
    metade();
    // furos do gabarito da caixa, na prateleira
    for(x = [-box_x/2, box_x/2]) translate([x, box_y/2, -1])
        cylinder(h = shelf_t + 2, d = box_d);
    // furos das orelhas
    for(z = ear_z, x = [-ear_bx, ear_bx])
        translate([x, -1, shelf_t + z + ear_h/2]) rotate([-90,0,0])
            cylinder(h = ear_t + 2, d = ear_bolt);
    // passante no poste
    translate([0, -1, shelf_t + thru_z]) rotate([-90,0,0])
        cylinder(h = body_d + 2, d = thru_d);
}
