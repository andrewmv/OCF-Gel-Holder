include <ocf-gel-modules.scad>
include <Hexes.scad>

//// USER VARIABLES ////
//// All values in mm ////

outer_dia = 70; // Outer Diameter
inner_dia = 60; // Inner Diameter
grid_depth = 13;
depth = grid_depth + 3;     // Total depth (height) of ring
$fn = 50;       // Polygon count of circles

nozzle_width = 0.5;
grid_angle = 20; // Degrees

mag_dia = 4.40;   // Diameter dimension of magnets
mag_depth = 2.2;  // Depth (height) dimenstion of magnets
mag_bury = -0.1;	  // How deep to bury the magnets in the part
mag_count = 12;   // Number of magnets around circumference of ring
//mag_tol = 0.25; // Tolerace of magnet inserts (added to size of inserts)

lip_w = 2;  // Width of handle/lip for removal
lip_h = 2;  // Height of lip

//// COMPUTED VARIABLES - You shouldn't need to touch these ////

hex_r = (grid_depth * tan(grid_angle)) / 2;
mag_hole_depth = mag_depth + mag_bury;
mag_degrees = 360 / mag_count;
ring_center = (inner_dia + ((outer_dia - inner_dia) / 2)) / 2;

//// ASSEMBLY - Now render the part with these values ////

asm();

intersection() {
    translate([-inner_dia/2,-inner_dia/2,0])
        bounded_hex_lattice(size=[inner_dia,inner_dia,grid_depth], r=hex_r, spacing=nozzle_width, border=0);
    cylinder(h=depth, r=inner_dia/2);
}