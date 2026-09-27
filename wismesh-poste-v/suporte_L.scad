// =====================================================================
//  Suporte em L  —  leva a chapa solar da tampa da caixa ate' os 15 graus
//  WisMesh no poste · Manaus
//
//  Sao DOIS, parafusados nos furos de canto da TAMPA (90 x 90, passantes,
//  livres da vedacao: quem fecha a caixa e' a trava lateral em clipe).
//
//  Referencial (montado). A caixa fica EM PE ao lado do topo do poste:
//    z = 0   -> face superior da caixa, onde entra o bulkhead SMA
//    y = 94  -> plano da tampa (face frontal, voltada ao norte)
//
//  A aresta de tras da chapa fica em (y=94, z=0): encostada no canto
//  superior da parede e NO NIVEL da base do conector. Nenhum metal acima
//  do ponto de alimentacao — e' isso que separa plano de terra de
//  refletor assimetrico. Medido: encostada, a parede frontal absorve
//  2,12 W no pico; com um vao de 16 mm sobe para 2,39.
//
//  A chamine nao se perde com a chapa encostada: o ar corre entre a face
//  de cima (z=0) e o chapeu (z=+15), e a chapa fica ABAIXO desse canal,
//  descendo — a saida vira um bocal divergente.
//
//  IMPRESSAO: DEITADO DE LADO, o perfil do L no plano do leito.
//  Com o bico limitado a 240 C a adesao entre camadas cai; nesta
//  orientacao a flexao do braco trabalha DENTRO da camada e o canto
//  interno do L fica inteiro numa camada so'.
//
//    openscad -o suporte_L.stl suporte_L.scad
// =====================================================================

// ---------------- geometria de referencia ----------------
ang      = 15.0;               // caimento da chapa
lid_y    = 94.0;               // plano da tampa
lid_z    = [-10.0, -100.0];    // furos da tampa: 90 mm entre eixos
lid_d    = 4.50;               // passagem folgada de M4

// ---------------- corpo ----------------
// Reforcado: largura 12 -> 15, secao da raiz 25 -> 34, e misula no canto.
wid      = 15.0;
leg_t    = 14.0;               // espessura da perna contra a tampa
leg_z0   = -110.0;             // a perna desce ate' a base da caixa
leg_z1   =    7.0;
arm_len  = 150.0;              // alcance a partir do plano da tampa
arm_d0   = 34.0;               // altura da secao na raiz
arm_d1   = 15.0;               // altura da secao na ponta
gusset   = 38.0;               // misula no canto interno do L
cham     = 0.4;

// ---------------- fixacao da chapa ----------------
ins_s    = [45.0, 150.0];      // posicao ao longo da RAMPA, da aresta de tras
ins_d    = 5.60;               // furo do inserto M4 8x6 — CONFERIR no cupom
ins_h    = 9.00;
ins_ch   = 0.60;

// ---------------- fixacao na tampa ----------------
// Porca M4 aprisionada: o parafuso vem de DENTRO da caixa, sobe pelo furo
// Ø7,5 da tampa e rosca na porca. Inserto nao serve — a parede que sobraria
// em volta dele num furo de 7,5 nao aguenta a prensagem.
nut_af   = 7.20;
nut_t    = 3.40;

print_ready = true;
$fn = 48;

// =====================================================================
T = tan(ang);
function ztop(y) = -(y - lid_y) * T;
function zbot(y) = ztop(y) - (arm_d0 + (arm_d1-arm_d0)*(y-lid_y-leg_t)/(arm_len-leg_t));

echo(str("suporte ",wid," de largura | perna z ",leg_z0," a ",leg_z1));
echo(str("braco vai de y=",lid_y+leg_t," a y=",lid_y+arm_len));
echo(str("secao na raiz ",arm_d0," x ",wid," -> modulo ",wid*arm_d0*arm_d0/6," mm3"));
echo(str("tensao a 40 m/s (1,85 N.m por suporte): ",1850/(wid*arm_d0*arm_d0/6)," MPa"));
for(s=ins_s) echo(str("  inserto a ",s," da aresta -> (y ",lid_y+s*cos(ang),", z ",-s*sin(ang),")"));

// perfis no plano YZ, extrudados ao longo de X
PERNA  = [[lid_y,leg_z0],[lid_y+leg_t,leg_z0],[lid_y+leg_t,leg_z1],[lid_y,leg_z1]];
BRACO  = concat([ for(i=[0:24]) let(y=lid_y+leg_t+(arm_len-leg_t)*i/24) [y, ztop(y)] ],
                [ for(i=[24:-1:0]) let(y=lid_y+leg_t+(arm_len-leg_t)*i/24) [y, zbot(y)] ]);
MISULA = [[lid_y+leg_t, zbot(lid_y+leg_t)],
          [lid_y+leg_t+gusset, zbot(lid_y+leg_t+gusset)],
          [lid_y+leg_t, zbot(lid_y+leg_t)-gusset*0.9]];

// a espessura fica CENTRADA em x=0 — os furos sao cotados a partir do eixo
module extrudaYZ(P, w)
    translate([-w/2,0,0]) rotate([0,90,0]) linear_extrude(w)
        polygon([ for(p=P) [-p[1], p[0]] ]);

module furo_tampa(z0){
    translate([0, lid_y-1, z0]) rotate([-90,0,0]) cylinder(h=leg_t+2, d=lid_d);
    // bolsa da porca, aberta na face +X
    translate([-nut_af/2, lid_y+leg_t-nut_t-2.0, z0-nut_af/2])
        cube([wid/2+nut_af/2+0.2, nut_t, nut_af]);
}

module furo_inserto(s){
    y = lid_y + s*cos(ang);  z = -s*sin(ang);
    translate([0, y, z]) rotate([ang,0,0]){
        translate([0,0,-ins_h]) cylinder(h=ins_h+0.01, d=ins_d);
        translate([0,0,-ins_ch]) cylinder(h=ins_ch+0.01, d1=ins_d, d2=ins_d+2*ins_ch);
    }
}

module peca() difference(){
    union(){
        extrudaYZ(PERNA,  wid);
        extrudaYZ(BRACO,  wid);
        extrudaYZ(MISULA, wid);
    }
    for(z=lid_z) furo_tampa(z);
    for(s=ins_s) furo_inserto(s);
}

// print_ready: deita de lado, o perfil do L no plano do leito. Com bico a
// 240 C a adesao entre camadas cai; assim a flexao trabalha DENTRO da camada.
// o rotate em Z deixa o maior lado em X (150 x 117), que cabe nos 200 x 148 da CP2
if(print_ready) rotate([0,0,90]) translate([0,0,wid/2]) rotate([0,90,0])
                    translate([0,-lid_y-arm_len/2,0]) peca();
else peca();
