// =====================================================================
//  WisBlock SLED  —  cano PVC 40 mm (DI 34,5 mm)   [185,5 mm total]
//   = Wisblock_Plate_V1.1.stl  (importada intacta)
//   + placa estendida nos DOIS lados
//   + asas curvas REFORCADAS (filete na raiz, ponta 2,0 mm)
//   + suporte 18650_V2.STL  (deitado 90, ENCAIXADO em recorte passante da
//     placa, face inferior no MESMO NIVEL da placa -> imprime sem suporte)
//   + flange circular Ø34,4 x 3 mm com furo sextavado p/ SMA femea
//   + NOVO: prolongamento de 10 mm depois da bateria (base + asas) com
//           2 furos de bracadeira
//   + NOVO: 2 furos de bracadeira na extensao de 30 mm
//   + NOVO: 2 passagens de cabo assimetricas (uma por lado) que descem
//           pela asa e entram 2 mm na placa
// =====================================================================

PLATE  = "vendor/Wisblock_Plate_V1.1.stl";
HOLDER = "vendor/18650_V2.STL";

// ============ APERTO NO CANO ============
pipe_id      = 34.5;
fit_clear    = -0.12;  // NEGATIVO = interferencia. V1=+0.20 (solto) V2=-0.25 (quebrou)
                       //   -0.08 mais macio | -0.12 atual | -0.18 mais firme

// ============ ASAS: REFORCO ANTI-QUEBRA (PLA) ============
wall_base    = 3.0;    // raiz: IGUAL A V1. NAO aumentar: reduz o vao interno da PCB
wall_tip     = 1.8;    // ponta (V1=1.6, V2=1.4). 1.8 = +12% que V1 e ainda folga p/ a PCB
fillet       = 3.0;    // NOVO: filete na juncao asa/placa = ganho principal contra a quebra.
                       //   Fica INTEIRO abaixo da PCB (topo em z=5.69, PCB comeca em 6.35).
                       //   Se houver componentes na face de baixo da PCB nas bordas, reduza.
th1          = 52;
th_mid       = 80;     // zona grossa mais longa (V2 tinha 72)
th2          = 108;    // V2 tinha 115 -> encurtado p/ reduzir a alavanca
slit_n       = 12;
slit_w       = 1.6;
slit_z0      = 6.0;    // fendas comecam ACIMA do filete: raiz fica continua
cham_len     = 3.0;
cham_depth   = 1.2;
cham_len_a   = 4.0;    // rampa suave no lado do flange
cham_depth_a = 0.35;

plate_recess = 0.40;

// ============ PLACA / CONJUNTO ============
plate_w   = 29.781971;
plate_t   = 3.18;
plate_l0  = 95.91259;   // placa original importada (x 0..95.91)
corner_r  = 2.0;

pcb_len   = 60.0;       // RAK19007 (medido do rakcircuito.fpp)
holder_gap= 4.5;

h_len     = 91.0;       // 18650_V2.STL
h_y0      = 5.8338027;
h_w       = 22.20;
h_h       = 18.55;
holder_x0 = pcb_len + holder_gap;   // 64.5
x_hold_e  = holder_x0 + h_len;      // 155.5  fim do suporte da bateria
tail_len  = 15.0;                   // prolongamento DEPOIS da bateria (base + asas)
x_end     = x_hold_e + tail_len;    // 170.5  fim da placa e das asas
// Holder ENCAIXADO num recorte passante da placa: a face inferior dele fica
// no MESMO NIVEL da face inferior da placa (z=0), assentando no leito.
// Nao ha piso sob o holder -> nada de suporte e a mola trabalha livre.
h_base_z  = 0.0;
h_inset   = 0.20;   // recorte 0,2 mm menor que o holder em cada face (solda no CSG)

