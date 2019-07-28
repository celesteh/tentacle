module closed_chamber_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, overhang=1) {
	translate([0,0, topwall+1]){

    union(){
        rotate([-90,0,0])
        difference(){ // grooves
            union(){
                difference() { //bottom
                    union(){ // main cavity
                        cylinder(h=w, r=r, center=false);
                        translate([0,0, sidewall]) cylinder(h=(w-(sidewall*2)), r=(r-topwall), center=false);
                    }
                    translate([(-1 *r),0,(-1 * w)+1])cube([r*2, r*2, w*2]);
                }
                translate([(-1 * r),0,0])
                union(){
                //bottom
                    cube([(2 * r),topwall+2,w]);
				//translate([topwall,-1,sidewall])cube([((r * 2) - (topwall * 2)),(topwall *2),(w - (sidewall * 2))]);
                }
            };
		
            union(){ // grooves
                for (deg=[-40:10:40]) {
                    rotate ([0,0,deg])
                    translate([0,-1*(r),-2])
                    //rotate([-90,0,0])
                    cylinder(h=w+5,d=(topwall/3));
                };
            };
        };
        // air channels for casting
        angle = 25;
        side_offset = r * 5/8;
        //pos side
        translate([side_offset, w-(topwall/1.8), sqrt((r*r) - (side_offset * side_offset))-topwall])
        rotate([angle*-1,angle,0])
        cylinder(h=topwall*1.5, r=0.75);
        translate([side_offset+(tan(angle) * topwall)+1, w-2, sqrt((r*r) - (side_offset * side_offset))+(topwall/2)])
        rotate([-90,0,angle*-1.5])
        cylinder(h=(w),r=air_channel);
        // neg side
        
        translate([side_offset*-1, w-(topwall/1.8), sqrt((r*r) - (side_offset * side_offset))-topwall])
        rotate([angle*-1,angle * -1,0])
        cylinder(h=topwall*1.5, r=0.75);
        translate([(side_offset+(tan(angle) * topwall)+1) *-1, w-2, sqrt((r*r) - (side_offset * side_offset))+(topwall/2)])
        rotate([-90,0,angle*1.5])
        cylinder(h=(w),r=air_channel);
        
    };
	
};
        
        
}
module closed_chamber_void(w=22, r=20, sidewall=1,topwall=2.1,overhang=1) {
    
    difference(){
	translate([0,0, topwall+1]){

    rotate([-90,0,0])
		union(){
			//difference() { //bottom
				union(){ // main cavity
					//cylinder(h=w, r=r, center=false);
					translate([0,0, sidewall]) 
                    cylinder(h=(w-(sidewall*2)), r=(r-topwall), center=false);//curve
                    translate([topwall-r,-1,sidewall])
                    cube([((r * 2) - (topwall * 2)),((topwall+1) *2),(w - (sidewall * 2))]);//box
				}
                translate([(r * -1)-0.5,(topwall +1),/*sidewall*/-0.5])cube([(r * 2)+1,((topwall+1) *2),w+1]); // overhang
			}
			//translate([(-1 * r),0,0])
			//union(){
                //bottom
                //cube([(2 * r),topwall,w]);
				//translate([topwall,-1,sidewall])cube([((r * 2) - (topwall * 2)),(topwall *2),(w - (sidewall * 2))]);
			//}
		};
        union() {
            // bottom cutoff
            translate([(-1 *r)-1,-1,(-1 * w)-r-topwall-2])
            cube([(r*2)+5, (r*2)+5, w*2]);
            
            
            /*
            Chambers on the other piece:
            // positive
            translate([(r-((sidewall-1)*2)), w+extension,topwall])
            rotate([90,0,0])
            cylinder(h=w,r=(sidewall+1), center=false);
            // negative
            translate([(r * -1) + (sidewall-1)*2, w+extension,topwall])
            rotate([90,0,0])
            cylinder(h=w,r=(sidewall+1), center=false);
            */
            
            
            // flow channels for silicon
            //if(overhang ==1) { // use cylindrical channels
                /*
                translate([(r-sidewall-((topwall))), w,topwall])
                rotate([90,0,0])
                cylinder(h=w,r=(topwall+1), center=false);
                translate([(r * -1) + sidewall+ topwall, w,topwall])
                rotate([90,0,0])
                cylinder(h=w,r=(topwall+1), center=false);
                */
                // positive
                translate([(r-((sidewall-1)*1.5)), w,(sidewall/2)+0.5])
                rotate([90,0,0])
                cylinder(h=w,r=(sidewall+1)/2, center=false);
                // negative
                translate([(r * -1) + (sidewall-1)*1.5, w,(sidewall/2)+0.5])
                rotate([90,0,0])
                cylinder(h=w,r=(sidewall+1)/2, center=false);

            //} else { // square off half cylinder protrusions
            if (overhang != 1) {
                /*
                translate([(r-sidewall-((topwall*2))), 0,topwall])
                cube([(topwall+1) *2, w, r]);
                translate([((r*-1)+sidewall-(topwall * 0.8)), 0,topwall])
                cube([(topwall+1) *2, w, r]);
                */
                // positive
                //translate([(r-((sidewall-1)*2)), w,topwall])
                //rotate([90,0,0])
                //cylinder(h=w,r=(sidewall+1), center=false);
                //translate([(r-((topwall+1)*2)), 0,topwall])
                translate([(r-((sidewall+1)*1.25)), 0,(sidewall/2)+0.5])
                cube([(sidewall+1), w, r]);
                // negative
                //translate([(r * -1) + (sidewall-1)*2, w,topwall])
                //rotate([90,0,0])
                //cylinder(h=w,r=(sidewall+1), center=false);
                //translate([((r*-1)), 0,topwall])
                translate([(r * -1) + (sidewall-1)*0.5, 0,(sidewall/2)+0.5])
                cube([(sidewall+1), w, r]);


            }
        }
	};
};

