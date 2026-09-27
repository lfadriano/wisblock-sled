// Vista de montagem — conferencia, nao e' peca
D="/Users/adrianoferreira/Projects/wisblock-sled/wismesh-poste/";
cx=110; ch=60; tampa=102.6; ztampa=110+ch;
module bercoA() translate([0,0,110]) rotate([180,0,0]) import(str(D,"berco_poste.stl"));
color("#3d6ea8"){ bercoA(); mirror([0,1,0]) bercoA(); }
color("#9aa4ad") translate([0,0,-250]) difference(){
    cylinder(h=260,d=31.7,$fn=72); translate([0,0,-1]) cylinder(h=262,d=28.3,$fn=72); }
color("#c9cdd1") translate([-cx/2,-cx/2,110]) cube([cx,cx,ch]);          // caixa
color("#dfe3e6") translate([-tampa/2,-tampa/2,ztampa-0.6]) cube([tampa,tampa,0.6]); // tampa
// trilhos: eixo longo em X, afastados 90 em Y, subindo para +X
for(y=[-45,45]) translate([0,y-11,ztampa]) color("#d8a53a") import(str(D,"trilho_cunha.stl"));
// chapa: assenta nas faces de 15 graus (altura do trilho em x=0 -> 29,74)
translate([0,0,ztampa+29.7437]) rotate([0,-15,0]) translate([-82.5,-100,0])
    color("#b9c3cb") cube([165,200,3]);
// antena saindo da tampa, no terco alto (+X)
color("#2b2b2b") translate([32,0,ztampa]) cylinder(h=130,d=6,$fn=24);
