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

// input, no output
module chamber(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2) {
	difference(){
		closed_chamber(w,r,sidewall,topwall);
		translate([0,sidewall,0])
		rotate([90,0,0])
		cylinder(h=(sidewall*4), r=air_channel, center=true);
	};
};

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

// no input, output
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



module start (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -2;
	
	union(){
		start_cap(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3);
		for (index=[0:1:mid]){
			translate([0, (index+1) * (w+extension),0])
			section(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2,extension=3);
	}
}

module middle (num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -1;
	
	union(){
		for (index=[0:1:mid]){
			translate([0, (index) * (w+extension),0])
			section(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3);
		};
		translate([0, (num-1) * (w+extension),0])
		attachment(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2,extension=3);
	}
}
module end(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -1;
	
	union(){
		for (index=[0:1:mid]){
			translate([0, (index) * (w+extension),0])
			section(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2,extension=3);
	}
}

module complete(num=3, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3) {
	mid = num -2;
	
	union(){
		start_cap(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3);
		for (index=[0:1:mid]){
			translate([0, (index+1) * (w+extension),0])
			section(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3);
		};
		translate([0, (num-1) * (w+extension),0])
		end_cap(w=22, r=20, sidewall=1,topwall=2.1, air_channel=2,extension=3);
	}
}

module tentacle(section=0, w=22, r=20, sidewall=1,topwall=2.1, air_channel=2, extension=3, length=500,
	bedsize=223){
	
	safesize = bedsize-20;
	section_size = w+extension;
	per_print = floor(bedsize/ section_size);
	num = round(length / section_size);
	if (num <= per_print) {
		complete(num,w,r,sidewall,topwall, air_channel, extension);
	} else {
		
		if (section ==0) {
			start(per_print,w,r,sidewall,topwall, air_channel, extension);
		} else {
			if (((section +1) * per_print) >
				num) {
				end(num%per_print,w,r,sidewall,topwall, air_channel, extension);
			} else {
				middle(per_print,w,r,sidewall,topwall, air_channel, extension);
			}
		}
	}   
}

tentacle(2);