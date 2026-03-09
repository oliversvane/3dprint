radius=48;
height=35;
border_size=3;
side_height=16;
moter_stand_height=5;
$fn=100;

difference() {
    // Main Body
    cylinder(h=border_size,r=radius-border_size);
    
    // Skrev Holes
    translate([-radius+border_size+3.5,0,0]) {
       cylinder(h=border_size+0.002, r1=1, r2=2.5);
    }
    translate([radius-border_size-3.5,0,0]) {
            cylinder(h=border_size+0.002, r1=1, r2=2.5);
    }
    
    
    // Wall screw holes
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



translate([100,0,0]) {
    difference() {
        group() {
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
            translate([0,0,border_size])
                difference() {
                    cylinder(h=18, r=radius-border_size);
                    translate([0,-10,0]) {
                        cube([radius*2,radius*2-13,radius*2],center=true);
                    }

            }
        }
    
        
    
    

        // CO2 Sensor
        translate([0,radius-9.3,(19.5/2)+border_size+0.001]) {
            cube([26.6,8.6,19.5],center=true);
            translate([-(26.6-9.8)/2,5,(19.5-8.5)/2]) {
                cube([9.8,10,5.6],center=true);
            }
            translate([(26.6-9.8)/2-4.3,0.5,-10]) {
                cube([9.8,5.6,10],center=true);
            }
            translate([13.3+1.5-0.001,-(13.3/2),0]) {
                cube([3,14,19.5],center=true);
            }
            translate([-13.3-1.5+0.001,-(13.3/2),0]) {
                cube([3,14,19.5],center=true);
            }
            
        }
    }
    
    // Backbplate mounts
    translate([-radius+border_size+3.5,0,height-side_height]) {
        
        difference() {
            cylinder(h=side_height, r=4);
            cylinder(h=side_height, r=1);
            translate([4,0,0])
                rotate([0,-45,0])
                    cube([side_height,side_height,side_height], center=true);
        }
    }
    translate([radius-border_size-3.5,0,height-side_height]) {
        difference() {
            cylinder(h=side_height, r=4);
            cylinder(h=side_height, r=1);
            translate([-4,0,0])
                rotate([0,45,0])
                    cube([side_height,side_height,side_height], center=true);

        }

    }


    // Motor Stands
    
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



translate([50,50,0]) {
    difference() {
        group() {
            cylinder(h=moter_stand_height-1.5,r=7);
            cylinder(h=moter_stand_height+25,r=4);
        }
            translate([0,0,-0.01]){
                difference() { 
                    cube([5,3,8.5], center=true);
                    difference() {
                        cylinder(h=moter_stand_height+25,r=6);
                        cylinder(h=moter_stand_height+25,r=2.5);
                    }
                }   
                cylinder(h=1.5, r=2.5);
            }
    }
}