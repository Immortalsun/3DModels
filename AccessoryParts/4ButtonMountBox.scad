//switch params
SWITCH_RAD = 8;//mm
SWITCH_HT =27;//mm
//variables
numSwitches = 4;
spaceBetweenSwitches = 6;
boxWallThickness = 5;//mm
_sideRes = 200;
//box params
BOX_LENGTH = ((SWITCH_RAD*2)+spaceBetweenSwitches)*numSwitches;
BOX_WIDTH = (SWITCH_RAD*2) + 10;
BOX_HT = SWITCH_HT+10;

//mainBox();

translate([0, 0, 0]) {
    boxStand();
}


module mainBox(){
    difference(){
         cube([BOX_LENGTH, BOX_WIDTH, BOX_HT]);

         translate([boxWallThickness/2, boxWallThickness/2, -boxWallThickness/2]) {
             cube([BOX_LENGTH-boxWallThickness, BOX_WIDTH-boxWallThickness, BOX_HT]);
         }

        translate([(SWITCH_RAD*2)-spaceBetweenSwitches+1, 0, 0]) {
            for(i=[0:numSwitches-1]){
                translate([((SWITCH_RAD*2)+spaceBetweenSwitches)*i, BOX_WIDTH/2, BOX_HT]) {
                    cylinder(r=SWITCH_RAD, h=SWITCH_HT, center=true, $fn=_sideRes);
                }
            }
        }

        //wire route
        translate([boxWallThickness,BOX_WIDTH-3,boxWallThickness]){
            cube([BOX_LENGTH-10, 5,5]);
        }

    }
   
}

module boxStand(){
    difference(){
        cube([BOX_LENGTH+8, BOX_WIDTH+8, 5]);
        translate([4, 4, 3]) {
             cube([BOX_LENGTH+.5, BOX_WIDTH+.5, 3]);
        }
       

    }
    
}