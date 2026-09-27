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
arm_d1   = 22.0;              // altura da secao na ponta (era 15: com a trelica
                              // a alma precisa de altura para ter rasgo)
gusset   = 38.0;               // misula no canto interno do L
cham     = 0.4;

// ---------------- alivio em trelica ----------------
// A alma de uma viga em balanco carrega pouca flexao: a tensao e' maxima
// nas fibras extremas e ZERO na linha neutra. Tirar material do meio custa
// quase nada. Medido, com a chapa 230x185 a 40 m/s:
//     macico ....... 0,65 MPa        trelica ...... 0,89 MPa
//     cisalhamento   0,049 MPa            ->        0,14 MPa
// contra ~25 MPa do ASA a 60 C: fator 28 de folga.
//
// NAO e' pelo vento. A silhueta do suporte inteiro da 6 N a 40 m/s, entao
// vazar metade economiza 3 N contra os 50 N da chapa — e ele ainda fica na
// esteira dela. E' por estetica, material e tempo.
//
// Os rasgos atravessam a espessura, que e' a direcao de construcao: saem
// como furos verticais na impressao, sem ponte e sem suporte.
truss    = true;
tr_y0    = 150.0;   // a RAIZ fica macica (momento maximo) e o rasgo comeca
tr_y1    = 228.0;   // DEPOIS do primeiro inserto, nunca em cima dele
tr_n     = 3;       // vaos
tr_fl    = 5.0;     // banzo superior e inferior
tr_diag  = 6.0;     // largura das diagonais
tr_r     = 3.0;     // raio dos cantos: canto vivo e' iniciador de trinca
// vao TRASEIRO, entre a raiz e o primeiro inserto. Fica onde o momento e'
// maior, entao foi conferido: a 40 m/s da 0,88 MPa contra ~25 do ASA quente.
// Para em y=129 para deixar 5 mm de material antes do inserto (que ocupa
// de ~134 a ~141 em y, contando a inclinacao de 15 graus e os 9 de furo).
tr_tras  = true;
tr_ty0   = 112.0;
tr_ty1   = 129.0;
// A misula NAO leva rasgo: o raio inscrito do triangulo e' 10,9 mm, entao
// qualquer recuo util a colapsa — e ela e' justamente quem reforca o canto.

// ---------------- fixacao da chapa ----------------
ins_s    = [45.0, 150.0];      // posicao ao longo da RAMPA, da aresta de tras
ins_d    = 5.60;               // furo do inserto M4 8x6 — CONFERIR no cupom
ins_h    = 9.00;
ins_ch   = 0.60;

// ---------------- fixacao na tampa ----------------
// Porca M4 aprisionada: o parafuso vem de DENTRO da caixa, sobe pelo furo
// Ø7,5 da tampa e rosca na porca. Inserto nao serve — a parede que sobraria
// em volta dele num furo de 7,5 nao aguenta a prensagem.
// Cotas NOMINAIS da porca (DIN 934) e a folga, separadas — antes estavam
// somadas e nao dava para ver quanta folga havia. Eram 7,20 e 3,40, ou seja
// 0,20 em cada cota, e isso NAO passa em FDM: rasgo pequeno imprime 0,1 a 0,2
// subdimensionado, entao a folga real cairia para zero ou negativa.
nut_af_n = 7.00;               // entre faces, norma
nut_t_n  = 3.20;               // espessura, norma
nut_fol  = 0.45;               // folga entre faces
nut_folt = 0.35;               // folga na espessura
nut_af   = nut_af_n + nut_fol; // 7,45
nut_t    = nut_t_n  + nut_folt;// 3,55
// Entre VERTICES. E' esta a cota que manda na profundidade da bolsa: as faces
// da porca apoiam nas paredes de 7,2 em z, entao o que aponta para o fundo
// (-x) e' um vertice, nao uma face.
nut_e    = nut_af_n*2/sqrt(3) + nut_fol;
// Teto que sobra depois do chanfro. A bolsa e' aberta na face +x, que e' a que
// deita no leito: o fundo dela aponta para o TOPO da impressao. Teto plano de
// 3,4 mm sai em ponte e barriga -- com a ventoinha em zero, que o ASA exige,
// nao ha' como resfriar. O chanfro a 45 graus fecha ate' sobrar nut_cap, que a
// parede atravessa sem cair.
nut_cap  = 1.40;

