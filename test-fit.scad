//magnet test fit

// 4.15, 4.20, *4.25*(cold), 4.30, 4.35, 4.40
// 4.00, 4.05, 4.10, 4.15, 4.20, 4.25
step=0.05;
gap=12;
cols=6;
stripw=6;

mag_dia_min = 4.00;    // Diameter dimension of magnets
mag_depth = 1.75;  // Depth (height) dimenstion of magnets
mag_bury = 1.25;   // How deep to bury the magnets in the part

difference() {
    strip();
    holes();
}

module strip() {
    translate([-gap,0,0]) {
        cylinder(r=stripw/2, h=mag_bury + mag_depth, $fn=20);
    }
    translate([(gap + mag_dia_min) * cols - 2 * gap,0,0]) {
        cylinder(r=stripw/2, h=mag_bury + mag_depth, $fn=20);
    }
    translate([-gap, -stripw/2, 0])
        cube(size=[(gap + mag_dia_min) * cols - gap, stripw, mag_depth + mag_bury]);
}

module holes() {
    for (i = [0:1:cols-1]) {
        translate([i * gap,0,mag_bury]) {
            linear_extrude(mag_depth + 1) {
                circle(r=(mag_dia_min + (step * i))/2, $fn=20);
            }
        }
    }
}