// ============ FLANGE DA ANTENA (SMA) ============
ant_len     = 30.0;              // comprimento adicionado nesta extremidade
x_start     = -ant_len;          // -30
disc_t      = 3.0;               // espessura do disco
disc_d      = 34.4;              // Ø do disco (folga de 0,1 no cano)
x_disc1     = x_start + disc_t;  // -27  face interna do disco
sma_hole_d  = 6.50;              // furo da rosca (medido do exemplo)
sma_hex_af  = 8.41;              // sextavado ENTRE FACES (medido do exemplo)
sma_hex_dep = 2.00;              // profundidade do rebaixo sextavado
sma_hex_in  = true;              // true = sextavado voltado p/ DENTRO do cano
sma_cham    = 0.5;               // chanfro de entrada do furo
relief_len  = 13.0;              // alivio na placa p/ o corpo do SMA e o cabo
relief_w    = 10.0;
disc_cham   = 0.8;               // chanfro na borda externa do disco
disc_flat   = true;             // false = circulo INTEIRO (como pedido): a peca desce
                                 //         9,2 mm abaixo da placa -> exige suporte
                                 // true  = corta o disco em z=0: volta a ter base plana
                                 //         e imprime deitada SEM suporte (perde o
                                 //         segmento inferior do circulo)

// ============ BRACADEIRAS DE NYLON (orificios OBLONGOS) ============
tie_len    = 4.0;    // comprimento do oblongo, ao longo de X
tie_w      = 2.2;    // largura do oblongo, ao longo de Y (fita ~2,5 x 1,0 mm)
// par SUPERIOR: ao lado do recorte quadrado do SMA (recorte ocupa y 9,89..19,89)
tie_top_dy = 8.4;    // -> y = 6,49 e 23,29 : entre a asa (3,05) e o recorte (9,89)
// par INFERIOR: no prolongamento, 5 mm antes da ponta
tie_bot_dy = 6.0;    // -> y = 8,89 e 20,89
tie_bot_back = 5.0;  // recuo a partir do fim da placa
tie_top2_off = 10.0; // 2o par superior: 10 mm abaixo do primeiro
// pares para amarrar a BATERIA: ficam na faixa estreita entre a asa e o holder,
// entao atravessam de proposito a raiz da asa e a parede do trilho. Nessa altura
// (z 0..3,18) nao ha mola (y>=5,87) nem carro (z>=5,20): o mecanismo nao e' tocado.
tie_bat_dy   = 11.29; // -> y = 3,60 e 26,18
tie_bat_frac = [0.34, 0.67];  // posicao ao longo do suporte da bateria

// ============ DEGRAU DE PEGA (borda inferior) ============
// nervura transversal acima da placa, na ponta oposta a antena: da o apoio
// para empurrar/puxar o sled dentro do cano.
grip_len  = 2.5;     // comprimento em X (fica depois dos oblongos inferiores)
grip_h    = 3.0;     // altura acima da placa
grip_marg = 3.2;     // recuo em Y, para nao invadir as asas

// ============ PASSAGENS DE CABO (assimetricas) ============
// medidas ABAIXO dos FUROS SUPERIORES DA PCB (o par M2 em x=3.81),
// na direcao da bateria -> as passagens ficam ao LADO da PCB
cable_w      = 3.5;  // largura da passagem
cable_into   = 2.0;  // quanto avanca dentro da placa (evita o fio raspar no cano)
cable_L_off  = 10.0; // cabo da ESQUERDA (y baixo):  10 mm abaixo do furo M2
cable_R_off  = 20.0; // cabo da DIREITA  (y alto):   20 mm abaixo do furo M2
cable_swap   = false;// ESQ recebe 10 mm, DIR recebe 20 mm (abaixo dos furos M2)

$fn = 120;

R_out = (pipe_id - fit_clear)/2;
R_in  = R_out - wall_base;
yc    = plate_w/2;
zc    = sqrt(pow(R_out-plate_recess,2) - pow(plate_w/2,2));
hy0   = yc - h_w/2;
hy1   = yc + h_w/2;
wing_x0 = x_disc1;               // asas nascem fundidas ao disco
sma_hex_cc = sma_hex_af/cos(30); // Ø circunscrito do hexagono

