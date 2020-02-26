
MTR_RAD = 2.6;//mm
PTR_HEIGHT = 7;//mm

union(){
    
    translate([MTR_RAD+2.6, 0, PTR_HEIGHT-MTR_RAD]) {
        sphere(r=MTR_RAD, $fn=200);
    }

    translate([MTR_RAD+5, 0, PTR_HEIGHT-MTR_RAD]) {
        sphere(r=MTR_RAD/1.2, $fn=200);
    }

    translate([MTR_RAD+7, 0, PTR_HEIGHT-MTR_RAD]) {
        sphere(r=MTR_RAD/1.4, $fn=200);
    }

    translate([MTR_RAD+9, 0, PTR_HEIGHT-MTR_RAD]) {
        sphere(r=MTR_RAD/1.6, $fn=200);
    }

    translate([MTR_RAD+11, 0, PTR_HEIGHT-MTR_RAD]) {
        sphere(r=MTR_RAD/1.8, $fn=200);
    }

    difference(){
        cylinder(r=MTR_RAD*2,h=PTR_HEIGHT,$fn=120);
        translate([0, 0, -3]) {
            cylinder(r=MTR_RAD,h=PTR_HEIGHT+2,$fn=120);
        }
    }
}
