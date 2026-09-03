// =====================================================================
//  PU Rail — trilho espacador 80 x 20 x 15, colado com PU
//
//  Fica ENTRE a caixa hermetica e uma chapa de aluminio:
//    face de baixo (z=0) -> colada na caixa com PU, leito de 1,5 mm
//    face de cima        -> parafusada na chapa, M4 em insert de latao
//
//  O principio que manda no desenho: NADA da fixacao pode aparecer na
//  face de cola. O furo do insert e' CEGO, entra pelo topo e para 4,5 mm
//  acima do piso do leito — a face de cola sai inteira e plana.
//
//  E' tambem por isso que aqui nao cabe rebite, que seria o obvio para
//  chapa de aluminio: rebite de repuxo tem que formar o bulbo do OUTRO
//  lado da pilha, e o outro lado e' a junta colada. Fora que ele aperta a
//  pilha inteira, e a pilha inclui 15 mm de plastico que flui no calor.
//
//  Diferente do capuz do SMA, esta junta NAO veda nada — a caixa ja' e'
//  hermetica e o trilho e' colado por fora. Por isso a borda pode ser
//  cortada pelos canais: aqui interessa so' ancoragem, nao vedacao.
//
//  A peca fica apoiada em z=0 pela face de cola, que e' tambem a posicao
//  de impressao.
//
//    openscad -o pu_rail.stl                   pu_rail.scad
//    openscad -o insert_coupon.stl -D coupon=true pu_rail.scad
// =====================================================================

// ---------------- corpo ----------------
rail_l      = 80.0;   // so' o comprimento foi imposto (cabe em 80)
rail_w      = 20.0;
rail_h      = 15.0;   // e' o VAO entre a caixa e a chapa: mexa aqui se
                      // precisar de outro afastamento
cham_b      = 0.40;   // chanfro na aresta inferior externa. So' 0,4: com 2 mm
                      // de borda, um chanfro maior comeria 30% da area de
                      // assentamento. Mata o pe de elefante e vira
                      // reservatorio do cordao de PU externo
cham_t      = 0.50;   // chanfro no topo, so' para tirar a aresta viva

// ---------------- fixacao: insert de latao M4 ----------------
// Insert medido no paquimetro: OD 6,00 (modelo "M4 8*6").
//
// O furo NAO vai nos 6,00. Esse e' o diametro MAIOR, sobre as cristas do
// serrilhado; o furo tem que ficar entre a crista e o fundo do serrilhado,
// para o plastico derretido ter para onde ir e o serrilhado morder. Para um
// OD de 6,0 isso cai em 5,5 a 5,7 conforme o fabricante — uso 5,60.
//
// Esta e' a cota que mais varia entre marcas neste arquivo: imprima o cupom
// (coupon=true) antes de imprimir os trilhos. Furo apertado demais nao deixa
// o insert afundar e estufa a parede; largo demais nao tem material para
// preencher o serrilhado e o insert gira quando voce aperta o parafuso.
fix_x       = [-25, 25];   // 50 mm entre eles, 15 mm sobrando em cada ponta
ins_d       = 5.60;
ins_h       = 8.00;   // dos quatro comprimentos comuns (4/5/6/8 x 6), o de 8.
                      // Nao e' por carga: ate' o de 4 mm tem ~400x de margem
                      // sobre a tracao de vento. E' por resistir a GIRAR no
                      // aperto, que e' o modo de falha real do insert termico
ins_relief  = 1.00;   // alivio abaixo: recebe o material deslocado no
                      // assentamento e perdoa a ponta do parafuso
ins_cham    = 0.60;   // chanfro de entrada, para o insert descer no eixo

// ---------------- face de cola ----------------
border      = 2.00;   // borda macica em volta: e' ela que CALIBRA a linha de
                      // cola. O trilho assenta nela e o PU fica com 1,5 mm
                      // parelho, que e' a espessura que adesivo de PU quer —
                      // ele e' preenchedor, e essa folga absorve a diferenca
                      // de dilatacao entre o trilho e a caixa
bed_d       = 1.50;

// ---------------- canais de ancoragem ----------------
// RABO DE ANDORINHA, e nao ranhura reta. O ponto: uma ranhura com a mesma
// profundidade do leito e' coplanar com ele — nao ancora nada, so' fura a
// borda. Estes canais descem MAIS 2 mm abaixo do piso do leito e alargam
// enquanto descem, de 3,0 na boca para 4,8 no fundo. O PU curado dentro vira
// um rebite que nao sai puxando reto: para escapar teria que se espremer de
// 4,8 para 3,0.
//
// O alargamento e' de 24 graus com a vertical (66 com a horizontal), bem
// dentro do auto-suportado — imprime sem suporte, de cabeca para baixo.
//
// Eles atravessam ate' as duas laterais de proposito, por tres motivos: a
// borda precisa ser furada para o excesso sair, o ar preso dentro do canal
// precisa de saida (senao vira bolha, e bolha e' onde a junta comeca a
// descolar), e da' para conferir pelo lado de fora se o PU encheu.
chan_mouth  = 3.00;
chan_root   = 4.80;
chan_z      = 2.00;   // quanto desce ALEM do piso do leito
chan_x      = [-33, -22, -11, 0, 11, 22, 33];
// Os de +-33 sao os que mais importam: descolamento de junta longa comeca
// sempre pelas pontas, e ali eles ficam a 5 mm da borda do leito.

