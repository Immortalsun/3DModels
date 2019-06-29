PLATE_WIDTH = 112;//mm
PLATE_LENGTH = 65;//mm
PLATE_THICKNESS = 1.85;//mm
BASE_DIAM = 46;//mm

ROUNDING_RADIUS = 41;

facePlate();


module facePlate(){
    //union()
    intersection()
    {
        rotate([0,0,0])
            mainPlate();

            scaleX=.8;
            scaleY=1.6;
            translate([(PLATE_LENGTH/2), (PLATE_WIDTH/2), -1])
                scale([scaleX, scaleY, 1])
                    rotate([0,0,0])
                        cylinder(r=ROUNDING_RADIUS, h=5, $fn=140);
          
        }
 
}

module mainPlate(){
  difference(){
        cube([PLATE_LENGTH,PLATE_WIDTH, PLATE_THICKNESS]);

        translate([(PLATE_LENGTH/2), BASE_DIAM/1.5, -.5]) {
            cylinder(r=BASE_DIAM/2, h=5, $fn=149);
        }
    }

}