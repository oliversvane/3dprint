// Parametric L-shaped shelf mount.
// One countersunk screw into the wall, one screw up through the arm into the shelf.

screw_d    = 4;     // M-size of the screws (3, 4, 5 ...)
clearance  = 0.4;   // extra hole clearance
length     = 25;    // arm length (out from wall)
height     = 30;    // wall leg height
width      = 12;    // bracket width
thickness_min = 6;  // wall/arm thickness (grows if the nut needs more room)
radius     = 12;    // outer corner radius
end_radius = 0.001;     // radius on the free ends
edge_r     = 1.5;   // rounding of the edges facing away from wall/shelf
nut_clear  = 0.3;   // nut pocket clearance
$fn = 80;

hole_d = screw_d + clearance;
head_d = screw_d * 2 + 0.5;
head_h = (head_d - hole_d) / 2;      // 45 degree countersink
// ISO 4032 nut: across-flats and height per M size (fallback: approximations)
nut_af_tbl = [[2,4],[2.5,5],[3,5.5],[4,7],[5,8],[6,10],[8,13],[10,16]];
nut_h_tbl  = [[2,1.6],[2.5,2],[3,2.4],[4,3.2],[5,4.7],[6,5.2],[8,6.8],[10,8.4]];
function lookup_or(t, k, d) = len([for (e = t) if (e[0] == k) e[1]]) ? [for (e = t) if (e[0] == k) e[1]][0] : d;
nut_af = lookup_or(nut_af_tbl, screw_d, screw_d * 1.75) + nut_clear;
nut_h  = lookup_or(nut_h_tbl, screw_d, screw_d * 0.8) + nut_clear;
nut_d  = nut_af / cos(30);           // corner to corner
thickness = max(thickness_min, nut_h + 2.4);


module profile() {
    // x = out from wall, y = up. Wall at x=0, shelf rests on y=height.
    // Elbow stays square (it meets wall and shelf); everything else is rounded.
    inner_r = 3;
    difference() {
        hull_profile();
        translate([thickness, 0]) offset(r = inner_r) offset(delta = -inner_r)
            translate([0, -1]) square([length, height - thickness + 1]);
    }
}

module hull_profile() {
    union() {
        hull() {   // leg
            translate([-1, height - 1]) square(1);
            translate([-1, end_radius]) square([1, 1]);
            translate([thickness - end_radius, end_radius]) circle(r = end_radius);
            translate([thickness - 0.01, height - 0.01]) square(0.01);
        }
        hull() {   // arm
            translate([-1, height - 1]) square(1);
            translate([length - end_radius, height - end_radius]) circle(r = end_radius);
            translate([length - end_radius, height - thickness + end_radius]) circle(r = end_radius);
            translate([0, height - thickness]) square(0.01);
        }
    }
}

// Round every edge, then cut flat at the wall (x=0) and shelf (z=height) so those faces stay flat.
module body() {
    r = edge_r;
    intersection() {
        translate([0, 0, 0]) cube([length, width, height]);
        minkowski() {
            translate([0, width - r, 0]) rotate([90, 0, 0])
                linear_extrude(width - 2 * r)
                    offset(delta = -r) offset(delta = 0) 
                        translate([0, 0]) union() {
                            hull_profile();
                            translate([-r - 1, 0]) square([r + 1 + 0.01, height]) ;
                        }
            sphere(r = r, $fn = 24);
        }
    }
}

// Corner pieces extending the profile past wall/shelf so the cut faces are flat
difference() {
    body();

    // Wall screw (countersunk from the open face of the leg)
    translate([0, width / 2, (height - thickness) / 2]) rotate([0, 90, 0]) {
        translate([0, 0, -0.01]) cylinder(h = thickness + 0.02, d = hole_d);
        translate([0, 0, thickness - head_h]) cylinder(h = head_h + 0.01, d1 = hole_d, d2 = head_d + 0.01);
    }

    // Shelf bolt: from the shelf side down through the arm into a nut pocket in the underside
    translate([(thickness + length) / 2 + 2, width / 2, 0]) {
        translate([0, 0, height - thickness - 0.01]) cylinder(h = thickness + 0.02, d = hole_d);
        translate([0, 0, height - thickness - 0.01]) cylinder(h = nut_h + 0.01, d = nut_d, $fn = 6);
    }
}
