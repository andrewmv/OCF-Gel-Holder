// Assembly
module asm() {
    difference() {
        union() {
            ring();
            lip();
        }
        color("red") mag_rings();
    }
}

// Main body of part
module ring() {
    linear_extrude(depth) {
        difference() {
            circle(r=(outer_dia / 2));
            circle(r=(inner_dia / 2));
        }
    }
}

// Wider lip at the top for easier removal
module lip() {
    linear_extrude(lip_h) {
        difference() {
            circle(r=(outer_dia + lip_w) / 2);
            circle(r=(inner_dia / 2));
        }
    }
}

// Wrapper for magnet inserts
module mag_rings() {
    //top magnet ring (closest to build plate)
    mag_inserts(mag_bury, mag_dia + 0.25); // Allow extra slop for the buildplate layer
    // bottom magnet ring (furthest from build plate)
    if (depth > 10) {
        mag_inserts(depth - mag_hole_depth, mag_dia);
    }
}

// Subtractive circular array of magnet inserts
module mag_inserts(zpos, d) {
    for (i = [0:1:mag_count]) {
        rotate([0,0,mag_degrees * i]) {
            translate([ring_center,0,zpos]) {
                linear_extrude(mag_depth) {
                    circle(r=(d / 2), $fn=20);
                }
            }
        }
    }
}