print_ready = true;
$fn = 48;

// =====================================================================
T = tan(ang);
function ztop(y) = -(y - lid_y) * T;
function zbot(y) = ztop(y) - (arm_d0 + (arm_d1-arm_d0)*(y-lid_y-leg_t)/(arm_len-leg_t));

echo(str("suporte ",wid," de largura | perna z ",leg_z0," a ",leg_z1));
echo(str("braco vai de y=",lid_y+leg_t," a y=",lid_y+arm_len));
echo(str("secao na raiz ",arm_d0," x ",wid," -> modulo ",wid*arm_d0*arm_d0/6," mm3"));
echo(str("tensao na raiz a 40 m/s (1,89 N.m): ",1890/(wid*arm_d0*arm_d0/6)," MPa  (raiz fica MACICA)"));
if(truss) for(i=[0:tr_n-1]) echo(str("  vao ",i+1,": y ",bay(i)[0]," a ",bay(i)[1]));
// CONFERENCIA: um rasgo em cima de um inserto arruina a peca
if(truss) for(sv=ins_s) let(yi = lid_y + sv*cos(ang), y0i = yi-2.9-9*sin(ang), y1i = yi+2.9)
    echo(str("  inserto ocupa y ",y0i," a ",y1i,": ",
        ((y1i>tr_y0-2 && y0i<tr_y1+2) || (tr_tras && y1i>tr_ty0-2 && y0i<tr_ty1+2))
        ? "*** COLIDE COM RASGO ***" : "livre, ok"));
if(truss && tr_tras) echo(str("  vao traseiro: y ",tr_ty0," a ",tr_ty1));
// CONFERENCIA: o chanfro do teto da bolsa come material no topo da impressao
echo(str("  porca: bolsa ",nut_af," x ",nut_t," para porca ",nut_af_n," x ",nut_t_n,
    "  -> folga ",nut_fol," / ",nut_folt));
echo(str("  bolsa: fundo x=",-nut_e/2,", apice x=",
    -nut_e/2-(nut_t-nut_cap)/2,", sobra ",
    wid/2-nut_e/2-(nut_t-nut_cap)/2," mm de material acima",
    (wid/2-nut_e/2-(nut_t-nut_cap)/2 < 2.0) ? "  *** TETO FINO ***" : ""));
for(s=ins_s) echo(str("  inserto a ",s," da aresta -> (y ",lid_y+s*cos(ang),", z ",-s*sin(ang),")"));

// perfis no plano YZ, extrudados ao longo de X
PERNA  = [[lid_y,leg_z0],[lid_y+leg_t,leg_z0],[lid_y+leg_t,leg_z1],[lid_y,leg_z1]];
BRACO  = concat([ for(i=[0:24]) let(y=lid_y+leg_t+(arm_len-leg_t)*i/24) [y, ztop(y)] ],
                [ for(i=[24:-1:0]) let(y=lid_y+leg_t+(arm_len-leg_t)*i/24) [y, zbot(y)] ]);
MISULA = [[lid_y+leg_t, zbot(lid_y+leg_t)],
          [lid_y+leg_t+gusset, zbot(lid_y+leg_t+gusset)],
          [lid_y+leg_t, zbot(lid_y+leg_t)-gusset*0.9]];