echo(str("R_out=",R_out," (Dia ",2*R_out,")   eixo do cano Z=",zc));
echo(str("arco da asa = ",(th2-th1)*3.14159265*R_out/180," mm"));
echo(str("comprimento total = ",x_end-x_start," mm  (x ",x_start," a ",x_end,")"));
echo(str("hexagono: entre faces ",sma_hex_af,"  circunscrito ",sma_hex_cc));
echo(str("disco: z de ",zc-disc_d/2," a ",zc+disc_d/2));
echo(str("prolongamento: bateria termina em ",x_hold_e,", placa/asas ate ",x_end));
echo(str("no STL (+",-x_start,"): passagem ESQ x=",cab_L_x-x_start,"  DIR x=",cab_R_x-x_start));
echo(str("bracadeiras no STL: superior x=",tie_top_x-x_start," y=",yc-tie_top_dy," e ",yc+tie_top_dy));
echo(str("bracadeiras no STL: inferior x=",tie_bot_x-x_start," y=",yc-tie_bot_dy," e ",yc+tie_bot_dy));
echo(str("2o par superior no STL: x=",tie_top_x+tie_top2_off-x_start));
echo(str("furos da bateria no STL: x=",holder_x0+tie_bat_frac[0]*h_len-x_start,
         " e ",holder_x0+tie_bat_frac[1]*h_len-x_start,
         "   y=",yc-tie_bat_dy," e ",yc+tie_bat_dy));
echo(str("degrau de pega no STL: x ",x_end-grip_len-x_start," a ",x_end-x_start,
         "   z ",plate_t," a ",plate_t+grip_h));
echo(str("recorte do SMA no STL: x ",x_disc1-x_start," a ",x_disc1+relief_len-x_start,
         "   y ",yc-relief_w/2," a ",yc+relief_w/2));

// ========================= ASAS + FILETE =============================
module sector2d(a1,a2,r)
    polygon(concat([[0,0]],
                   [for(a=[a1:1.5:a2]) [-r*sin(a), -r*cos(a)]],
                   [[-r*sin(a2), -r*cos(a2)]]));

module ring_sector(rout, rin, a1, a2)
    intersection(){
        difference(){ circle(r=rout); circle(r=rin); }
        sector2d(a1, a2, rout+3);
    }

// filete concavo entre a face interna da asa e o topo da placa
module fillet2d(f){
    zf = plate_t + f;                                  // centro do filete
    yf = yc - sqrt(pow(R_in-f,2) - pow(zf-zc,2));
    dy = yf-yc; dz = zf-zc; dl = sqrt(dy*dy+dz*dz);
    zt = zf + f*dz/dl;                                 // tangencia com a face da asa
    difference(){
        intersection(){
            translate([yc,zc]) circle(r=R_in);
            translate([yf-60, plate_t]) square([60, zt-plate_t]);
        }
        translate([yf, zf]) circle(r=f);
    }
}

module wing_half2d(){
    translate([yc, zc]){
        ring_sector(R_out, R_in,             th1,    th_mid+0.01);
        ring_sector(R_out, R_out-wall_tip,   th_mid, th2);
    }
    fillet2d(fillet);
}

module wings_raw()
    multmatrix([[0,0,1,0],[1,0,0,0],[0,1,0,0],[0,0,0,1]])
        translate([0,0,wing_x0])
            linear_extrude(height=x_end-wing_x0)
                union(){
                    wing_half2d();
                    translate([2*yc,0]) mirror([1,0]) wing_half2d();
                }

module chamfer_cut(x0, dir, len, dep)
    translate([x0, yc, zc]) rotate([0, 90*dir, 0])
        difference(){
            cylinder(h=len, r=R_out+12);
            cylinder(h=len, r1=R_out-dep, r2=R_out+0.01);
        }

module slits()
    for(i=[0:slit_n-1])
        translate([wing_x0 + (x_end-wing_x0)*(i+0.5)/slit_n - slit_w/2, -40, slit_z0])
            cube([slit_w, plate_w+80, 60]);

