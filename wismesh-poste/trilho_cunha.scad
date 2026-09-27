// =====================================================================
//  Trilho-cunha  —  WisMesh no poste, Manaus
//
//  Fica ENTRE a tampa da caixa Rohdbox e a chapa de aluminio:
//    face de baixo (plana) -> assenta na TAMPA, presa pelos 4 furos de
//                             canto da tampa (90 x 90, passantes, livres
//                             da vedacao: quem fecha a caixa e' a trava
//                             lateral em clipe)
//    face de cima (15 graus) -> recebe a chapa, em insertos M4
//
//  Sao DOIS trilhos, afastados 90 mm entre eixos. A inclinacao mora aqui
//  e em nenhum outro lugar do conjunto: a caixa fica NIVELADA, para a
//  antena sair vertical da face de cima, e so' a chapa e os paineis
//  inclinam. Os 15 graus sobre os 90 mm do gabarito custam 24 mm de
//  desnivel - contra os 94 mm que custariam debaixo de um painel grande.
//
//  O vao de ar sai divergente (15 -> 44,5 mm) no sentido da subida, que
//  e' o que faz a chamine puxar sozinha.
//
//    openscad -o trilho_cunha.stl trilho_cunha.scad
// =====================================================================

// ---------------- corpo ----------------
len    = 110.0;   // 110 e nao 90: sobra 10 mm alem de cada furo da tampa,
                  // e transborda 3,7 mm da borda da tampa (102,6) de
                  // proposito - a agua da chapa pinga para fora dela
wid    = 22.0;
h_lo   = 15.0;    // entrada da chamine
ang    = 15.0;    // MEDIDO no calculo de irradiacao: em Manaus (3,1 S) a
                  // geometria e' indiferente (15 graus custam 1,9% no ano
                  // e ganham 1,8% no mes pior). Os 15 sao pela LIMPEZA -
                  // abaixo de 10 a poeira assenta e o limo pega
cham_b = 0.40;    // mata pe de elefante na face que assenta na tampa

// ---------------- fixacao na TAMPA ----------------
// Furos da tampa: 90 x 90 entre eixos, Ø ~7,5 PASSANTES (medido no
// paquimetro: tampa 102,6 de lado -> recuo de 6,3 mm).
// O parafuso entra POR DENTRO da caixa, sobe pelo furo da tampa e rosca
// numa porca M4 aprisionada no trilho. Nao uso inserto aqui: o furo da
// tampa e' Ø7,5 e a parede que sobraria em volta de um inserto nao
// aguentaria a prensagem.
lid_x   = 45.0;   // +-45 -> 90 entre eixos
lid_d   = 4.50;   // passagem folgada de M4
nut_af  = 7.20;   // entre faces da porca M4 (7,0 + folga)
nut_t   = 3.40;
nut_z   = 5.00;   // altura da base da porca acima da face de baixo

// ---------------- fixacao da CHAPA ----------------
// Insertos de latao M4 8x6, perpendiculares a face de 15 graus.
ins_x   = 30.0;   // +-30: fica 15 mm afastado dos furos da tampa, os dois
                  // alojamentos nao se encontram
ins_d   = 5.60;   // CONFERIR no cupom antes de imprimir os definitivos
ins_h   = 9.00;   // 8 do inserto + 1 de alivio
ins_ch  = 0.60;

$fn = 64;

// =====================================================================
rise = len * tan(ang);
h_hi = h_lo + rise;
function h_at(x) = h_lo + (x + len/2) * tan(ang);

echo(str("trilho ",len," x ",wid,"   altura ",h_lo," -> ",h_hi," (desnivel ",rise," = ",ang," graus)"));
echo(str("furos da tampa em +-",lid_x," (",2*lid_x," entre eixos); altura do trilho ali: ",h_at(-lid_x)," e ",h_at(lid_x)));
echo(str("insertos em +-",ins_x,"; altura do trilho ali: ",h_at(-ins_x)," e ",h_at(ins_x)));
echo(str("material sob o inserto de montante: ",h_at(-ins_x) - ins_h/cos(ang)," mm"));
echo(str("vao de ar tampa->chapa: ",h_lo," na entrada, ",h_hi," na saida"));

// perfil lateral, no plano XZ, extrudado ao longo de Y
module corpo(){
    translate([0, wid, 0]) rotate([90,0,0])
        linear_extrude(wid)
            polygon([[-len/2, 0], [len/2, 0], [len/2, h_hi], [-len/2, h_lo]]);
}

// chanfro na aresta inferior externa
module chanfro_inf(){
    for(s=[0,1]) translate([0, s? wid : 0, 0]) rotate([0,0,s?180:0])
        translate([-len/2-1, -0.01, -0.01]) rotate([45,0,0])
            cube([len+2, cham_b*1.5, cham_b*1.5]);
}

module furo_tampa(x0){
    translate([x0, wid/2, -1]) cylinder(h = h_at(x0) + 2, d = lid_d);
    // bolsa da porca, entrando pela face lateral +Y
    translate([x0 - nut_af/2, wid/2 - nut_af/2, nut_z])
        cube([nut_af, wid/2 + nut_af/2 + 0.1, nut_t]);
}

// furo do inserto, PERPENDICULAR a face de 15 graus
module furo_inserto(x0){
    translate([x0, wid/2, h_at(x0)]) rotate([0, -ang, 0]){
        translate([0,0,-ins_h]) cylinder(h = ins_h + 0.01, d = ins_d);
        translate([0,0,-ins_ch]) cylinder(h = ins_ch + 0.01, d1 = ins_d, d2 = ins_d + 2*ins_ch);
    }
}

difference(){
    corpo();
    chanfro_inf();
    for(x = [-lid_x, lid_x]) furo_tampa(x);
    for(x = [-ins_x, ins_x]) furo_inserto(x);
}