module closed_chamber(w=22, r=20, sidewall=1,topwall=2.1,air_channel = 2, overhang=1){
    difference(){
        closed_chamber_top(w,r,sidewall,topwall,air_channel, overhang);
        closed_chamber_void(w,r,sidewall,topwall,overhang);
    }
}
/*
module closed_chamber(w=22, r=20, sidewall=1,topwall=2.1) {
	translate([0,0, topwall]) rotate([-90,0,0])
	difference(){
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
		
		union(){
			for (deg=[-40:10:40]) {
				rotate ([0,0,deg])
				translate([0,-1*(r),-2])
				//rotate([-90,0,0])
				cylinder(h=w+5,d=(topwall/3));
			};
		};
	};
	//translate([r-topwall,0,-1])
	//cube([1,w,1]);
	//translate([(-1 *r)+topwall,0,-1])
	//cube([1,w,1]);
	
};
*/

// input, no output
module chamber_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2,overhang=1){   
    	union(){
		closed_chamber_top(w,r,sidewall,topwall, air_channel, overhang);
		translate([(air_channel/-2),-1,-1])
		//rotate([90,0,0])
		//cylinder(h=(sidewall*4), r=air_channel, center=true);
            cube([(air_channel), (sidewall *4), (air_channel+2)]);
        }
}
module chamber_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2,overhang=1) {
        	
    intersection(){
                
        union() {
		closed_chamber_void(w,r,sidewall,topwall,overhang);
		translate([(air_channel/-2),-2,-2])
		//rotate([90,0,0])
		//cylinder(h=(sidewall*4), r=air_channel, center=true);
            cube([(air_channel), (sidewall *4), (air_channel+3)]);
            }
        
        chamber_top(w,r,sidewall,topwall,air_channel,overhang);
        }
    }
    
module chamber(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2,overhang=1){
    difference(){
        chamber_top(w,r,sidewall,topwall,air_channel,overhang);
        chamber_void(w,r,sidewall,topwall,air_channel,overhang);
    }
}

/*
module chamber(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2) {
	difference(){
		closed_chamber(w,r,sidewall,topwall);
		translate([0,sidewall,0])
		rotate([90,0,0])
		cylinder(h=(sidewall*4), r=air_channel, center=true);
	};
};
*/
module end_cap_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
 	difference(){
		union() {
			chamber_top(w,r,sidewall,topwall, air_channel,overhang);
			translate([0,w+extension,topwall+1])
			rotate([90,0,0])
			cylinder(h=extension, r=r, center=false);
			translate([(-1 * r), w, 0])
			cube([(r*2), extension, topwall+1]);
		};
		translate([(-1 * r),0,(-2 *r)])
		cube([(r*2),(r*2),(r*2)]);
	}
   
    
    
}
module end_cap_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
    intersection(){
        chamber_void(w,r,sidewall,topwall,air_channel,overhang);
        end_cap_top(w,r,sidewall,topwall,air_channel, extension,overhang);
    }
    
}

