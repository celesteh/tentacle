union(){
    difference() {
        difference(){
            cylinder(h=20, r=20, center=false);
            translate([0,0, 1]) cylinder(h=18, r=18, center=false);
        }
        translate([-20,0,-19])cube(40,40);
    }
    translate([-20,0,0])
    difference(){
        cube([40,2,20]);
        translate([2,-1,1])cube([36,4,18]);
    }
}