// ---------------- cupom de teste do furo ----------------
coupon      = false;
cup_d       = [5.40, 5.50, 5.60, 5.70, 5.80];
cup_pitch   = 12.0;

$fn = 64;

// =====================================================================

bed_l    = rail_l - 2*border;
bed_w    = rail_w - 2*border;
ins_bore = ins_h + ins_relief;
under    = rail_h - bed_d - ins_bore;          // macico sob o furo do insert
web      = rail_h - ins_bore - bed_d - chan_z; // entre o furo e o fundo do canal

echo(str("trilho ",rail_l," x ",rail_w," x ",rail_h," mm"));
echo(str("leito ",bed_l," x ",bed_w," x ",bed_d));
echo(str("furo do insert Dia ",ins_d," x ",ins_bore," CEGO -> ",under," mm de fundo macico"));
echo(str("canais: ",len(chan_x)," de ",chan_mouth,"->",chan_root," descendo ",chan_z,
         " abaixo do leito (fundo a ",bed_d+chan_z," da face de cola)"));
echo(str("material entre o furo do insert e o fundo do canal: ",web," mm"));
echo(str("parafuso M4 x 10 (chapa 1,5 + arruela 1,0 + ",ins_h-2.5," de rosca)"));
echo(str("NUNCA passe de M4 x ",1.5+ins_bore," — o parafuso encosta no fundo e",
         " empurra o insert por baixo"));

// caixa com chanfro embaixo e no topo
module body(){
    hull(){
        linear_extrude(0.01) square([rail_l-2*cham_b, rail_w-2*cham_b], center=true);
        translate([0,0,cham_b])
            linear_extrude(rail_h-cham_b-cham_t) square([rail_l, rail_w], center=true);
        translate([0,0,rail_h-0.01])
            linear_extrude(0.01) square([rail_l-2*cham_t, rail_w-2*cham_t], center=true);
    }
}

// leito do PU + canais rabo de andorinha, na face de baixo
module bed_cuts(){
    translate([0,0,-0.01])
        linear_extrude(bed_d+0.01) square([bed_l, bed_w], center=true);
    for(x = chan_x) translate([x,0,0]) rotate([90,0,0])
        translate([0,0,-(rail_w+2)/2]) linear_extrude(rail_w+2)
            polygon([[-chan_mouth/2, -0.01],
                     [ chan_mouth/2, -0.01],
                     [ chan_mouth/2,  bed_d],
                     [ chan_root/2,   bed_d+chan_z],
                     [-chan_root/2,   bed_d+chan_z],
                     [-chan_mouth/2,  bed_d]]);
}

// furo cego do insert, pelo topo
module insert_cuts(){
    for(x = fix_x) translate([x,0,rail_h]){
        translate([0,0,-ins_bore]) cylinder(h=ins_bore+0.01, d=ins_d);
        translate([0,0,-ins_cham]) cylinder(h=ins_cham+0.01, d1=ins_d, d2=ins_d+2*ins_cham);
    }
}

module rail(){
    difference(){
        body();
        bed_cuts();
        insert_cuts();
    }
}

// Barrinha com um furo de cada diametro, para escolher o do seu insert.
// Cada furo leva de 1 a 5 tracinhos ao lado; o de 1 traco e' o menor.
module insert_coupon(){
    n = len(cup_d);
    c_l = n*cup_pitch; c_w = 16; c_h = ins_bore + 3;
    difference(){
        translate([-c_l/2, -c_w/2, 0]) cube([c_l, c_w, c_h]);
        for(i = [0:n-1])
            translate([-c_l/2 + cup_pitch*(i+0.5), 2.0, c_h]){
                translate([0,0,-ins_bore]) cylinder(h=ins_bore+0.01, d=cup_d[i]);
                translate([0,0,-ins_cham])
                    cylinder(h=ins_cham+0.01, d1=cup_d[i], d2=cup_d[i]+2*ins_cham);
            }
        for(i = [0:n-1], k = [0:i])
            translate([-c_l/2 + cup_pitch*(i+0.5) - 2.5 + k*1.2, -6.0, c_h-0.6])
                cube([0.6, 3.0, 0.61]);
    }
}

if(coupon) insert_coupon(); else rail();
