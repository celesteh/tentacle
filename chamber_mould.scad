module closed_chamber(w=22, r=20, sidewall=1,topwall=2) {
           translate([0,0, topwall]) rotate([-90,0,0])
            union(){
            difference() {
                difference(){
                    cylinder(h=w, r=r, center=false);
                    translate([0,0, sidewall]) cylinder(h=(w-(sidewall*2)), r=(r-topwall), center=false);
                }
                translate([(-1 *r),0,(-1 * w)+1])cube([r*2, r*2, w*2]);
            }
            translate([(-1 * r),0,0])
            difference(){
                cube([(2 * r),topwall,w]);
                translate([topwall,-1,sidewall])cube([((r * 2) - (topwall * 2)),(topwall *2),(w - (sidewall * 2))]);
            }
        };
    };
    
module chamber(w=22, r=20, sidewall=1,topwall=2, air_channel=2) {
    difference(){
        closed_chamber(w,r,sidewall,topwall);
         translate([0,sidewall,0])
        rotate([90,0,0])
        cylinder(h=(sidewall*4), r=air_channel, center=true);
    };
};

module base(w=22, r=20, sidewall=1,topwall=2, air_channel=2, extension=3) {
    //air_channel=(extension /2);
    difference() {
        union(){
            closed_chamber(w,r,sidewall,topwall);
            translate([(-1 * r),w,0]) 
            cube([(r*2), extension, extension]);
        };
        translate([0,w,0])        
        rotate([90,0,0])
        cylinder(h=((sidewall+extension)*2), r=air_channel, center=true);
    }
};

module section(w=22, r=20, sidewall=1,topwall=2, air_channel=2, extension=3) {
 
     difference(){
        base(w,r,sidewall,topwall, air_channel, extension);
         translate([0,sidewall,0])
        rotate([90,0,0])
        cylinder(h=(sidewall*4), r=air_channel, center=true);
     }
}

module start () {}
module middle () {}
module end() {}
module complete() {}

module tentacle(w=22, r=20, sidewall=1,topwall=2, air_channel=2, extension=3, length=47,
    bedsize=223){

    safesize = bedsize-10;
    section_size = w+extension;
    per_print = floor(bedsize/ section_size);
    num = round(length / section_size);
        
        
}

section();