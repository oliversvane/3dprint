// Lattenrost Tripplehalter v2 — slat end-cap holder for 3 slats
// Based on "Lattenrost Endkappen Tripple" (P2S2, CC BY-NC-SA).
// Change vs. original: the middle band (with the 3 ovals) is removed and the
// profile is 21 mm lower. Slots and mounting holes keep their size and spacing.
// The profile is now solid between slots and holes for strength.
//
// Coordinates (the "design frame", before the print flip at the bottom):
//   X = across the part, Y = up (slots at the top, holes at the bottom),
//   Z = along the slat. The plate spans z = 10.5 .. 35.5; the sleeves run toward -Z.

/* [Slots — keep] */
slot_w       = 26;    // slot width
slot_h       = 9;     // slot height
slot_depth   = 55;    // how far the slat goes in, measured from the plate face
slot_pitch   = 42;    // center-to-center distance of the slots
slot_y       = 19;    // slot center height
slot_r       = 1;     // slot corner radius
wall         = 4;     // sleeve wall thickness

/* [Mounting holes — keep] */
hole_d       = 12;
hole_pitch   = 64;    // center to center
height_cut   = 21;    // how much lower than the original (original hole center y = -18)
hole_y       = -18 + height_cut;
hole_wall    = 3.5;   // material around the holes at the bottom edge
hole_slit_w  = 4;     // slit from each hole down through the bottom edge (0 = no slit)

/* [Plate] */
plate_w      = 122;
plate_t      = 25;    // thickness along Z
plate_z0     = 10.5;  // back face of the plate (where the sleeves start)
edge_r       = 1.5;   // rounding of the outline
groove_w     = 4;     // small groove in the top edge between the sleeves (as in the original)
groove_d     = 0;

/* [Sleeves / tongues] */
tongue_len   = 40;    // how far the tongues stick out from the back of the plate (original: 46)
partition_z  = -13.5; // back of the wall that closes the slot
sidewall_R   = 11.5;  // radius of the curved end of the sleeve side walls
tongue_on_bottom = true; // true: tongue on the bottom of the sleeve; false: on top (as in the original)

$fn = 96;

tongue_end = plate_z0 - tongue_len;     // end of the tongue
assert(tongue_end < partition_z - wall, "tongue_len too short: the tongue must reach past the closed box");

sleeve_w  = slot_w + 2*wall;            // 34
sleeve_y0 = slot_y - slot_h/2 - wall;   // 10.5
sleeve_y1 = slot_y + slot_h/2 + wall;   // 27.5
top_y     = sleeve_y1;
bottom_y  = hole_y - hole_d/2 - hole_wall;
slot_xs   = [-slot_pitch, 0, slot_pitch];
hole_xs   = [-hole_pitch/2, hole_pitch/2];

module rrect(x0, y0, x1, y1, r) {
    translate([x0 + r, y0 + r]) offset(r = r) square([x1 - x0 - 2*r, y1 - y0 - 2*r]);
}

// Extrude a 2D shape drawn in (u = Z, v = Y) along X from x0 to x1
module yz_extrude(x0, x1) {
    multmatrix([[0,0,1,x0],[0,1,0,0],[1,0,0,0],[0,0,0,1]])
        linear_extrude(x1 - x0) children();
}

// ---------- plate profile (XY) ----------
module plate_outline() {
    offset(r = edge_r) offset(delta = -2*edge_r) offset(r = edge_r)
    difference() {
        hull() {
            translate([-plate_w/2, hole_y]) square([plate_w, top_y - hole_y]);
            for (x = hole_xs) translate([x, hole_y]) circle(r = hole_d/2 + hole_wall);
        }
        // shallow grooves in the top edge between the sleeves
        for (i = [0 : len(slot_xs) - 2])
            translate([(slot_xs[i] + slot_xs[i+1])/2 - groove_w/2, top_y - groove_d])
                square([groove_w, groove_d + 1]);
    }
}

module plate() {
    translate([0, 0, plate_z0])
    linear_extrude(plate_t)
    difference() {
        plate_outline();
        for (x = hole_xs) translate([x, hole_y]) circle(d = hole_d);
        if (hole_slit_w > 0)
            for (x = hole_xs) translate([x - hole_slit_w/2, bottom_y - 1]) square([hole_slit_w, hole_y - bottom_y + 1]);
    }
}

// ---------- one sleeve ----------
module sidewall_profile() {           // in (Z, Y)
    offset(r = 1) offset(delta = -1)
    intersection() {
        translate([tongue_end, sleeve_y0]) square([plate_z0 - tongue_end, sleeve_y1 - sleeve_y0]);
        union() {
            hull() {
                translate([tongue_end + sidewall_R, sleeve_y0])
                    square([plate_z0 - tongue_end - sidewall_R, sleeve_y1 - sleeve_y0]);
                translate([tongue_end + sidewall_R, sleeve_y0 + sidewall_R]) circle(r = sidewall_R);
            }
            translate([tongue_end, sleeve_y0 + sidewall_R])
                square([sidewall_R, sleeve_y1 - sleeve_y0 - sidewall_R]);
        }
    }
}

module tongue_profile() {             // in (Z, Y)
    hull() {
        translate([tongue_end + wall/2, sleeve_y1 - wall/2]) circle(d = wall);
        translate([partition_z, sleeve_y1 - wall]) square([plate_z0 - partition_z, wall]);
    }
}

module sleeve(cx) {
    x0 = cx - sleeve_w/2;
    x1 = cx + sleeve_w/2;
    // closed box from the partition to the plate
    translate([0, 0, partition_z])
        linear_extrude(plate_z0 - partition_z + 0.01)
            rrect(x0, sleeve_y0, x1, sleeve_y1, 2);
    // tongue and two side walls, mirrored about the slot center when on the bottom
    translate([0, slot_y, 0]) mirror([0, tongue_on_bottom ? 1 : 0, 0]) translate([0, -slot_y, 0]) {
        yz_extrude(x0, x1) tongue_profile();
        yz_extrude(x0, x0 + wall) sidewall_profile();
        yz_extrude(x1 - wall, x1) sidewall_profile();
    }
}

module slot_cut(cx) {
    translate([0, 0, plate_z0 + plate_t - slot_depth-2])
        linear_extrude(slot_depth + 1)
            rrect(cx - slot_w/2, slot_y - slot_h/2, cx + slot_w/2, slot_y + slot_h/2, slot_r);
}

module part() {
    difference() {
        union() {
            plate();
            for (x = slot_xs) sleeve(x);
        }
        for (x = slot_xs) slot_cut(x);
    }
}

// Print orientation: plate face on the bed, sleeves pointing up (as in the original)
translate([0, 0, plate_z0 + plate_t]) mirror([0, 0, 1]) part();
