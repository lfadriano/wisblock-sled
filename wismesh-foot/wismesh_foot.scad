// =====================================================================
//  WisMesh Foot — pezinho avulso, colado com PU
//  Alternativa a bandeja gradeada: em vez de parafusar uma placa inteira,
//  colam-se 6 pezinhos direto na placa laranja, um por furo do conjunto
//  WisMesh. Permite posicionar o conjunto onde se quiser.
//
//  A altura total (9,0) foi escolhida para dar a MESMA altura livre da
//  bandeja: laranja 2,5 + pe 9,0 = 11,5 mm do fundo do case, acima dos
//  8 mm que a documentacao da caixa exige.
//
//  O furo do parafuso e' CEGO: sobra fundo macico para o parafuso nunca
//  tocar a placa laranja, mesmo que se use um mais longo.
// =====================================================================

// ---------------- torre ----------------
tower_od  = 6.0;
tower_h   = 6.0;    // altura da torre acima da base
tower_id  = 2.30;   // rosca direta M2.5
hole_h    = 6.50;   // profundidade do furo, medida do topo
tower_fil = 1.2;    // filete na raiz da torre

// ---------------- base de colagem ----------------
base_d    = 13.0;   // bem mais larga que a torre: area para o PU
base_h    = 3.0;
base_cham = 0.6;    // chanfro na borda inferior

// ---------------- ranhuras para o PU ----------------
// Aneis concentricos dao ancoragem mecanica ao adesivo (ele cura dentro do
// sulco e vira um rebite); os canais radiais deixam o excesso escapar em vez
// de formar bolha sob o pe.
groove_w  = 0.90;  // largura de 0,9 equilibra: 39% de area de contato
                    // direto e 46% de ranhura (~55 mm3 de PU alojado). Com 1,3
                    // o contato caia para 25%, pouco para o pe assentar plano.
groove_d  = 0.90;
groove_r  = [3.10, 5.30];   // raios dos aneis
rad_n     = 6;              // canais radiais
rad_w     = 0.90;
rad_r0    = 2.20;           // onde o canal comeca. Se partissem do centro, os 6
                            // se cruzariam ali e esvaziariam o miolo da face de
                            // colagem, que e' onde o PU mais trabalha.

// ---------------- copias no STL ----------------
// Uma peca so: os 6 pontos do WisMesh usam o mesmo M2.5, entao os 6 pes sao
// identicos. Duplique no fatiador. (n_x/n_y geram um tabuleiro, se preferir.)
n_x       = 1;
n_y       = 1;
spacing   = 17.0;

$fn = 72;

total_h = base_h + tower_h;
floor_t = total_h - hole_h;

echo(str("pe: base Dia ",base_d," x ",base_h," + torre Dia ",tower_od," x ",tower_h));
echo(str("altura total ",total_h," -> com a laranja de 2,5: ",2.5+total_h," mm do fundo"));
echo(str("furo Dia ",tower_id," CEGO, ",hole_h," de profundidade -> restam ",floor_t," mm de fundo macico"));
echo(str("STL com ",n_x*n_y," copia(s) - imprima 6 iguais"));

module foot(){
    difference(){
        union(){
            // base com chanfro embaixo
            cylinder(h=base_cham, d1=base_d-2*base_cham, d2=base_d);
            translate([0,0,base_cham]) cylinder(h=base_h-base_cham, d=base_d);
            // torre com filete na raiz
            translate([0,0,base_h-0.01]){
                cylinder(h=tower_h+0.01, d=tower_od);
                cylinder(h=tower_fil, d1=tower_od+2*tower_fil, d2=tower_od);
            }
        }
        // furo CEGO: nao atravessa, para o parafuso nao alcancar a placa
        translate([0,0,total_h-hole_h]) cylinder(h=hole_h+0.01, d=tower_id);

        // ranhuras na face de colagem
        for(r=groove_r)
            translate([0,0,-0.01])
                difference(){
                    cylinder(h=groove_d+0.01, r=r+groove_w/2);
                    translate([0,0,-0.1]) cylinder(h=groove_d+0.3, r=r-groove_w/2);
                }
        // canais radiais, para o excesso de PU sair
        for(i=[0:rad_n-1])
            rotate([0,0,i*360/rad_n])
                translate([rad_r0,-rad_w/2,-0.01])
                    cube([base_d/2+0.1-rad_r0, rad_w, groove_d+0.01]);
    }
}

for(i=[0:n_x-1], j=[0:n_y-1])
    translate([i*spacing, j*spacing, 0]) foot();
