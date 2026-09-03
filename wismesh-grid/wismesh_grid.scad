// =====================================================================
//  WisMesh 1W Grid Tray  —  caixa Rohdbox 110x110x60 IP68
//  Bandeja gradeada que:
//   - parafusa SOBRE a placa laranja (4 furos num quadrado de 64 mm,
//     parafuso passante ate os pilares da caixa)
//   - recebe o conjunto WisMesh (RAK19007 + RAK3400 + RAK13302), 81 x 30 x 13,
//     em 6 torres com furo de 2,3 mm (rosca direta M2.5)
//   - segura um pack de duas 18650 EMPILHADAS por bracadeiras de nylon,
//     que passam por qualquer vao da grade
//
//  O contorno e construido a partir dos RECUOS medidos, nao copiado do
//  placa_laranja_gabarito.stl: aquele arquivo mede 90,000 mm de lado, enquanto
//  a placa fisica mede 99,8 no paquimetro. O que as duas tem em comum sao as
//  recuos dos recortes (8,1 e 17,1) e o span dos furos (64), ditado pela caixa.
// =====================================================================

// ---------------- placa laranja (referencia) ----------------
plate_side= 99.8;   // MEDIDO no paquimetro (o STL do gabarito da 90,000)
// Recuo dos recortes em L, conforme medido na placa fisica. Estes valores batem
// com o que extrai do STL do gabarito (8,0 e 16,75) - ja as abas de "74 e 56" do
// texto foram calculadas com lado 90,2, que era o lado do gabarito e nao da placa.
// Aplicados a partir da borda da BANDEJA, que e' 0,85 menor que a placa por lado,
// sobra 0,85 de folga extra para os pilares.
// Recuos derivados das ABAS medidas no paquimetro (73,4 e 55,3 num lado de 99,8),
// que sao auto-consistentes. As "profundidades" de 20 e 13,7 do texto nao
// reproduzem essas abas e aparecem trocadas em relacao a estes recuos - o
// boleado R7 no fundo do recorte explica a diferenca de leitura.
rec_major = 13.20;  // recuo em Y  -> aba maior nas bordas de X
rec_minor = 22.25;  // recuo em X  -> aba menor nas bordas de Y
corner_r  = 7.0;    // meia lua do canto do recorte (nao e' angulo reto)
grid_gap  = 0.85;   // folga da bandeja em relacao a placa, por lado

// ---------------- bandeja ----------------
L         = plate_side - 2*grid_gap;   // 98,1
grid_t    = 3.0;
// (sem boleado: ver nota em plate2d)

// ---------------- fixacao (pilares da caixa) ----------------
fix_span  = 59.6;   // span centro a centro, MEDIDO entre furos (a diagonal de
                    // 83,4 daria 58,97 e o recuo de 19,7 daria 60,4; usei a
                    // medida direta, que e' a mais confiavel das tres)
fix_d     = 3.60;   // folga p/ M3 passante
fix_pad   = 2.0;    // reforco macico em volta do furo
fix_cs    = 6.2;    // rebaixo p/ a cabeca (o furo de baixo fica sob o pack)
fix_cs_h  = 2.0;

// ---------------- colunas da caixa ----------------
// 4 colunas no meio de cada aba: 9,7 mm de largura, exigem 9,3 mm de recuo.
// Um circulo de Ø9,7 com centro a (9,3 - 9,7/2) da borda da exatamente essa
// profundidade e essa largura ("quase meia lua"). O gabarito da placa laranja
// NAO contempla esse recuo; a bandeja contempla.
// Estes recortes engolem os 4 furos perifericos que a laranja tem no meio das
// abas, portanto a bandeja nao os reproduz.
col_slack = 1.00;   // alargamento sobre a medida da coluna (9,4 ficou apertado).
                    // Vale so para a LARGURA - a profundidade de 8,0 esta boa.
col_d     = 9.40 + col_slack;
col_prof  = 8.00;   // termina RETO na borda (90 graus) e boleado so no fundo
col_r     = col_d/2; // 4,85 = metade da largura -> o fundo e' um semicirculo
                    // perfeito. Com um raio menor (ex. 4,0) sobraria um trecho
                    // reto no meio do fundo e o raio ficaria so nos cantos.