module wings()
    difference(){
        wings_raw();
        chamfer_cut(wing_x0-0.01, 1, cham_len_a, cham_depth_a); // rampa suave junto ao disco
        chamfer_cut(x_end+0.01, -1, cham_len,   cham_depth);
        slits();
        translate([-60,-50,-60]) cube([300, plate_w+100, 60]);  // corta z<0
    }

// ===================== PLACA: EXTENSOES ==============================
// laje de xa a xb (coords globais). round_lo/round_hi arredondam a ponta;
// uma ponta nao arredondada e' estendida e cortada reta (fica embutida).
module plate_slab(xa, xb, round_lo, round_hi){
    lo = round_lo ? 0 : 8;
    hi = round_hi ? 0 : 8;
    intersection(){
        translate([xa-lo, 0])
            offset(r=corner_r) offset(delta=-corner_r)
                square([(xb+hi)-(xa-lo), plate_w]);
        translate([xa, -5]) square([xb-xa, plate_w+10]);
    }
}
// esquerda: encosta no disco (reto) e entra 6 mm na placa original (reto)
module plate_ext_left()
    linear_extrude(plate_t) plate_slab(x_disc1, 6, false, false);
// direita: entra na placa original (reto) e a ponta final e' arredondada
module plate_ext_right()
    linear_extrude(plate_t) plate_slab(90, x_end, false, true);

// ============ RECORTE DO HOLDER (passante, encaixe) ==================
// Recorte PASSANTE com a pegada do holder: sem degrau, sem piso.
// O holder se solda nas 4 paredes verticais do recorte, ao longo dos
// 3,18 mm de espessura da placa. Base do holder = base da placa (z=0),
// entao ele assenta no leito e a mola imprime apoiada: SEM SUPORTE.
// (o recorte tambem remove o pino Ø5,13 que existia em x=89,55)
module holder_pocket()
    translate([holder_x0+h_inset, hy0+h_inset, -5])
        cube([h_len-2*h_inset, h_w-2*h_inset, 50]);

module holder()
    translate([holder_x0, yc + h_w/2, h_base_z - h_y0])
        rotate([90,0,0]) import(HOLDER, convexity=10);

// ==================== FLANGE DA ANTENA ===============================
module disc_solid()
    if(disc_flat)
        difference(){ disc_raw(); translate([-60,-50,-60]) cube([300,140,60]); }
    else
        disc_raw();

module disc_raw()
    translate([x_start, yc, zc]) rotate([0,90,0])
        difference(){
            cylinder(h=disc_t, d=disc_d, $fn=220);
            // chanfro na borda externa (facilita a entrada no cano)
            difference(){
                cylinder(h=disc_cham, r=disc_d/2+2);
                cylinder(h=disc_cham, r1=disc_d/2-disc_cham, r2=disc_d/2+0.01);
            }
        }

module sma_cuts()
    translate([x_start, yc, zc]) rotate([0,90,0]){
        // furo da rosca, passante
        translate([0,0,-1]) cylinder(h=disc_t+2, d=sma_hole_d, $fn=90);
        // chanfro de entrada do furo (lado oposto ao sextavado)
        if(sma_hex_in)
            translate([0,0,-0.01]) cylinder(h=sma_cham, d1=sma_hole_d+2*sma_cham, d2=sma_hole_d);
        else
            translate([0,0,disc_t-sma_cham+0.01]) cylinder(h=sma_cham, d1=sma_hole_d, d2=sma_hole_d+2*sma_cham);
        // rebaixo sextavado
        if(sma_hex_in)
            translate([0,0,disc_t-sma_hex_dep]) cylinder(h=sma_hex_dep+1, d=sma_hex_cc, $fn=6);
        else
            translate([0,0,-1]) cylinder(h=sma_hex_dep+1, d=sma_hex_cc, $fn=6);
    }

