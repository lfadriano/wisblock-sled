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
//  IMPRESSAO: vire de cabeca para baixo (print_ready ja' faz isso) — o
//  teto do alojamento vai para o leito, o furo do poste abre para cima e
//  nao ha' ponte nenhuma. Com bico a 240 C isso importa.
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
body_z0  = -106.0;   // o corpo vai de -106 ate' 0
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
spine_w  = 44.0;     // espinha que liga a placa ao corpo
spine_y0 =  1.0;

// ---------------- orelhas de aperto ----------------
ear_x    = [[10,40],[-40,-10]];
ear_t    = 12.0;
ear_h    = 16.0;
ear_z    = [-32.0, -82.0];
ear_d    = 5.50;     // M5
ear_bx   = 28.0;

// ---------------- passante no poste ----------------
thru_d   = 5.20;
thru_z   = -60.0;

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
echo(str("placa ",plate_w," x ",-plate_z0," x ",plate_t,"  -> material alem do furo: ",plate_w/2-box_x/2-box_d/2," mm"));
echo(str("apoio do rebordo do tubo: ",3.1416/4*(pole_d*pole_d-(pole_d-2*1.7)*(pole_d-2*1.7))," mm2"));

module meio_espaco()  // mantem so' o lado desta metade
    translate([-200, s>0 ? y0 : -200-y0, -300]) cube([400, 200, 400]);

module corpo(){
    intersection(){
        union(){
            // casca com teto
            translate([0,0,body_z0]) difference(){
                cylinder(h=-body_z0, d=body_d);
                translate([0,0,-1]) cylinder(h=-body_z0-cap_t+1, d=bore_d);
                // chanfro de entrada do tubo
                translate([0,0,-0.01]) cylinder(h=2.5, d1=bore_d+3, d2=bore_d);
            }
            // orelhas
            for(z=ear_z, xr=ear_x)
                translate([xr[0], s>0 ? y0 : -y0-ear_t, z])
                    cube([xr[1]-xr[0], ear_t, ear_h]);
            // espinha + placa, so' na metade 0
            if(half==0){
                translate([-spine_w/2, spine_y0, plate_z0])
                    cube([spine_w, plate_y0-spine_y0+0.01, -plate_z0]);
                translate([-plate_w/2, plate_y0, plate_z0])
                    cube([plate_w, plate_t, -plate_z0]);
            }
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

// print_ready: vira de cabeca para baixo -> o teto do alojamento vai para o
// leito, o furo do poste abre para cima, nenhuma ponte.
if(print_ready) rotate([180,0,0]) peca(); else peca();