// ---------------- conjunto WisMesh ----------------
pcb_l     = 81.0;   // sanduiche RAK19007 + RAK3400 + RAK13302
pcb_w     = 30.0;
pcb_rot   = 90;     // 0 = PCB deitada ao longo de X | 90 = em pe ao longo de Y.
                    // Com 90 o pack vai para junto da aba MAIOR (71,7 nas bordas
                    // de X) e a PCB usa a direcao onde a peca tem 98,1 livres:
                    // a folga minima sobe de 4,3 para 12,4 mm.
pcb_x     = 33.0;
pcb_y     = 9.0;   // por busca: torres apoiadas em material e longe dos furos
                    // de fixacao e dos recortes das colunas
// 6 pontos, relativos ao canto da PCB. Os 4 primeiros vem do modelo oficial do
// RAK19007 (validados numa peca impressa); os 2 ultimos sao a extensao do
// RAK13302, confirmados em 3 modelos independentes de terceiros.
// A extensao NAO esta alinhada com a placa mae.
wis_holes = [[ 3.81,  4.08], [ 3.81, 26.08],
             [55.81,  4.08], [57.81, 28.08],
             [75.40,  2.20], [75.40, 23.20]];
tower_h   = 6.0;    // a doc da caixa pede >=8 mm livres do fundo:
                    // laranja 2,5 + bandeja 3,0 + 6,0 = 11,5 mm
tower_od  = 6.0;
tower_id  = 2.30;   // rosca direta M2.5
tower_fil = 1.2;

// ---------------- pack de baterias ----------------
// Pack EMPILHADO: 18,6 de largura x 37,2 de altura. Lado a lado (38 mm) nao
// caberia junto com a PCB na area util entre as abas.
bat_l     = 67.0;
bat_w     = 20.0;
bat_x     = 8.0;    // pack tambem em pe, encostado na aba maior
bat_y     = 14.0;
bat_rail  = 6.0;    // guias altas: pack estreito e alto tomba facil
bat_cell_d= 18.6;
bat_stack = 37.2;

// ---------------- grade ----------------
bar_w     = 2.4;
n_cell    = 9;
edge_w    = 3.5;

$fn = 64;

// dimensoes efetivas e furos ja rotacionados
pcb_ex  = (pcb_rot==90) ? pcb_w : pcb_l;
pcb_ey  = (pcb_rot==90) ? pcb_l : pcb_w;
bat_ex  = (pcb_rot==90) ? bat_w : bat_l;
bat_ey  = (pcb_rot==90) ? bat_l : bat_w;
wis_eff = (pcb_rot==90)
            ? [for(h=wis_holes) [pcb_w - h[1], h[0]]]
            : wis_holes;

rec_M = rec_major;
rec_m = rec_minor;
tab_major = L - 2*rec_M;     // aba nas bordas de X
tab_minor = L - 2*rec_m;     // aba nas bordas de Y
fix_c = (L - fix_span)/2;    // recuo dos furos de fixacao


util   = L - 2*edge_w;
cell_w = (util - (n_cell+1)*bar_w) / n_cell;
pitch  = bar_w + cell_w;

echo(str("bandeja ",L," x ",L," x ",grid_t," (placa ",plate_side," menos ",grid_gap," por lado)"));
echo(str("recuos: Y ",rec_M," / X ",rec_m," -> abas de ",tab_major," e ",tab_minor,", canto R",corner_r));
echo(str("furos de fixacao: span ",fix_span,", recuo ",fix_c," simetrico"));
echo(str("colunas: slot ",col_d," x ",col_prof,", reto na borda, cantos do fundo R",col_r));
echo(str("PCB (rot ",pcb_rot,") ocupa x ",pcb_x,"..",pcb_x+pcb_ex,"   y ",pcb_y,"..",pcb_y+pcb_ey));
echo(str("pack ocupa x ",bat_x,"..",bat_x+bat_ex,"   y ",bat_y,"..",bat_y+bat_ey));
echo(str("grade: ",n_cell,"x",n_cell," vaos de ",cell_w," entre barras de ",bar_w));
echo(str("altura livre sob a PCB, do fundo do case: ",2.5+grid_t+tower_h));