// os 4 furos M2 + 2 furos Ø2,54 sao reabertos depois do filete,
// para que o filete nunca obstrua um parafuso
plate_holes = [[ 3.81, 4.08, 2.05], [ 3.81,26.08, 2.05],
               [55.81, 4.08, 2.05], [57.81,28.08, 2.05],
               [13.13,13.40, 2.56], [63.12,13.40, 2.56]];
module reopen_holes()
    for(h=plate_holes)
        translate([h[0], h[1], -1]) cylinder(h=10, d=h[2], $fn=48);

// alivio na placa: passagem do corpo do SMA e do cabo
module sma_relief()
    translate([x_disc1-0.01, yc-relief_w/2, -1])
        cube([relief_len, relief_w, plate_t+2]);

// ================= BRACADEIRAS E PASSAGENS DE CABO ===================
pcb_top_x  = 3.81;                           // furos SUPERIORES da PCB (par M2)
tie_top_x  = (x_disc1 + (x_disc1+relief_len))/2;  // centro do recorte do SMA
tie_bot_x  = x_end - tie_bot_back;            // 5 mm antes da ponta
cab_L_x    = pcb_top_x + (cable_swap ? cable_R_off : cable_L_off);
cab_R_x    = pcb_top_x + (cable_swap ? cable_L_off : cable_R_off);

module tie_slot(xc, yy)
    translate([xc, yy, -1]) linear_extrude(plate_t+2)
        hull(){
            translate([-(tie_len-tie_w)/2, 0]) circle(d=tie_w, $fn=36);
            translate([ (tie_len-tie_w)/2, 0]) circle(d=tie_w, $fn=36);
        }

module tie_holes(){
    for(dy=[-tie_top_dy, tie_top_dy]) tie_slot(tie_top_x,              yc+dy);
    for(dy=[-tie_top_dy, tie_top_dy]) tie_slot(tie_top_x+tie_top2_off, yc+dy);
    for(dy=[-tie_bot_dy, tie_bot_dy]) tie_slot(tie_bot_x,              yc+dy);
}

// furos da bateria: aplicados DEPOIS de unir o holder, para atravessarem
// tambem a parede do trilho e deixarem a passagem com a largura cheia.
module tie_bat_holes()
    for(f=tie_bat_frac)
        for(dy=[-tie_bat_dy, tie_bat_dy])
            translate([holder_x0 + f*h_len, yc+dy, -1])
                linear_extrude(11)
                    hull(){
                        translate([-(tie_len-tie_w)/2, 0]) circle(d=tie_w, $fn=36);
                        translate([ (tie_len-tie_w)/2, 0]) circle(d=tie_w, $fn=36);
                    }

module grip_step()
    translate([x_end-grip_len, grip_marg, plate_t-0.01])
        cube([grip_len, plate_w-2*grip_marg, grip_h+0.01]);

// passagem de cabo: corta a asa de cima a baixo e entra cable_into na placa,
// com o fundo arredondado para o fio nao ser cortado na borda
module cable_slot2d(xc, right){
    cy = right ? plate_w-(cable_into-cable_w/2) : (cable_into-cable_w/2);
    hull(){
        translate([xc, cy]) circle(d=cable_w, $fn=48);
        translate([xc, right ? plate_w+12 : -12]) circle(d=cable_w, $fn=48);
    }
}
module cable_slots()
    translate([0,0,-2]) linear_extrude(48){
        cable_slot2d(cab_L_x, false);
        cable_slot2d(cab_R_x, true);
    }

// ============================ SLED ===================================
translate([-x_start,0,0])
difference(){
union(){
    difference(){
        union(){
            // placa (com o recorte do holder) ...
            difference(){
                union(){
                    import(PLATE, convexity=10);
                    plate_ext_left();
                    plate_ext_right();
                    disc_solid();
                }
                holder_pocket();
            }
            // ... e as asas por cima: o filete funde com a parede do holder
            wings();
            grip_step();
        }
        sma_cuts();
        sma_relief();
        cable_slots();
        tie_holes();
        reopen_holes();
    }
    holder();
}
    tie_bat_holes();
}
