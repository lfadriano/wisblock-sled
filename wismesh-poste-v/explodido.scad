// =====================================================================
//  Vista explodida com a ferragem identificada — NAO e' peca.
//
//  Usa os STL na posicao MONTADA (_ber_m0, _ber_m1, _sup_m, _cha_m),
//  gerados com print_ready=false. Como gerar: ver "Gerar" no README.
//
//  As etiquetas encaram a camera por construcao: a matriz e' montada a
//  partir de EYE/CEN, entao basta passar os MESMOS valores no --camera
//  (forma de 6 numeros, olho + alvo) e elas saem sempre de frente.
// =====================================================================

E   = 1;                        // 0 = montado | 1 = explodido
EYE = [ 1120, -1450, 820];      // TEM de bater com o --camera
CEN = [    0,   200, -35];
$fn = 32;

// ---------------- vetores de explosao ----------------
EP  = [0,   0, -80];            // poste, para baixo
EB1 = [0,-115,   0];            // contra-peca do berco
ECX = [0, 115,   0];            // caixa
ECH = [0, 115,  85];            // chapeu
ESU = [0, 245,   0];            // suportes em L
ECP = [0, 400,  70];            // chapa + paineis

// =====================================================================
//  etiquetas que encaram a camera + linha de chamada
// =====================================================================
function nrm(v) = v/norm(v);
D = nrm(CEN-EYE);  R = nrm(cross(D,[0,0,1]));  U = cross(R,D);
FR = -D*60;                     // empurra a etiqueta para a frente de tudo

module tag(anc, off, txt){
    p = anc + off;
    color("#c1121f"){
        translate(p+FR)
            multmatrix([[R[0],U[0],-D[0],0],[R[1],U[1],-D[1],0],[R[2],U[2],-D[2],0]])
                linear_extrude(1) text(txt, size=26, halign="center",
                    valign="center", font="DejaVu Sans:style=Bold");
        hull(){ translate(anc+FR*0.9) sphere(1.2);
                translate(p+FR-nrm(off)*20) sphere(1.2); }
    }
}

// =====================================================================
//  cotas e modulos da ferragem
// =====================================================================
function af(d)     = (d==5) ? 8.0 : 7.0;    // entre faces
function nyloc(d)  = 5.0;                   // DIN 985
function din934(d) = (d==5) ? 4.0 : 3.2;    // porca comum

module hex(af_, h) cylinder(h=h, r=af_/sqrt(3), $fn=6);
// cabeca sextavada na origem, haste subindo em +Z
module parafuso(d, L) color("#8a9099"){
    translate([0,0,-0.7*d]) hex(1.8*d, 0.7*d);
    cylinder(h=L, d=d);
}
module porca(d, h)       color("#4f555c") hex(af(d), h);
module arruela(d, de, t) color("#c3cad1")
    difference(){ cylinder(h=t, d=de); translate([0,0,-1]) cylinder(h=t+2, d=d); }
module inserto(d, L)     color("#c08b35")
    difference(){ cylinder(h=L, d=d+2); translate([0,0,-1]) cylinder(h=L+2, d=d*0.8); }

// =====================================================================
//  PECAS
// =====================================================================
color("#8d949b") translate(E*EP) translate([0,0,-186])
    difference(){ cylinder(h=180,d=31.7); translate([0,0,-1]) cylinder(h=182,d=28.3); }

color("#2f6fb3") import("_ber_m0.stl");
color("#3f7fc3") translate(E*EB1) import("_ber_m1.stl");
color("#cfd4d8") translate(E*ECX) translate([-55,34,-110]) cube([110,60,110]);
color("#f2f2ee") translate(E*ECH) translate([0,64,0]) import("_cha_m.stl");
color("#e0922f") translate(E*ESU) for(sx=[-45,45]) translate([sx,0,0]) import("_sup_m.stl");
color("#23262a") translate(E*ECH) translate([0,46,0]) cylinder(h=154,d=13);
color("#6b7075") translate(E*ECX) translate([0,46,-2]) cylinder(h=14,d=9);
translate(E*ECP) translate([0,94,0]) rotate([-15,0,0]){
    color("#aeb8c0") translate([-115,0,-3]) cube([230,185,3]);
    color("#1d3a63") for(sx=[-103,15]) translate([sx,30,0]) cube([88,142,2.5]);
}

