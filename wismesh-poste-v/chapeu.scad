// =====================================================================
//  Chapeu da face superior  —  WisMesh no poste · Manaus
//
//  Sombreia a face de cima da caixa, que e' a que mais absorve de todas:
//  a 3 graus do equador o sol passa a pino e uma face horizontal recebe
//  2,3x mais por metro quadrado que qualquer parede.
//
//      face de cima exposta .......... 3,46 W no pico
//      sob chapeu CLARO, 15 mm ....... 0,23 W     <- 15x menos
//      sob chapeu PRETO .............. 1,15 W
//
//  IMPRIMA EM BRANCO OU CINZA CLARO. Preto absorve 11 W, chega a 67 C e
//  devolve cinco vezes mais radiacao para a caixa.
//
//  A chapa de aluminio NAO pode fazer este servico: ela ficaria em volta
//  da base da antena. Plastico e' transparente para RF e pode.
//
//  O furo central deixa a antena passar; o colar em volta e' represa,
//  para a agua que cai no chapeu nao escorrer por ele ate' o bulkhead.
//
//  Cola com PU nos 4 pes, sobre a face de cima da caixa.
//
//    openscad -o chapeu.stl chapeu.scad
// =====================================================================

// face de cima da caixa: 110 (x) x 60 (y), com a caixa EM PE
top_x    = 110.0;
top_y    =  60.0;
bei_x    =  15.0;   // transbordo lateral -> e' por onde o ar quente sai
bei_tras =  15.0;   // transbordo atras (lado do poste)
bei_fre  =   3.0;   // transbordo NA FRENTE: so' 3 mm, de proposito.
                    // O chapeu fica 15 mm acima da face de cima e o painel
                    // comeca logo a frente, 7,8 mm abaixo. Cada milimetro de
                    // beiral frontal projeta ~1,3 mm de sombra sobre o painel
                    // em sol de 40 graus — e painel sem diodo de bypass perde
                    // de 30 a 70% com uma celula sombreada.

lam_t    =   3.0;   // espessura do teto
folga    =  15.0;   // altura livre sobre a caixa: e' a chamine

pe_d     =  10.0;   // pes de colagem
pe_pos   = [45.0, 22.0];   // (+-x, +-y) medidos do centro da FACE DE CIMA,
                           // para os pes assentarem sobre ela
gr_w     =   0.9;   // ranhura de colagem (mesma razao do wismesh-foot:
gr_d     =   0.9;   // 0,9 da ~39% de contato e 46% de ranhura)

ant_y    =  12.0;   // posicao da antena, medida do fundo da face de cima
                    // (o mais perto possivel do poste: o bulkhead pede
                    //  ~12 mm de borda)
ant_d    =  15.0;   // passagem da antena (corpo Ø13)
col_h    =   5.0;   // saia em volta do furo, virada para BAIXO: guia a agua
                    // que passar pelo furo para longe da base do conector,
                    // e e' o que permite imprimir o chapeu DE CABECA PARA
                    // BAIXO (teto no leito) sem nenhum suporte
print_ready = true;
col_t    =   2.5;

$fn = 64;

// =====================================================================
cx = top_x + 2*bei_x;              // 140
cy = top_y + bei_tras + bei_fre;   //  78
off_y = (bei_tras - bei_fre)/2;    // o teto desloca para tras
pe_x = pe_pos[0]; pe_y = pe_pos[1];

echo(str("chapeu ",cx," x ",cy," x ",lam_t,"  a ",folga," mm da face de cima"));
echo(str("beiral: ",bei_x," nas laterais, ",bei_tras," atras, ",bei_fre," na frente"));
echo(str("pes Ø",pe_d," em (+-",pe_x,", +-",pe_y,")"));
echo(str("antena a ",ant_y," mm da borda de tras da face de cima"));
echo(str("altura total ",folga+lam_t+col_h));

module pe(){
    difference(){
        cylinder(h=folga+0.01, d=pe_d);
        // ranhura concentrica na face de colagem
        translate([0,0,-0.01]) difference(){
            cylinder(h=gr_d+0.01, d=pe_d-2*1.8);
            translate([0,0,-0.1]) cylinder(h=gr_d+0.3, d=pe_d-2*1.8-2*gr_w);
        }
    }
}

ay = -top_y/2 + ant_y;

module chapeu() difference(){
    union(){
        // teto
        translate([0,-off_y,folga]) linear_extrude(lam_t)
            offset(r=6) offset(delta=-6) square([cx,cy], center=true);
        // pes
        for(px=[-pe_x,pe_x], py=[-pe_y,pe_y]) translate([px,py,0]) pe();
        // saia, para baixo, dentro do vao de ar
        translate([0,ay,folga-col_h]) cylinder(h=lam_t+col_h, d=ant_d+2*col_t);
    }
    translate([0,ay,folga-col_h-1]) cylinder(h=lam_t+col_h+2, d=ant_d);
}

if(print_ready) translate([0,0,folga+lam_t]) rotate([180,0,0]) chapeu(); else chapeu();
