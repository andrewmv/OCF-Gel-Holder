include <ocf-gel-modules.scad>

//// USER VARIABLES ////
//// All values in mm ////

outer_dia = 91; // Outer Diameter
inner_dia = 79; // Inner Diameter
depth = 25;     // Total depth (height) of ring
$fn = 50;       // Polygon count of circles

mag_dia = 4.15;    // Diameter dimension of magnets
mag_depth = 4.0;  // Depth (height) dimenstion of magnets
mag_bury = 0.75; // How deep to bury the magnets in the part
mag_count = 12; // Number of magnets around circumference of ring
//mag_tol = 0.25; // Tolerace of magnet inserts (added to size of inserts)

lip_w = 2;  // Width of handle/lip for removal
lip_h = 2;  // Height of lip

//// COMPUTED VARIABLES - You shouldn't need to touch these ////

mag_hole_depth = mag_depth + mag_bury;
mag_degrees = 360 / mag_count;
ring_center = (inner_dia + ((outer_dia - inner_dia) / 2)) / 2;

//// ASSEMBLY - Now render the part with these values ////

asm();