// ============================ 2D ====================================
// recorte de canto: retangulo rec_minor x rec_major com o canto INTERNO
// boleado em meia lua R7. Os outros tres cantos ficam fora da peca.
module corner_notch()
    translate([-20,-20])
        offset(r=corner_r) offset(delta=-corner_r)
            square([rec_minor+20, rec_major+20]);

module cross2d()
    difference(){
        square([L, L]);
        corner_notch();
        translate([L,0]) mirror([1,0]) corner_notch();
        translate([0,L]) mirror([0,1]) corner_notch();
        translate([L,L]) mirror([1,0]) mirror([0,1]) corner_notch();
    }

// Sem boleado de offset: qualquer par offset()/offset() desloca o recuo (medi
// +2,00 mm com delta e +0,46 com r), e aqui a cota manda - e' ela que desvia
// dos pilares. A cruz crua da o recuo exato de rec_major / rec_minor.
module plate2d() cross2d();

module grid_voids2d()
    intersection(){
        offset(delta=-edge_w) plate2d();
        union(){
            for(i=[0:n_cell-1], j=[0:n_cell-1])
                translate([edge_w + bar_w + i*pitch, edge_w + bar_w + j*pitch])
                    square([cell_w, cell_w]);
        }
    }

module fix_pos()
    for(x=[fix_c, L-fix_c], y=[fix_c, L-fix_c]) translate([x, y]) children();

module tower_pos()
    for(h=wis_eff) translate([pcb_x+h[0], pcb_y+h[1]]) children();

// ============================ 3D ====================================
module tray()
    difference(){
        linear_extrude(grid_t) plate2d();
        linear_extrude(3*grid_t, center=true)
            difference(){
                grid_voids2d();
                fix_pos()   circle(d=fix_d + 2*fix_pad);
                tower_pos() circle(d=tower_od + 2.2);
            }
    }

module towers()
    tower_pos()
        translate([0,0,grid_t-0.01]) difference(){
            union(){
                cylinder(h=tower_h+0.01, d=tower_od);
                cylinder(h=tower_fil, d1=tower_od+2*tower_fil, d2=tower_od);
            }
            translate([0,0,-grid_t]) cylinder(h=tower_h+grid_t+1, d=tower_id);
        }

module bat_rails()
    if(pcb_rot==90)
        for(xx=[bat_x, bat_x+bat_ex])
            translate([xx-1.0, bat_y, grid_t-0.01])
                cube([2.0, bat_ey, bat_rail+0.01]);
    else
        for(yy=[bat_y, bat_y+bat_ey])
            translate([bat_x, yy-1.0, grid_t-0.01])
                cube([bat_ex, 2.0, bat_rail+0.01]);

module fix_holes()
    fix_pos(){
        translate([0,0,-1]) cylinder(h=grid_t+2, d=fix_d);
        translate([0,0,grid_t-fix_cs_h]) cylinder(h=fix_cs_h+1, d1=fix_d, d2=fix_cs);
    }

// slot: laterais retas ate a borda (90 graus) e cantos do fundo boleados em col_r
module col_slot2d(){
    d   = col_prof - col_r;        // onde comeca o boleado
    off = col_d/2 - col_r;         // deslocamento dos centros dos arcos
    union(){
        translate([-2, -col_d/2]) square([d+2, col_d]);
        hull(){
            translate([d,  off]) circle(r=col_r, $fn=72);
            translate([d, -off]) circle(r=col_r, $fn=72);
        }
    }
}
module col_cuts()
    // o slot entra na direcao +X, entao cada borda precisa da rotacao que aponta
    // para DENTRO: y=0 pede +90 e y=L pede -90 (estavam trocadas)
    for(a=[[0,L/2,0], [L/2,0,90], [L/2,L,-90], [L,L/2,180]])
        translate([a[0],a[1],-1]) rotate([0,0,a[2]])
            linear_extrude(grid_t+2+bat_rail) col_slot2d();

// ============================ MONTAGEM ==============================
difference(){
    union(){
        tray();
        towers();
        bat_rails();
    }
    fix_holes();
    col_cuts();
}