// a espessura fica CENTRADA em x=0 — os furos sao cotados a partir do eixo
// linhas da alma, ja' descontados os banzos
function wt(y) = ztop(y) - tr_fl;
function wb(y) = zbot(y) + tr_fl;
function bay(i) = [tr_y0 + i*(tr_y1-tr_y0)/tr_n, tr_y0 + (i+1)*(tr_y1-tr_y0)/tr_n];
function tri_em(ya, yb, cima) = let(a=ya+tr_diag/2, c=yb-tr_diag/2, m=(ya+yb)/2)
    cima ? [[a, wb(a)], [c, wb(c)], [m, wt(m)]]
         : [[a, wt(a)], [c, wt(c)], [m, wb(m)]];
function tri(i) = tri_em(bay(i)[0], bay(i)[1], i%2==1);

module extrudaYZ(P, w)
    translate([-w/2,0,0]) rotate([0,90,0]) linear_extrude(w)
        polygon([ for(p=P) [-p[1], p[0]] ]);

// Teardrop: circulo com apice a r*raiz(2), flancos a 45 graus, auto-suportado.
// Vale SO' para os furos de passagem. Os dos insertos ficam redondos ate' o
// cupom dizer quanto a ponte fecha — mudar a forma agora invalidaria a medicao,
// e o teardrop tira justamente o plastico que o serrilhado do inserto precisa.
module teardrop2d(d){
    hull(){ circle(d=d); translate([-d/2*sqrt(2), 0]) circle(r=0.01); }
}

module furo_tampa(z0){
    // apice para -x, que e' o TOPO na orientacao de impressao
    translate([0, lid_y-1, z0]) rotate([-90,0,0])
        linear_extrude(leg_t+2) teardrop2d(lid_d);
    // bolsa da porca, aberta na face +X
    y0 = lid_y+leg_t-nut_t-2.0;
    x0 = -nut_e/2;                      // fundo: cabe o VERTICE da porca
                                        // (nut_e JA inclui a folga — somar
                                        //  nut_fol de novo afinava o teto)
    ch = (nut_t - nut_cap)/2;           // chanfro a 45: recuo = altura
    translate([x0, y0, z0-nut_af/2])
        cube([wid/2 - x0 + 0.2, nut_t, nut_af]);
    // teto a 45 graus sobre o fundo da bolsa
    translate([x0, y0, z0-nut_af/2]) hull(){
        cube([0.01, nut_t, nut_af]);
        translate([-ch, ch, 0]) cube([0.01, nut_cap, nut_af]);
    }
}

module furo_inserto(s){
    y = lid_y + s*cos(ang);  z = -s*sin(ang);
    translate([0, y, z]) rotate([ang,0,0]){
        translate([0,0,-ins_h]) cylinder(h=ins_h+0.01, d=ins_d);
        translate([0,0,-ins_ch]) cylinder(h=ins_ch+0.01, d1=ins_d, d2=ins_d+2*ins_ch);
    }
}

// rasgo arredondado, extrudado por toda a espessura
module rasgo(P)
    translate([-wid/2-1,0,0]) rotate([0,90,0]) linear_extrude(wid+2)
        offset(r=tr_r) offset(delta=-tr_r)
            polygon([ for(p=P) [-p[1], p[0]] ]);

module peca() difference(){
    union(){
        extrudaYZ(PERNA,  wid);
        extrudaYZ(BRACO,  wid);
        extrudaYZ(MISULA, wid);
    }
    for(z=lid_z) furo_tampa(z);
    for(s=ins_s) furo_inserto(s);
    if(truss){
        for(i=[0:tr_n-1]) rasgo(tri(i));
        if(tr_tras) rasgo(tri_em(tr_ty0, tr_ty1, true));
    }
}

// print_ready: deita de lado, o perfil do L no plano do leito. Com bico a
// 240 C a adesao entre camadas cai; assim a flexao trabalha DENTRO da camada.
// o rotate em Z deixa o maior lado em X (150 x 117), que cabe nos 200 x 148 da CP2
if(print_ready) rotate([0,0,90]) translate([0,0,wid/2]) rotate([0,90,0])
                    translate([0,-lid_y-arm_len/2,0]) peca();
else peca();
