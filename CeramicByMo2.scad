$fn=500;
$fa = 1;
$fs = 0.4;
wheel_radius = 270;
tyre_diameter = 200;

difference() {
    cube([170,95,5]);
    translate([50,20,-1])
        cylinder(h=7,r=5);
    translate([90,20,-1])
        cylinder(h=7,r=5);

    translate([10,310,20])
        rotate_extrude(angle=360) {
            translate([wheel_radius - tyre_diameter/2, 0])
                circle(d=tyre_diameter);
        }
    translate([10,310,-15])
        rotate_extrude(angle=360) {
            translate([wheel_radius - tyre_diameter/2, 0])
                circle(d=tyre_diameter);
        }
}