module end_cap(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
    difference(){
        end_cap_top(w,r,sidewall,topwall,air_channel,overhang);
        end_cap_void(w,r,sidewall,topwall,air_channel,overhang);
    }
}

/*
module end_cap (w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	difference(){
		union() {
			chamber(w,r,sidewall,topwall, air_channel);
			translate([0,w+extension,topwall])
			rotate([90,0,0])
			cylinder(h=extension, r=r, center=false);
			translate([(-1 * r), w, 0])
			cube([(r*2), extension, topwall]);
		};
		translate([(-1 * r),0,(-2 *r)])
		cube([(r*2),(r*2),(r*2)]);
	}
}
*/
// no input, output
module base_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	//air_channel=(extension /2);
	//difference() {
		union(){
			closed_chamber_top(w,r,sidewall,topwall,air_channel, overhang);
			difference(){
				union(){
					//translate([0,0,topwall])
					//rotate([90,0,0])
					//cylinder(h=extension, r=r);
					//translate([(-1 * r), (-1 * extension), 0])
					//cube([(r*2), extension, topwall]);
				};
				//translate([(-1 *r),(-1 *r),(-2 *r)])
				//cube([(r*2),(r*2),(r*2)]);
			}
			translate([(-1 * r),w,-1]) 
            cube([(r*2), extension, extension+2]);
			//cube([(r*2), extension, extension+1]);
            
            // channels
            translate([0, w+extension, topwall+(air_channel/2)])
            rotate([90,0,0])
            cylinder(h=w,r=(topwall+air_channel), center=false);
            // positive
            translate([(r-((sidewall-1)*2)), w+extension,topwall*1.6])
            rotate([90,0,0])
            cylinder(h=w,r=(sidewall+1), center=false);
            // negative
            translate([(r * -1) + (sidewall-1)*2, w+extension,topwall*1.6])
            rotate([90,0,0])
            cylinder(h=w,r=(sidewall+1), center=false);

		};
		//translate([0,w,0])        
		//rotate([90,0,0])
		//cylinder(h=((sidewall+extension)*2), r=air_channel, center=true);
	//}
};
module base_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
    
    intersection(){
    union() {
    closed_chamber_void(w,r,sidewall,topwall,overhang);
  	translate([(air_channel/-2),w-sidewall,0])        
	//rotate([90,0,0])
    cube([(air_channel), ((sidewall+extension) +1/* *2 */), (air_channel+1)]);
    }
    base_top(w,r,sidewall,topwall,air_channel,extension,overhang);
}
}

module base(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
    difference(){
        base_top(w,r,sidewall,topwall,air_channel,extension,overhang);
        base_void(w,r,sidewall,topwall,air_channel,extension,overhang);
    }
}



module start_cap_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	
	union(){
		base_top(w,r,sidewall,topwall,air_channel, extension,overhang);
		difference(){
			union(){
				translate([0,0,topwall+1])
				rotate([90,0,0])
				cylinder(h=extension, r=r);
				translate([(-1 * r), (-1 * extension), 0])
				cube([(r*2), extension, topwall+1]);
			};
			translate([(-1 *r),(-1 *r),(-2 *r)])
			cube([(r*2),(r*2),(r*2)]);
			
		}  
		
	}
}
module start_cap_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
    intersection(){
        base_void(w,r,sidewall,topwall,air_channel, extension,overhang);
        start_cap_top(w,r,sidewall,topwall,air_channel, extension,overhang);
    }
}
module start_cap(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
    
    difference(){
        start_cap_top(w,r,sidewall,topwall,air_channel, extension,overhang);
        start_cap_void(w,r,sidewall,topwall,air_channel, extension,overhang);
    }
}
/*
module start_cap(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	
	union(){
		base(w,r,sidewall,topwall,air_channel, extension);
		difference(){
			union(){
				translate([0,0,topwall])
				rotate([90,0,0])
				cylinder(h=extension, r=r);
				translate([(-1 * r), (-1 * extension), 0])
				cube([(r*2), extension, topwall]);
			};
			translate([(-1 *r),(-1 *r),(-2 *r)])
			cube([(r*2),(r*2),(r*2)]);
			
		}  
		
	}
}
*/
module section_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
    
    base_top(w,r,sidewall,topwall, air_channel, extension,overhang);

    
    }