// =====================================================================
//  1 · M5 x 35 das orelhas (4) — cabeca no bolso atras da placa,
//      arruela grande Ø15 dos dois lados, porca nyloc do lado de fora
// =====================================================================
for(bx=[-28,28], z=[-24,-74]){
    translate([bx, -30-E*30, z]) rotate([90,0,0]){
        parafuso(5,35); translate([0,0,-1.2]) arruela(5.5,15,1.2); }
    translate([bx, -14-E*155, z]) rotate([-90,0,0]){
        arruela(5.5,15,1.2); translate([0,0,1.2]) porca(5,nyloc(5)); }
}
tag([28,-60-E*30,-24], [0,-25,72], "1");
tag([28,-14-E*155,-24], [-15,-25,66], "1");

// =====================================================================
//  2 · M5 x 55 passante, atravessa o poste (1)
// =====================================================================
translate([ 22+E*80,0,-49]) rotate([0,-90,0]){
    parafuso(5,55); translate([0,0,-1.2]) arruela(5.5,15,1.2); }
translate([-22-E*80,0,-49]) rotate([0,90,0]){
    arruela(5.5,15,1.2); translate([0,0,1.2]) porca(5,nyloc(5)); }
tag([22+E*80,0,-49], [35,0,-50], "2");

// =====================================================================
//  3 · M4 x 20 caixa -> placa do berco (4) — cabeca DENTRO da caixa
// =====================================================================
for(bx=[-46.5,46.5], z=[-18,-92]){
    translate([bx, 37+E*40, z]) rotate([90,0,0]){
        parafuso(4,20); translate([0,0,-1.0]) arruela(4.3,9,1.0); }
    translate([bx, 24-E*62, z]) rotate([-90,0,0]){
        arruela(4.3,9,1.0); translate([0,0,1.0]) porca(4,nyloc(4)); }
}
tag([46.5,37+E*40,-18], [20,-15,58], "3");

// =====================================================================
//  4 · M4 x 16 tampa -> suporte em L (4) — cabeca dentro da caixa
//  5 · porca M4 DIN 934 aprisionada, entra pela face +x do suporte
// =====================================================================
for(sx=[-45,45], z=[-10,-100]){
    translate([sx, 90+E*135, z]) rotate([-90,0,0]){
        parafuso(4,16); translate([0,0,-1.2]) arruela(4.3,12,1.2); }
    translate([sx+7.5+E*55, 104.2+E*245, z]) rotate([0,90,0]) porca(4,din934(4));
}
tag([45,90+E*135,-10], [10,-45,62], "4");
tag([45+7.5+E*55,104.2+E*245,-10], [55,10,-48], "5");

// =====================================================================
//  6 · inserto de latao M4 8x6 (4), assentado a quente no suporte
//  7 · M4 x 12 que prende a chapa (4)
// =====================================================================
for(sx=[-45,45], s=[45,150])
    translate(E*ESU) translate([sx,94,0]) rotate([-15,0,0]) translate([0,s,0]){
        translate([0,0,E*55]) inserto(4,8);
        translate([0,0,E*150]) { arruela(4.3,9,1.0);
            translate([0,0,1.0]) rotate([180,0,0]) parafuso(4,-12); }
    }
function ramp(sx,s,h) = E*ESU + [sx, 94+s*cos(15)+h*sin(15), -s*sin(15)+h*cos(15)];
tag(ramp(45,45,E*55+4),  [35,0,30], "6");
tag(ramp(45,45,E*150+6), [35,0,30], "7");
