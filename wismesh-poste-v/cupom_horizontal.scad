// =====================================================================
//  Cupom de inserto — FURO HORIZONTAL
//  WisMesh no poste · para o suporte em L
//
//  O cupom do pu-rail tem os furos VERTICAIS, que e' a condicao daquela
//  peca. Aqui nao serve: o suporte em L imprime DEITADO e o furo do
//  inserto sai com o eixo PARALELO AO LEITO. Furo horizontal e' outra
//  coisa — ele fatia em cordas, nao em circunferencias, e o topo sai em
//  ponte, achatado e um pouco menor. Testar num cupom vertical e aplicar
//  o numero num furo horizontal e' comparar coisas diferentes.
//
//  Este cupom reproduz a condicao REAL:
//    - eixo do furo a 7,5 mm do leito, que e' o meio da espessura de
//      15 mm do suporte
//    - altura total 15 mm, igual a do suporte: o tanto de material acima
//      da ponte e' o mesmo
//    - furo cego de 9,0 (8 do inserto + 1 de alivio), igual ao suporte
//
//  Imprima com o MESMO material, MESMA camada e MESMO perfil do suporte.
//
//  Cinco furos de 5,40 a 5,80 com 1 a 5 tracinhos ao lado (1 traco = 5,40)
//  e, na ponta, UM FURO VERTICAL de 5,60 marcado com um quadrado — a
//  referencia. Se o vertical e o de 3 tracos assentarem igual, a
//  orientacao nao importa e o cupom antigo valia; se nao, este manda.
//
//    openscad -o cupom_horizontal.stl cupom_horizontal.scad
// =====================================================================

cup_d   = [5.40, 5.50, 5.60, 5.70, 5.80];
ref_d   = 5.60;     // o furo vertical de referencia
pitch   = 13.0;

alt     = 15.0;     // = espessura do suporte em L
eixo_z  =  7.5;     // = meio da espessura do suporte
prof    = 18.0;     // profundidade da barra (o furo entra 9)
ins_h   =  9.00;    // 8 do inserto + 1 de alivio
ins_ch  =  0.60;

tr_w    =  0.60;    // tracinhos
tr_l    =  3.00;
tr_d    =  0.60;
tr_p    =  1.20;

$fn = 64;

// =====================================================================
n   = len(cup_d);
c_l = (n+1)*pitch;

echo(str("cupom ",c_l," x ",prof," x ",alt));
echo(str("furos HORIZONTAIS: eixo a ",eixo_z," do leito, ponte a ",eixo_z+max(cup_d)/2," -> ",alt-eixo_z-max(cup_d)/2," mm de material acima"));
for(i=[0:n-1]) echo(str("  ",i+1," traco(s) -> Ø",cup_d[i]," em x=",-c_l/2+pitch*(i+0.5)));
echo(str("  quadrado -> Ø",ref_d," VERTICAL, referencia, em x=",-c_l/2+pitch*(n+0.5)));

// boca exatamente na face da frente, para os 9 mm serem medidos dali
module furo_horizontal(x0, d){
    translate([x0, prof+0.01, eixo_z]) rotate([90,0,0]){
        translate([0,0,-0.01]) cylinder(h=ins_h+0.02, d=d);
        translate([0,0,-0.01]) cylinder(h=ins_ch+0.02, d1=d+2*ins_ch, d2=d);
    }
}

module furo_vertical(x0, d){
    translate([x0, prof/2, alt-ins_h]){
        cylinder(h=ins_h+0.01, d=d);
        translate([0,0,ins_h-ins_ch]) cylinder(h=ins_ch+0.01, d1=d, d2=d+2*ins_ch);
    }
}

difference(){
    translate([-c_l/2, 0, 0]) cube([c_l, prof, alt]);
    // os cinco de teste, horizontais, entrando pela face da frente
    for(i=[0:n-1]) furo_horizontal(-c_l/2+pitch*(i+0.5), cup_d[i]);
    // a referencia vertical, na ponta
    furo_vertical(-c_l/2+pitch*(n+0.5), ref_d);
    // tracinhos no topo, ao lado de cada furo
    for(i=[0:n-1], k=[0:i])
        translate([-c_l/2+pitch*(i+0.5) - (i*tr_p)/2 + k*tr_p - tr_w/2,
                   prof-tr_l-2.0, alt-tr_d])
            cube([tr_w, tr_l, tr_d+0.01]);
    // quadrado marcando a referencia vertical
    translate([-c_l/2+pitch*(n+0.5)-3.0, prof-8.0, alt-tr_d])
        difference(){
            cube([6.0, 6.0, tr_d+0.01]);
            translate([tr_w,tr_w,-0.1]) cube([6.0-2*tr_w, 6.0-2*tr_w, tr_d+0.3]);
        }
}