module section_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
    
    intersection() {
        union(){
     base_void(w,r,sidewall,topwall, air_channel, extension,overhang);
		translate([(air_channel/-2),-2,-2])
		//rotate([90,0,0])
		//cylinder(h=(sidewall*4), r=air_channel, center=true);
            cube([(air_channel), (sidewall *4/*4*/), (air_channel+3)]);
        }
        section_top(w,r,sidewall,topwall, air_channel, extension,overhang);
    }
    
    
}

module section(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
    
    difference(){
        section_top(w,r,sidewall,topwall, air_channel, extension,overhang);
        section_void(w,r,sidewall,topwall, air_channel, extension,overhang);
    }
}
    
/*
module section(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	
	difference(){
		base(w,r,sidewall,topwall, air_channel, extension);
		translate([0,sidewall,0])
		rotate([90,0,0])
		cylinder(h=(sidewall*4), r=air_channel, center=true);
	};
	//translate([r-topwall,w,-1])
	//cube([1,extension,1]);
	//translate([(-1 *r)+topwall,w,-1])
	//cube([1,extension,1]);
}
*/

module attachment_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	
	section_top(w, r, sidewall,topwall, air_channel, extension,overhang);
	
	difference() {
		
		translate([0,w+extension,2])
		rotate([-90,0,0])
		cylinder(h=extension, r=r, center=false);
		
		union() {
			translate([r, w+extension-1/*-2*/,(r* -2)-1])// was +2, now -1
			rotate([0,0, 90])
            cube([extension+2, r*2, r*2]);
			
			translate([r, w+extension-2,/*2+(r/3)*/(topwall+air_channel)*2])
			rotate([0,0, 90])
			cube([extension+3, r*2, r*2]);
			
		}
	} 
	}
module attachment_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	
    intersection(){
        union() {
            section_void(w, r, sidewall,topwall, air_channel, extension,overhang);
            translate([(air_channel/-2),w+extension, 0])
                cube([(air_channel), (extension+1), (air_channel+1)]);
            }

        attachment_top(w, r, sidewall,topwall, air_channel, extension,overhang);
    }
}
/*
module attachment
(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	
	section(w, r, sidewall,topwall=2.1, air_channel, extension);
	
	difference() {
		
		translate([0,w+extension-1,2])
		rotate([-90,0,0])
		cylinder(h=1, r=r, center=false);
		
		union() {
			translate([r, w+extension-2,(r* -2)+2])
			rotate([0,0, 90])
			cube([3, r*2, r*2]);
			
			translate([r, w+extension-2,2+(r/3)])
			rotate([0,0, 90])
			cube([3, r*2, r*2]);
			
		}
	} 
	
}
*/
module attachment
(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
    difference(){
        attachment_top(w, r, sidewall,topwall, air_channel, extension,overhang);
        attachment_void(w, r, sidewall,topwall, air_channel, extension,overhang);
    }
}

