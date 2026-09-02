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
// Os pilares de ar da caixa vao do fundo a tampa, e a placa laranja tem os 4
// cantos recortados em L para desviar deles. A bandeja usa o MESMO contorno,
// extraido do proprio placa_laranja_gabarito.stl (92 pontos, eps 0,12 mm),
// recuado por grid_inset.
grid_x    = 90.0;   // contorno da laranja
grid_y    = 90.0;
grid_t    = 3.0;    // espessura da bandeja
grid_inset= 0.5;    // recuo em relacao ao contorno da laranja
laranja = [[0,10.125], [0.25,9.875], [0.25,9.375], [0.5,8.875], [0.875,8.5], [1.375,8.25], [1.875,8.25], [2.125,8], [14.875,8], [15.125,7.75], [15.625,7.75], [16.125,7.5], [16.5,7.125], [16.75,6.625], [16.75,6.125], [17,5.875], [17,2.125], [17.25,1.875], [17.25,1.375], [17.875,0.5], [18.375,0.25], [18.875,0.25], [19.125,0], [70.875,0], [71.125,0.25], [71.625,0.25], [72.125,0.5], [72.75,1.375], [72.75,1.875], [73,2.125], [73,5.875], [73.25,6.125], [73.25,6.625], [73.5,7.125], [73.875,7.5], [74.375,7.75], [74.875,7.75], [75.125,8], [87.875,8], [88.125,8.25], [88.625,8.25], [89.125,8.5], [89.5,8.875], [89.75,9.375], [89.75,9.875], [90,10.125], [90,79.875], [89.75,80.125], [89.75,80.625], [89.5,81.125], [89.125,81.5], [88.625,81.75], [88.125,81.75], [87.875,82], [75.125,82], [74.875,82.25], [74.375,82.25], [73.875,82.5], [73.5,82.875], [73.25,83.375], [73.25,83.875], [73,84.125], [73,87.875], [72.75,88.125], [72.75,88.625], [72.125,89.5], [71.625,89.75], [71.125,89.75], [70.875,90], [19.125,90], [18.875,89.75], [18.375,89.75], [17.875,89.5], [17.25,88.625], [17.25,88.125], [17,87.875], [17,84.125], [16.75,83.875], [16.75,83.375], [16.5,82.875], [15.625,82.25], [15.125,82.25], [14.875,82], [2.125,82], [1.875,81.75], [1.375,81.75], [0.875,81.5], [0.5,81.125], [0.25,80.625], [0.25,80.125], [0,79.875], [0,10.375]];

// ---------------- fixacao na placa laranja ----------------
// furos da laranja: (18,18) (18,82) (82,18) (82,82) -> quadrado de 64 mm
fix_span  = 64.0;
fix_c     = 13.125; // centro do 1o furo, medido do canto da laranja (18 - 4,875)
                    // (na laranja o recuo e' 13,125 num lado e 12,875 no outro:
                    //  o padrao de furos fica 0,125 mm fora do centro da placa)
// Furos PERIFERICOS: recebem as travas de pressao cinzas originais da caixa.
// Na laranja sao 4 x Ø3,008 no meio de cada aba reta; a grade precisa liberar
// os mesmos pontos, senao obstrui as travas.
per_d     = 3.40;   // folga sobre os 3,008 da laranja
per_pts   = [[3.125,45.125], [45.125,3.125], [45.125,87.125], [87.125,45.125]];
per_pad   = 1.8;
fix_d     = 3.60;   // folga p/ M3 passante (a laranja tem Ø3,45)
fix_pad   = 2.0;    // reforco macico em volta do furo
fix_cs    = 6.2;    // rebaixo p/ cabeca do M3 (o furo de y=12 fica sob as baterias)
fix_cs_h  = 2.0;

// ---------------- conjunto WisMesh ----------------
pcb_l     = 81.0;   // comprimento do sanduiche (medido: 8,1 cm)
pcb_w     = 30.0;
pcb_x     = 4.5;    // canto da PCB, em coords da bandeja. Escolhido por busca:
                    // nesta posicao a PCB ocupa y 40..70 e NAO cobre nenhum furo
                    // de fixacao (y=12 e 76), e a torre mais proxima de um furo
                    // fica a 11,7 mm - nenhuma colisao.
pcb_y     = 31.0;   // por busca sobre o contorno real: todas as torres apoiadas
                    // em material e a mais proxima a 20,4 mm de um furo de fixacao
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
bat_w     = 20.0;   // pack EMPILHADO: 18,6 de largura (as celulas ficam uma sobre
                    // a outra, 37,2 de altura). Lado a lado nao caberia: PCB 30 +
                    // 38 = 68 nos 74 mm uteis deixa o furo de fixacao no caminho
                    // da torre da extensao.
bat_x     = 10.5;   // par de celulas centrado em X
bat_y     = 8.0;    // y=8 e' onde o material comeca nas faixas laterais
bat_rail  = 6.0;    // guias altas: o pack empilhado e' estreito e alto, precisa
                    // de encosto lateral para nao tombar
bat_cell_d= 18.6;
bat_stack = 37.2;   // altura do pack empilhado

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

echo(str("bandeja: contorno da placa laranja recuado ",grid_inset," mm, esp ",grid_t));
echo(str("furos de fixacao em ",fix_span," x ",fix_span," -> (",
         (grid_x-fix_span)/2,",",(grid_y-fix_span)/2,") etc"));
echo(str("PCB ocupa x ",pcb_x,"..",pcb_x+pcb_l,"   y ",pcb_y,"..",pcb_y+pcb_w));
echo(str("baterias ocupam x ",bat_x,"..",bat_x+bat_l,"   y ",bat_y,"..",bat_y+bat_w));
echo(str("altura livre sob a PCB, do fundo do case: ",2.5+grid_t+tower_h," mm"));
echo(str("grade: ",n_cell,"x",n_cell," vaos de ",cell_w," mm entre barras de ",bar_w));
echo(str("furos perifericos (travas da caixa): 4 x Dia ",per_d));

// ============================ 2D ====================================
module plate2d()
    offset(delta=-grid_inset) polygon(laranja);

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
    for(x=[fix_c, fix_c+fix_span], y=[fix_c, fix_c+fix_span])
        translate([x, y]) children();

module per_pos()
    for(p=per_pts) translate(p) children();

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
                per_pos()  circle(d=per_d + 2*per_pad);
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
        translate([bat_x, yy-1.0, grid_t-0.01])
            cube([bat_l, 2.0, bat_rail+0.01]);
}

module per_holes()
    per_pos() translate([0,0,-1]) cylinder(h=grid_t+2, d=per_d, $fn=48);

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
    per_holes();
}
