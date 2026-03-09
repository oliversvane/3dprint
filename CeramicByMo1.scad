$fn=500;
$fa = 1;
$fs = 0.4;
wheel_radius = 240;
tyre_diameter = 60;

difference() {
    cube([130,80,5]);
    translate([50,20,-1])
        cylinder(h=7,r=5);
    translate([90,20,-1])
        cylinder(h=7,r=5);

    translate([10,270,20])
        rotate_extrude(angle=360) {
            translate([wheel_radius - tyre_diameter/2, 0])
                circle(d=tyre_diameter);
        }
    translate([10,270,-15])
        rotate_extrude(angle=360) {
            translate([wheel_radius - tyre_diameter/2, 0])
                circle(d=tyre_diameter);
        }

    
    translate([5,5,4.5])
        text("by", size=5);
    translate([14,5,4.5])
        text("MO", size=10, font="Z003");
}