module start_top(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	mid = num -2;
	
	union(){
		start_cap_top(w, r, sidewall,topwall, air_channel, extension,overhang);
		for (index=[0:1:mid]){
			translate([0, (index+1) * (w+extension),0])
			section_top(w, r, sidewall,topwall, air_channel, extension,overhang);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment_top(w, r, sidewall,topwall, air_channel, extension,overhang);
	}
}
module start_void(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	mid = num -2;
	
    //intersection(){
	union(){
		start_cap_void(w, r, sidewall,topwall, air_channel, extension,overhang);
		for (index=[0:1:mid]){
			translate([0, (index+1) * (w+extension),0])
			section_void(w, r, sidewall,topwall, air_channel, extension,overhang);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment_void(w, r, sidewall,topwall, air_channel, extension,overhang);
	}
    //start_top(num, w, r, sidewall,topwall, air_channel, extension);
//}
}
/*
module start(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    
    difference(){
        start_top(num,w, r, sidewall,topwall, air_channel, extension);
        start_void(num,w, r, sidewall,topwall, air_channel, extension);
    }
}
*/
/*
module start (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -2;
	
	union(){
		start_cap(w, r, sidewall,topwall, air_channel, extension);
		for (index=[0:1:mid]){
			translate([0, (index+1) * (w+extension),0])
			section(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment(w, r, sidewall,topwall, air_channel, extension);
	}
}
*/

module middle_top(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	mid = num -1;
	
	union(){
		for (index=[0:1:mid]){
			translate([0, (index) * (w+extension),0])
			section_top(w, r, sidewall,topwall, air_channel, extension,overhang);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment_top(w, r, sidewall,topwall, air_channel, extension,overhang);
	}
}
module middle_void(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	mid = num -1;
	//intersection() {
	union(){
		for (index=[0:1:mid]){
			translate([0, (index) * (w+extension),0])
			section_void(w, r, sidewall,topwall, air_channel, extension,overhang);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment_void(w, r, sidewall,topwall, air_channel, extension,overhang);
	}
    //middle_top(num, w, r, sidewall,topwall, air_channel, extension);
//}
}
/*
module middle(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    
    difference(){
        middle_top(num,w, r, sidewall,topwall, air_channel, extension);
        middle_void(num,w, r, sidewall,topwall, air_channel, extension);
    }
}
*/
/*
module middle (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -1;
	
	union(){
		for (index=[0:1:mid]){
			translate([0, (index) * (w+extension),0])
			section(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment(w, r, sidewall,topwall, air_channel, extension);
	}
}
*/

module end_top(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	mid = num -1;
	
	union(){
		for (index=[0:1:mid]){
			translate([0, (index) * (w+extension),0])
			section_top(w, r, sidewall,topwall, air_channel, extension,overhang);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap_top(w, r, sidewall,topwall, air_channel, extension,overhang);
	}
}
module end_void(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	mid = num -1;
	
    if (num > 1) {
	union(){
		for (index=[0:1:(mid-1)]){
			translate([0, (index) * (w+extension),0])
			section_void(w, r, sidewall,topwall, air_channel, extension,overhang);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap_void(w, r, sidewall,topwall, air_channel, extension,overhang);
	}
} else {
    translate ([0, (w * -1) + extension, 0])
    end_cap_void(w, r, sidewall,topwall, air_channel, extension,overhang);
}
}
/*
module end(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    
    difference(){
        end_top(num,w, r, sidewall,topwall, air_channel, extension);
        end_void(num,w, r, sidewall,topwall, air_channel, extension);
    }
}
*/
/*
module end(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -1;
	
	union(){
		for (index=[0:1:mid]){
			translate([0, (index) * (w+extension),0])
			section(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap(w, r, sidewall,topwall, air_channel, extension);
	}
}
*/

module complete_top(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	mid = num -2;
	
	union(){
		start_cap_top(w, r, sidewall,topwall, air_channel, extension,overhang);
		for (index=[0:1:mid]){
			translate([0, (index+1) * (w+extension),0])
			section_top(w, r, sidewall,topwall, air_channel, extension,overhang);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap_top(w, r, sidewall,topwall, air_channel, extension,overhang);
	}
}
module complete_void(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3,overhang=1) {
	mid = num -2;
	
	union(){
		start_cap_void(w, r, sidewall,topwall, air_channel, extension,overhang);
		for (index=[0:1:(mid-1)]){
			translate([0, (index+1) * (w+extension),0])
			section_void(w, r, sidewall,topwall, air_channel, extension,overhang);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap_void(w, r, sidewall,topwall, air_channel, extension,overhang);
	}
}
/*
module complete(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    
    difference(){
        complete_top(num,w, r, sidewall,topwall, air_channel, extension);
        complete_void(num,w, r, sidewall,topwall, air_channel, extension);
    }
}
*/
/*
module complete(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -2;
	
	union(){
		start_cap(w, r, sidewall,topwall, air_channel, extension);
		for (index=[0:1:mid]){
			translate([0, (index+1) * (w+extension),0])
			section(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap(w, r, sidewall,topwall, air_channel, extension);
	}
}
*/

function inner_length (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) =((w+extension) * num) + (extension * 2);
function length(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = inner_length(num,w,r,sidewall,topwall,air_channel,extension,padding)+ (padding * 2);
   

function inner_height(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = r + (topwall * 1.5) +1;

function height (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = inner_height (num,w,r,sidewall,topwall,air_channel,extension,padding) + padding;

function inner_width (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = r * 2;

function width (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = inner_width (num,w,r,sidewall,topwall,air_channel,extension,padding) + (padding*2);

function y_origin (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = (padding + extension) *-1;

function volume (l=1, r=1) = ((l * PI * r * r) /2) / 1000.0;

function silicon_total(l=1, r=1, sg =1.1) = volume(l, r) * sg;


module mould_case_block(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) {
    
    w = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    h = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    y = y_origin(num,w,r,sidewall,topwall,air_channel,extension,padding);
    
    translate([w/-2, y, 0])
    cube([w,l,h]);
    
}

module top_mould_case (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,overhang=1) {
    
    //mould_case_block(num,w,r,sidewall,topwall,air_channel,extension,padding);
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    h = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
    //function inner_length (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5)
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    y = y_origin(num,w,r,sidewall,topwall,air_channel,extension,padding);
    wide_funnel_end = (extension/2)+(air_channel/2);
    depth = extension + padding;//(extension * 2) + padding + 7;

    //translate([(r/4)+1, y, (padding+ (air_channel/2))]);
        union() {
        difference() {
            difference(){
                translate([wi/-2, y, 0])
                    cube([wi,l,h]);
                translate([wi/-2, y, (padding *-1)])
                    cube([wi,l,padding]);
                //funnels
                //translate([(r/4)+1,l+y-padding-1,(air_channel/2)+(padding+extension)])
                //])
                f_height = rim + (extension+(air_channel/2) / 2) +1; // (air_channel/2)+(padding+extension)
                translate([(r* (5/8))+sidewall,l+y-padding-1,f_height])
                    rotate([-90,0,0])
                union() {
                    cylinder(h=padding+2, r1=air_channel, r2=wide_funnel_end, center=false);
                    translate([0,0,(depth * -1)])
                    cylinder(h= depth, r= air_channel);
                }
                translate([(r * (-5/8))-sidewall,l+y-padding-1,f_height])
                    rotate([-90,0,0])
                union() {
                cylinder(h=padding+2, r1=air_channel, r2=wide_funnel_end, center=false);
                    translate([0,0,(depth * -1)])
                    cylinder(h= depth, r= air_channel);
                }
                
                // longer funnel ends
                
            }
            // subtract out the other half
            bottom_mould_case(num, w-0.2, r-0.2, sidewall,topwall, air_channel, extension-0.001, padding, rim+0.2);
        }
                // ears
        rm = rim + rim + 1;
        translate([((wi/-2) - (padding*2)), y-rim, rm])
        cube([(padding * 4)+wi, padding, h-rm]);
        //translate([(wi/-2)+(padding*-4), y-rim, rm])
        //cube([(padding * 4), padding+rim, h-rm]);
        
        //handles
        handle_l = padding * 4;
        translate([wi/2, y+l-handle_l, h-padding])
        cube([ (padding*2), handle_l, padding]);
        translate([(wi/-2)-(padding*2), y+l-handle_l, h-padding])
        cube([(padding*2),handle_l,  padding]);
    }

}

module bottom_mould_case (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,overhang=1) {
    
    //mould_case_block(num,w,r,sidewall,topwall,air_channel,extension,padding);
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    h = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
    //function inner_length (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5)
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    y = y_origin(num,w,r,sidewall,topwall,air_channel,extension,padding);
    
    //rimm = rim+0.2;
    
    wid = wi+(rim*2);
    le = l + (rim*2);
    
    z = padding*-1;
    
    //echo(wid);
    union() {
    translate([wid/-2, y-(rim/2), z]){
        cube([wid,le,padding]);
        translate([0,0,padding]){
            difference(){
                cube([wid,le,rim]);
                translate([rim,rim,0])
                cube([wi,l,rim+1]);
            }
        }
    
            //handles
        handle_l = padding * 4;
        translate([wid, le-handle_l,0])
        cube([ (padding*2), handle_l, padding]);
        translate([padding*-2, le-handle_l, 0])
        cube([(padding*2),handle_l,  padding]);
    
        //ears
        translate([wid, 0, 0])
        cube([(padding * 4), padding+rim, padding]);
        translate([(padding*-4), 0, 0])
        cube([(padding * 4), padding+rim, padding]);
    }
    }
}

module flat(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,h=4) {
    
    //mould_case_block(num,w,r,sidewall,topwall,air_channel,extension,padding);
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    iw = inner_width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    il = inner_length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    
    difference(){
        cube([wi,l,padding+h]);
        translate([padding,padding,padding])
        cube([iw,il,h+1]);
    }
    
}


module complete(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,h=4,top=0, overhang=1){
 
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    hi = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
   
    
    union() {
        if (top == -1) {
        flat(num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);
        }
        if (top ==1) {
        translate([(wi*1),padding, hi])
            rotate([0,180,0])
                difference(){
                    top_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim);
                    complete_top(num,w,r,sidewall,topwall, air_channel, extension,overhang);
                }
            }
            if (top==0) {
        translate([(wi * 2.5),l,padding])
            rotate([0,0,180]) 
            union() {
                bottom_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim);
                complete_void(num,w,r,sidewall,topwall, air_channel, extension,overhang);
            }
        }
}
}

module start(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,h=4, top=1,overhang=1){
 
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    hi = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
   
    echo ("This is a cylinder with l=", l, " and r=", r);
    vol = ((l * PI * r * r) /2) / 1000.0;
    echo ("Volume: ", vol,"cm^3");
    echo ("Silicon mass: ", vol * 1.1, "g (Each part", (vol * 1.1) /2, "g)");
    
    translate([padding* -6,0,0])
    union() {
        if (top == -1)
            flat(num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);
        if(top ==1) {
        translate([(wi),0, hi])
            rotate([0,180,0])
                difference(){
                    top_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim,overhang);
                    start_top(num,w,r,sidewall,topwall, air_channel, extension,overhang);
                }
            } 
            if (top==0) {
        translate([(wi* 1.5),l-(padding*2),padding]) // lone piece
        //translate([(wi * 2.5),l,padding])
                
        //translate([(wi * 2.2),l-(padding*2),padding])
            rotate([0,0,180]) 
            union() {
                bottom_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim,overhang);
                start_void(num,w,r,sidewall,topwall, air_channel, extension,overhang);
            }
                
            }
        }
}

module middle(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,h=4,top=1,overhang=1){
 
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    hi = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
   
    translate([padding* -6,0,0])
    union() {
               if (top == -1)
            flat(num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);

          if (top == 1) {
      
        //flat(num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);
        translate([(wi),0, hi])
            rotate([0,180,0])
                difference(){
                    top_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim,overhang);
                    middle_top(num,w,r,sidewall,topwall, air_channel, extension,overhang);
                }
            }
                    if (top == 0) {

        //translate([(wi * 2.5),l,padding])
        translate([(wi * 2.2),l-(padding*2),padding])
            rotate([0,0,180]) 
            union() {
                bottom_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim,overhang);
                middle_void(num,w,r,sidewall,topwall, air_channel, extension,overhang);
            }
        }
    }
        echo("middle");
}

module end(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,h=4,top=1,overhang=1){
 
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    hi = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
   
    translate([padding* -6,0,0])
    union() {
 
        if (top == -1)
            flat(num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);

        
        if (top ==1 ) {
        //flat(num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);
        translate([(wi*1),0, hi])
            rotate([0,180,0])
                difference(){
                    top_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim,overhang);
                    end_top(num,w,r,sidewall,topwall, air_channel, extension,overhang);
                }
            }
            if (top == 0) {
        //translate([(wi * 2.5),l,padding])
        translate([(wi * 2.2),l-(padding*2),padding])
            rotate([0,0,180]) 
            union() {
                bottom_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim,overhang);
                end_void(num,w,r,sidewall,topwall, air_channel, extension,overhang);
                //middle_void(num,w,r,sidewall,topwall, air_channel, extension,overhang);
            }
        }
    }
}


/*
module assemble(top,void,flat,top_case,bottom_case, wi,l) {
    
    union() {
        
        flat;
        translate([(wi),0,0])
            rotate([0,180,0])
                difference(){
                    top_case;
                    top;
                }
        
        translate([(wi * 4),0,0]) 
            union() {
                bottom_case;
                bottom;
            }
        }
}
 */       
        
        
    

module tentacle(section=0, w=25, r=30, sidewall=2,topwall=3.1, air_channel=3, extension=4, padding=3, rim=2, h=4, length=500,
	bedsize=200, top=1, overhang=0){
	
	safesize = (bedsize-(padding*6))-12;
	section_size = w+extension;
	per_print = floor(safesize/ section_size) -1;
	num = round(length / section_size);
        
    //intersection(){
    translate([0,((padding*2)+rim), 0])    
    difference() {

        
        if (num <= per_print) {
            complete (num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h,top, overhang);
        } else {
            
            if (section ==0) {
                start(per_print,w,r,sidewall,topwall, air_channel, extension, padding, rim,h,top,overhang);
            } else {
                if ((((section +1) * per_print) >
                    num)|| (section>1)) {
                        //module end(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,h=4,top=1,overhang=1)
                        sections = max(num%per_print, 2);
                    end(sections,w,r,sidewall,topwall, air_channel, extension, padding, rim,h,top,overhang);
                        //middle(sections,w,r,sidewall,topwall, air_channel, extension, padding, rim,h,top,overhang);
                } else {
                    middle(per_print,w,r,sidewall,topwall, air_channel, extension, padding, rim,h,top,overhang);
                }
            }
        }
    translate([0,0, bedsize * -1])
    cube([bedsize,bedsize,bedsize]);
    }
    //cube([safesize,safesize,safesize]);
//}
}

module calc(section=0, w=22, r = 30, padding=3, rim = 2, h=4, length=500, bedsize=200, top=0, overhang=0) {
    // ratios from from DOI  10.1109/ROBIO.2009.4913047
    
    // section is 0 for start, 1 for middle, 2 for end
    // w is width of sections (so the height of the cylinder)
    // r is the radius of the cylinder
    // padding is the depth of the box walls
    // rim is the widths of the edge which locks the mould halves together
    // h is the depth of the floor of the extruding bump piece
    // length is the length of the whole tentacle
    // bedsize is the size of the 3d printer bed
    // top is 0 for the taller box piece, 1 for the piece with extruding bumps, -1 for the flat floor 
    // the top wall and sidewall both need to compensate for a resin layer if printed in PLA
    
     sidewall= 0.167 * w; echo("sidewall", sidewall);
     topwall= 0.167 * r; echo ("topwall", topwall);

    
    // uncomment the lines below for ABS
    //sw = min(sidewall,topwall);
    //tw = sw;

    // for PLA, this is driven by pooling of the resin coating, which is about 5 mil in the bottom of the mould
    // and probably 1mm of thickness on all pieces without pooling    
    
    sw = min(sidewall,topwall) + 0.2;
    tw = sw + 0.5;
    
    
    // inner height of gap
    extension= 0.25 * r; echo("extension", extension);
    // size of hole
    air_channel=3;//extension * 0.75; echo("air_channel", air_channel);// from existing practice in this project
    
    // make the sections have gemoetrically related dimensions
    w_r = min(w,r);

    tentacle(section,w_r,w_r,sw,tw,air_channel, extension, padding, rim, h, length, bedsize, top, overhang);
    //closed_chamber_top(w, r, sidewall,topwall, air_channel, overhang);
    //attachment_top(w, r, sidewall,topwall, air_channel, extension,overhang);
    //section_top(w, r, sidewall,topwall, air_channel, extension,overhang);
    //base_top(w, r, sidewall,topwall, air_channel, extension,overhang);
    //base_void(w, r, sidewall,topwall, air_channel, extension,overhang);
    //closed_chamber_void(w, r, sw,tw, air_channel, extension,overhang=0);
}
    
    

calc(2, length=470, top=-1, overhang=0);
//calc(0, length=132, top=-1, overhang=0);

//attachment_top();