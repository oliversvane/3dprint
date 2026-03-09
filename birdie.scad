radius=48;
height=35;
border_size=3;
side_height=16;
$fn=100;

difference() {
    // Main Body
    cylinder(h=border_size,r=radius-border_size);
    
    // Skrev Holes
    translate([-radius+border_size+2,0,0]) {
       cylinder(h=border_size+0.002, r1=1, r2=1.8);
    }
    translate([radius-border_size-2,0,0]) {
            cylinder(h=border_size+0.002, r1=1, r2=1.8);
    }
    
    
    // Wall skrev holes
    translate([15,10,-0.001]) {
            cylinder(h=border_size+0.002, r1=5.5, r2=4);
            translate([0,-10,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
            translate([0,-9,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
            translate([0,-8,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
            translate([0,-7,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
            translate([0,-6,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
            translate([0,-5,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
    }
    
    
    
    
    translate([-15,10,-0.001]) {
            cylinder(h=border_size+0.002, r1=5.5, r2=4);
            translate([0,-10,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
            translate([0,-9,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
            translate([0,-8,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
            translate([0,-7,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
            translate([0,-6,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
            translate([0,-5,0]) {
                cylinder(h=border_size+0.002, r1=3.5, r2=1.8);
            }
    }
    
    
}








// Main case
translate([150,0,0]) {
    //Wall and front
    difference() {
        cylinder(h=border_size,r=radius);
        translate([0,0,-1])
            cylinder(h=border_size+4, r=4);    
        }
    translate([0,0,border_size-0.001])
        difference() {
            cylinder(h=height,r=radius);
            cylinder(h=height+0.001, r=radius-border_size);

        }


    // Backbplate mounts
    
    translate([-radius+border_size+2,0,height-side_height]) {
        
        difference() {
            cylinder(h=side_height, r=3);
            cylinder(h=side_height, r=1);
            translate([3,0,-4])
                rotate([0,-45,0])
                    cube([side_height,side_height,side_height], center=true);
        }
    }
    translate([radius-border_size-2,0,height-side_height]) {
        difference() {
            cylinder(h=side_height, r=3);
            cylinder(h=side_height, r=1);
            translate([-3,0,-4])
                rotate([0,45,0])
                    cube([side_height,side_height,side_height], center=true);

        }

    }


    // Motor Stands
    moter_stand_height=5;
    translate([35/2,8,border_size-0.001]) {
        difference() {
            cylinder(h=moter_stand_height,r=3.5);
            cylinder(h=moter_stand_height,r=1);
            
        }
    }
    translate([-35/2,8,border_size-0.001]) {
        difference() {
            cylinder(h=moter_stand_height,r=3.5);
            cylinder(h=moter_stand_height,r=1);
            
        }
    }

}
