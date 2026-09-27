// Conferencia de montagem — nao e' peca. Usa os STL na posicao MONTADA.
D="/Users/adrianoferreira/Projects/wisblock-sled/wismesh-poste-v/";
$fn=48;
color("#8d949b") translate([0,0,-436]) difference(){
    cylinder(h=430,d=31.7); translate([0,0,-1]) cylinder(h=432,d=28.3); }
color("#2f6fb3"){ import(str(D,"_ber_m0.stl")); import(str(D,"_ber_m1.stl")); }
color("#cfd4d8") translate([-55,34,-110]) cube([110,60,110]);
color("#f2f2ee") translate([0,64,0]) import(str(D,"_cha_m.stl"));
color("#e0922f") for(sx=[-45,45]) translate([sx,0,0]) import(str(D,"_sup_m.stl"));
color("#23262a") translate([0,46,0]) cylinder(h=154,d=13);
color("#6b7075") translate([0,46,-2]) cylinder(h=14,d=9);
translate([0,94,0]) rotate([-15,0,0]){
    color("#aeb8c0") translate([-115,0,-3]) cube([230,185,3]);
    color("#1d3a63") for(sx=[-103,15]) translate([sx,30,0]) cube([88,142,2.5]);
}
