// =====================================================================
//  WisMesh 1W Grid Tray  —  caixa Rohdbox 110x110x60 IP68
//  Bandeja gradeada que:
//   - parafusa SOBRE a placa_laranja_gabarito (4 furos em 64 x 64 mm,
//     parafuso passante ate os pilares da caixa)
//   - recebe o conjunto WisMesh (RAK19007 + RAK3400 + RAK13302), 81 x 30 x 13,
//     em 6 torres com furo de 2,3 mm (rosca direta M2.5)
//   - segura duas 18650 (unidas com termoretratil) por bracadeiras de nylon,
//     que passam por qualquer vao da grade
// =====================================================================

// ---------------- pegada ----------------
grid_x    = 88.0;   // a placa laranja tem 90 x 90; 88 deixa 1 mm de folga por lado
grid_y    = 88.0;
grid_t    = 3.0;    // espessura da bandeja
corner_r  = 3.0;

// ---------------- fixacao na placa laranja ----------------
// furos da laranja: (18,18) (18,82) (82,18) (82,82) -> quadrado de 64 mm
fix_span  = 64.0;
fix_d     = 3.60;   // folga p/ M3 passante (a laranja tem Ø3,45)
fix_pad   = 2.0;    // reforco macico em volta do furo
fix_cs    = 6.2;    // rebaixo p/ cabeca do M3 (o furo de y=12 fica sob as baterias)
fix_cs_h  = 2.0;

// ---------------- conjunto WisMesh ----------------
pcb_l     = 81.0;   // comprimento do sanduiche (medido: 8,1 cm)
pcb_w     = 30.0;
pcb_x     = 2.0;    // canto da PCB, em coords da bandeja. Escolhido por busca:
                    // nesta posicao a PCB ocupa y 40..70 e NAO cobre nenhum furo
                    // de fixacao (y=12 e 76), e a torre mais proxima de um furo
                    // fica a 11,7 mm - nenhuma colisao.
pcb_y     = 44.0;   // libera y 4..42 p/ as baterias, ja fora da moldura
// 6 pontos de fixacao, relativos ao canto da PCB.
// Os 4 primeiros vem do modelo oficial do RAK19007 (validados no projeto do sled);
// os 2 ultimos sao a extensao do RAK13302, confirmados em 3 modelos independentes
// (adapter3, 341board, carlon-v6): x~75,4  y = 2,2 e 23,2  -> span 21 mm.
// Repare que a extensao NAO esta alinhada com os furos da placa mae.
wis_holes = [[ 3.81,  4.08], [ 3.81, 26.08],
             [55.81,  4.08], [57.81, 28.08],
             [75.40,  2.20], [75.40, 23.20]];
tower_h   = 6.0;    // altura livre sob a PCB (a doc pede >=8 mm do fundo do case:
                    // laranja 2,5 + bandeja 3,0 + 6,0 = 11,5 mm)
tower_od  = 6.0;
tower_id  = 2.30;   // rosca direta M2.5
tower_fil = 1.2;    // filete na base da torre

// ---------------- baterias 18650 ----------------
bat_l     = 67.0;   // 65 da celula + folga
bat_w     = 38.0;   // duas 18650 lado a lado com termoretratil
bat_x     = 10.5;   // par de celulas centrado em X
bat_y     = 4.0;    // encosta na moldura interna, nao sobre ela
bat_rail  = 2.0;    // altura das guias que impedem o par de rolar
bat_cell_d= 18.6;

// ---------------- grade ----------------
bar_w     = 2.4;    // largura da barra
n_cell    = 8;      // vaos por lado; o tamanho do vao e' calculado para fechar
edge_w    = 3.5;    // moldura macica na borda

$fn = 64;

// vao calculado para a grade fechar exata entre as molduras:
//   n*cell + (n+1)*bar = L_util
util  = grid_x - 2*edge_w;
cell_w = (util - (n_cell+1)*bar_w) / n_cell;
pitch  = bar_w + cell_w;

echo(str("bandeja ",grid_x," x ",grid_y," x ",grid_t," mm"));
echo(str("furos de fixacao em ",fix_span," x ",fix_span," -> (",
         (grid_x-fix_span)/2,",",(grid_y-fix_span)/2,") etc"));
echo(str("PCB ocupa x ",pcb_x,"..",pcb_x+pcb_l,"   y ",pcb_y,"..",pcb_y+pcb_w));
echo(str("baterias ocupam x ",bat_x,"..",bat_x+bat_l,"   y ",bat_y,"..",bat_y+bat_w));
echo(str("altura livre sob a PCB, do fundo do case: ",2.5+grid_t+tower_h," mm"));
echo(str("grade: ",n_cell,"x",n_cell," vaos de ",cell_w," mm entre barras de ",bar_w));

// ============================ 2D ====================================
module plate2d()
    offset(r=corner_r) offset(delta=-corner_r) square([grid_x, grid_y]);

// matriz de vazios, recuada da borda
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
    for(dx=[-1,1], dy=[-1,1])
        translate([grid_x/2 + dx*fix_span/2, grid_y/2 + dy*fix_span/2]) children();

module tower_pos()
    for(h=wis_holes) translate([pcb_x+h[0], pcb_y+h[1]]) children();

// ============================ 3D ====================================
module tray()
    difference(){
        linear_extrude(grid_t) plate2d();
        // vazios da grade, poupando os reforcos dos furos e das torres
        linear_extrude(3*grid_t, center=true)
            difference(){
                grid_voids2d();
                fix_pos()  circle(d=fix_d + 2*fix_pad);
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

// guias em V que acomodam o par de 18650 e impedem que role
module bat_rails(){
    for(yy=[bat_y, bat_y+bat_w])
        translate([bat_x, yy-bat_rail/2, grid_t-0.01])
            cube([bat_l, bat_rail, bat_rail+0.01]);
}

module fix_holes()
    fix_pos(){
        translate([0,0,-1]) cylinder(h=grid_t+2, d=fix_d);
        // rebaixo: deixa a cabeca do parafuso abaixo da superficie, para nao
        // empurrar as baterias que passam por cima do furo de y=12
        translate([0,0,grid_t-fix_cs_h]) cylinder(h=fix_cs_h+1, d1=fix_d, d2=fix_cs);
    }

// ============================ MONTAGEM ==============================
difference(){
    union(){
        tray();
        towers();
        bat_rails();
    }
    fix_holes();
}
