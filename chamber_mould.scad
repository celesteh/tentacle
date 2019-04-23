module closed_chamber_top(w=22, r=20, sidewall=1,topwall=2.1) {
	translate([0,0, topwall+1]){

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
        
        
}
module closed_chamber_void(w=22, r=20, sidewall=1,topwall=2.1) {
    
    difference(){
	translate([0,0, topwall+1]){

    rotate([-90,0,0])
		union(){
			//difference() { //bottom
				union(){ // main cavity
					//cylinder(h=w, r=r, center=false);
					translate([0,0, sidewall]) 
                    cylinder(h=(w-(sidewall*2)), r=(r-topwall), center=false);//curve
                    translate([topwall-r,-1,sidewall])cube([((r * 2) - (topwall * 2)),((topwall+1) *2),(w - (sidewall * 2))]);//box
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
		translate([(-1 *r)-1,-1,(-1 * w)-r-topwall-2])cube([(r*2)+5, (r*2)+5, w*2]);
	};
};

module closed_chamber(w=22, r=20, sidewall=1,topwall=2.1){
    difference(){
        closed_chamber_top(w,r,sidewall,topwall);
        closed_chamber_void(w,r,sidewall,topwall);
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
module chamber_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2){   
    	union(){
		closed_chamber_top(w,r,sidewall,topwall);
		translate([(air_channel/-2),-1,-1])
		//rotate([90,0,0])
		//cylinder(h=(sidewall*4), r=air_channel, center=true);
            cube([(air_channel), (sidewall *4), (air_channel+2)]);
        }
}
module chamber_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2) {
        	
    intersection(){
                
        union() {
		closed_chamber_void(w,r,sidewall,topwall);
		translate([(air_channel/-2),-2,-2])
		//rotate([90,0,0])
		//cylinder(h=(sidewall*4), r=air_channel, center=true);
            cube([(air_channel), (sidewall *4), (air_channel+3)]);
            }
        }
        chamber_top(w,r,sidewall,topwall,air_channel);
    }
    
module chamber(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2){
    difference(){
        chamber_top(w,r,sidewall,topwall,air_channel);
        chamber_void(w,r,sidewall,topwall,air_channel);
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
module end_cap_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
 	difference(){
		union() {
			chamber_top(w,r,sidewall,topwall, air_channel);
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
module end_cap_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    intersection(){
        chamber_void(w,r,sidewall,topwall,air_channel);
        end_cap_top(w,r,sidewall,topwall,air_channel, extension);
    }
    
}

module end_cap(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    difference(){
        end_cap_top(w,r,sidewall,topwall,air_channel);
        end_cap_void(w,r,sidewall,topwall,air_channel);
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
module base_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	//air_channel=(extension /2);
	//difference() {
		union(){
			closed_chamber_top(w,r,sidewall,topwall);
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
		};
		//translate([0,w,0])        
		//rotate([90,0,0])
		//cylinder(h=((sidewall+extension)*2), r=air_channel, center=true);
	//}
};
module base_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    
    intersection(){
    union() {
    closed_chamber_void(w,r,sidewall,topwall);
  	translate([(air_channel/-2),w-sidewall,0])        
	//rotate([90,0,0])
    cube([(air_channel), ((sidewall+extension) +1/* *2 */), (air_channel+1)]);
    }
    base_top(w,r,sidewall,topwall,air_channel,extension);
}
}

module base(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    difference(){
        base_top(w,r,sidewall,topwall,air_channel,extension);
        base_void(w,r,sidewall,topwall,air_channel,extension);
    }
}

/*
module base(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	//air_channel=(extension /2);
	difference() {
		union(){
			closed_chamber(w,r,sidewall,topwall);
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
			translate([(-1 * r),w,0]) 
			cube([(r*2), extension, extension]);
		};
		translate([0,w,0])        
		rotate([90,0,0])
		cylinder(h=((sidewall+extension)*2), r=air_channel, center=true);
	}
};
*/

module start_cap_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	
	union(){
		base_top(w,r,sidewall,topwall,air_channel, extension);
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
module start_cap_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    intersection(){
        base_void(w,r,sidewall,topwall,air_channel, extension);
        start_cap_top(w,r,sidewall,topwall,air_channel, extension);
    }
}
module start_cap(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    
    difference(){
        start_cap_top(w,r,sidewall,topwall,air_channel, extension);
        start_cap_void(w,r,sidewall,topwall,air_channel, extension);
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
module section_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    
    base_top(w,r,sidewall,topwall, air_channel, extension);

    
    }
module section_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    
    intersection() {
        union(){
     base_void(w,r,sidewall,topwall, air_channel, extension);
		translate([(air_channel/-2),-2,-2])
		//rotate([90,0,0])
		//cylinder(h=(sidewall*4), r=air_channel, center=true);
            cube([(air_channel), (sidewall *4/*4*/), (air_channel+3)]);
        }
        section_top(w,r,sidewall,topwall, air_channel, extension);
    }
    
    
}

module section(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    
    difference(){
        section_top(w,r,sidewall,topwall, air_channel, extension);
        section_void(w,r,sidewall,topwall, air_channel, extension);
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

module attachment_top(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	
	section_top(w, r, sidewall,topwall=2.1, air_channel, extension);
	
	difference() {
		
		translate([0,w+extension,2])
		rotate([-90,0,0])
		cylinder(h=extension, r=r, center=false);
		
		union() {
			translate([r, w+extension-1/*-2*/,(r* -2)-1])// was +2, now -1
			rotate([0,0, 90])
            cube([extension+2, r*2, r*2]);
			
			translate([r, w+extension-2,2+(r/3)])
			rotate([0,0, 90])
			cube([extension+3, r*2, r*2]);
			
		}
	} 
	}
module attachment_void(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	
    intersection(){
        union() {
            section_void(w, r, sidewall,topwall, air_channel, extension);
            translate([(air_channel/-2),w+extension, 0])
                cube([(air_channel), (extension+1), (air_channel+1)]);
            }

        attachment_top(w, r, sidewall,topwall, air_channel, extension);
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
(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
    difference(){
        attachment_top(w, r, sidewall,topwall, air_channel, extension);
        attachment_void(w, r, sidewall,topwall, air_channel, extension);
    }
}

module start_top(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -2;
	
	union(){
		start_cap_top(w, r, sidewall,topwall, air_channel, extension);
		for (index=[0:1:mid]){
			translate([0, (index+1) * (w+extension),0])
			section_top(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment_top(w, r, sidewall,topwall, air_channel, extension);
	}
}
module start_void(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -2;
	
    //intersection(){
	union(){
		start_cap_void(w, r, sidewall,topwall, air_channel, extension);
		for (index=[0:1:mid]){
			translate([0, (index+1) * (w+extension),0])
			section_void(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment_void(w, r, sidewall,topwall, air_channel, extension);
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

module middle_top(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -1;
	
	union(){
		for (index=[0:1:mid]){
			translate([0, (index) * (w+extension),0])
			section_top(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment_top(w, r, sidewall,topwall, air_channel, extension);
	}
}
module middle_void(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -1;
	//intersection() {
	union(){
		for (index=[0:1:mid]){
			translate([0, (index) * (w+extension),0])
			section_void(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment_void(w, r, sidewall,topwall, air_channel, extension);
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

module end_top(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -1;
	
	union(){
		for (index=[0:1:mid]){
			translate([0, (index) * (w+extension),0])
			section_top(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap_top(w, r, sidewall,topwall, air_channel, extension);
	}
}
module end_void(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -1;
	
	union(){
		for (index=[0:1:(mid-1)]){
			translate([0, (index) * (w+extension),0])
			section_void(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap_void(w, r, sidewall,topwall, air_channel, extension);
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

module complete_top(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -2;
	
	union(){
		start_cap_top(w, r, sidewall,topwall, air_channel, extension);
		for (index=[0:1:mid]){
			translate([0, (index+1) * (w+extension),0])
			section_top(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap_top(w, r, sidewall,topwall, air_channel, extension);
	}
}
module complete_void(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -2;
	
	union(){
		start_cap_void(w, r, sidewall,topwall, air_channel, extension);
		for (index=[0:1:(mid-1)]){
			translate([0, (index+1) * (w+extension),0])
			section_void(w, r, sidewall,topwall, air_channel, extension);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap_void(w, r, sidewall,topwall, air_channel, extension);
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
   

function inner_height(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = r + topwall +1;

function height (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = inner_height (num,w,r,sidewall,topwall,air_channel,extension,padding) + padding;

function inner_width (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = r * 2;

function width (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = inner_width (num,w,r,sidewall,topwall,air_channel,extension,padding) + (padding*2);

function y_origin (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) = (padding + extension) *-1;


module mould_case_block(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5) {
    
    w = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    h = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    y = y_origin(num,w,r,sidewall,topwall,air_channel,extension,padding);
    
    translate([w/-2, y, 0])
    cube([w,l,h]);
    
}

module top_mould_case (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2) {
    
    //mould_case_block(num,w,r,sidewall,topwall,air_channel,extension,padding);
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    h = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
    //function inner_length (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5)
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    y = y_origin(num,w,r,sidewall,topwall,air_channel,extension,padding);

    //translate([(r/4)+1, y, (padding+ (air_channel/2))]);
    difference() {
        union() {
            difference(){
                translate([wi/-2, y, 0])
                    cube([wi,l,h]);
                translate([wi/-2, y, (padding *-1)])
                    cube([wi,l,padding]);
                //funnel
                translate([(r/4)+1,l+y-padding-1,(air_channel/2)+(padding+extension)])
                //])
                    rotate([-90,0,0])
                cylinder(h=padding+2, r1=air_channel, r2=extension+(air_channel/2), center=false);
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
        bottom_mould_case(num, w, r-0.1, sidewall,topwall, air_channel, extension-0.001, padding, rim+0.2);
    }
}

module bottom_mould_case (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2) {
    
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


module complete(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,h=4){
 
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    hi = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
   
    
    union() {
        
        //flat(num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);
        translate([(wi*1),padding, hi])
            rotate([0,180,0])
                difference(){
                    top_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim);
                    complete_top(num,w,r,sidewall,topwall, air_channel, extension);
                }
        
        translate([(wi * 2.5),l,padding])
            rotate([0,0,180]) 
            union() {
                bottom_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim);
                complete_void(num,w,r,sidewall,topwall, air_channel, extension);
            }
        }
}

module start(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,h=4, top=1){
 
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    hi = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
   
    translate([padding* -6,0,0])
    union() {
        if (top == -1)
            flat(num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);
        if(top ==1) {
        translate([(wi),0, hi])
            rotate([0,180,0])
                difference(){
                    top_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim);
                    start_top(num,w,r,sidewall,topwall, air_channel, extension);
                }
            } 
            if (top==0) {
        translate([(wi* 1.5),l-(padding*2),padding]) // lone piece
        //translate([(wi * 2.5),l,padding])
                
        //translate([(wi * 2.2),l-(padding*2),padding])
            rotate([0,0,180]) 
            union() {
                bottom_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim);
                start_void(num,w,r,sidewall,topwall, air_channel, extension);
            }
                
            }
        }
}

module middle(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,h=4,top=1){
 
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    hi = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
   
    translate([padding* -6,0,0])
    union() {
        
        //flat(num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);
        translate([(wi),0, hi])
            rotate([0,180,0])
                difference(){
                    top_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim);
                    middle_top(num,w,r,sidewall,topwall, air_channel, extension);
                }
        
        //translate([(wi * 2.5),l,padding])
        translate([(wi * 2.2),l-(padding*2),padding])
            rotate([0,0,180]) 
            union() {
                bottom_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim);
                middle_void(num,w,r,sidewall,topwall, air_channel, extension);
            }
        }
}

module end(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, padding=5, rim=2,h=4,top=1){
 
    wi = width (num,w,r,sidewall,topwall,air_channel,extension,padding);
    l = length (num,w,r,sidewall,topwall,air_channel,extension,padding);
    hi = height (num,w,r,sidewall,topwall,air_channel,extension,padding);
   
    translate([padding* -6,0,0])
    union() {
        
        //flat(num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);
        translate([(wi*1),0, hi])
            rotate([0,180,0])
                difference(){
                    top_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim);
                    end_top(num,w,r,sidewall,topwall, air_channel, extension);
                }
        
        //translate([(wi * 2.5),l,padding])
        translate([(wi * 2.2),l-(padding*2),padding])
            rotate([0,0,180]) 
            union() {
                bottom_mould_case (num,w,r,sidewall,topwall, air_channel, extension, padding, rim);
                end_void(num,w,r,sidewall,topwall, air_channel, extension);
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
	bedsize=200, top=1){
	
	safesize = (bedsize-(padding*6))-12;
	section_size = w+extension;
	per_print = floor(safesize/ section_size) -1;
	num = round(length / section_size);
        
    intersection(){
    translate([0,((padding*2)+rim), 0])    
    difference() {

        
        if (num <= per_print) {
            complete (num,w,r,sidewall,topwall, air_channel, extension, padding, rim,h);
        } else {
            
            if (section ==0) {
                start(per_print,w,r,sidewall,topwall, air_channel, extension, padding, rim,h,top);
            } else {
                if ((((section +1) * per_print) >
                    num)|| (section>1)) {
                    end(num%per_print,w,r,sidewall,topwall, air_channel, extension, padding, rim,h,top);
                } else {
                    middle(per_print,w,r,sidewall,topwall, air_channel, extension, padding, rim,h,top);
                }
            }
        }
    translate([0,0, bedsize * -1])
    cube([bedsize,bedsize,bedsize]);
    }
    cube([safesize,safesize,safesize]);
}
}

tentacle(0, length=470, top=1);
//intersection(){ //what??
//start_top();
//    start_void();
//}
//union(){
//    section_top();
//    section_void();
//}
//difference(){
//union(){
//    top_mould_case();
//    bottom_mould_case();
//}