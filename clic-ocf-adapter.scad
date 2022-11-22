//// USER VARIABLES ////
//// All values in mm ////

// OCF (Bigger) ring
ocf_outer_dia = 91; // Outer Diameter
ocf_inner_dia = 79; // Inner Diameter

// Clic (Smaller) ring
clic_outer_dia = 70; // Outer Diameter
clic_inner_dia = 60; // Inner Diameter

depth = 15;     // Total depth (height) of ring
ring_depth = 5;
$fn = 50;       // Polygon count of circles

mag_dia = 4.15;    // Diameter dimension of magnets
mag_depth = 2.0;  // Depth (height) dimenstion of magnets
mag_bury = -0.1; // How deep to bury the magnets in the part
ocf_mag_count = 12; // Number of magnets around circumference of OCF ring
clic_mag_count = 12; // Number of magnets around circumference of Clic ring
//mag_tol = 0.25; // Tolerace of magnet inserts (added to size of inserts)

lip_w = 2;  // Width of handle/lip for removal
lip_h = 2;  // Height of lip

//// COMPUTED VARIABLES - You shouldn't need to touch these ////

mag_hole_depth = mag_depth + mag_bury;
// ocf_ring_center = (ocf_inner_dia) + ((ocf_outer_dia - ocf_inner_dia) / 4);
ocf_ring_center = ((ocf_outer_dia / 2) + (ocf_inner_dia / 2)) / 2;
// clic_ring_center = (clic_inner_dia) + ((clic_outer_dia - clic_inner_dia) / 4);
clic_ring_center = ((clic_outer_dia / 2) + (clic_inner_dia / 2)) / 2;

//// MODULES

// Wrapper for magnet inserts
module mag_rings() {
    //clic magnet ring (closest to build plate)
    mag_inserts(mag_bury, clic_ring_center, clic_mag_count);
    //ocf magnet ring (furthest from build plate)
    mag_inserts(depth + (2 * ring_depth) - mag_hole_depth - mag_bury, ocf_ring_center, ocf_mag_count);
}

// Subtractive circular array of magnet inserts
module mag_inserts(zpos, ring_center, mag_count) {
	mag_degrees = 360 / mag_count;
    for (i = [0:1:mag_count]) {
        rotate([0,0,mag_degrees * i]) {
            translate([ring_center,0,zpos]) {
                linear_extrude(mag_depth) {
                    circle(r=(mag_dia / 2), $fn=20);
                }
            }
        }
    }
}

// Define the parameters for the cross-sectional polygon
a = (clic_outer_dia / 2) - (clic_inner_dia / 2);
b = ring_depth;
c = depth;
d = (ocf_inner_dia / 2) - (clic_inner_dia / 2);
e = (ocf_outer_dia / 2) - (ocf_inner_dia / 2);
points = [
	[0,0],
	[0,b],
	[d,b+c],
	[d,b+c+b],
	[d+e,b+c+b],
	[d+e,b+c],
	[a,b],
	[a,0]	
];

//// ASSEMBLY - Now render the part with these values ////

difference() {
	rotate_extrude(angle=360, convexity=2) {
		translate([clic_inner_dia / 2,0,0])
			polygon(points=points);
	}

	color("red")	mag_rings();
}