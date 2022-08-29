//measurements in millimeters
_screenHeight = 2;
_screenWidth = 19;
_screenLength = 24;
_switchLength = 15;
_switchWidth = 15;

_keyWidthPadding = 4;
_keyHeightPadding = 5;
_keyLengthPadding = 2;
_keyLengthOverhangOffset= 1.6;

_keyWidth = _screenWidth+(_keyWidthPadding*2);
_keyLength = _screenLength+(_keyLengthPadding-_keyLengthOverhangOffset);
_keyHeight = _screenHeight + (_keyHeightPadding);
_keyHollowingHeightOffset = _keyHeightPadding+.5;


_switchPaddingLength = 2.25;
_switchPaddingWidth = 2.25;
_keySwitchCutoutLength = 13.95; //14.05
_keySwitchCutoutWidth = 13.95; //14.05

_controlBoardLength = 102;//mm
_controlBoardWidth = 53.5;//mm
_controlBoardScrewHoleDiameter = 3.4;

_keySpacingDist = 2; //mm between each key

_plateHeight = 5;

_keyCapShankOffsetRiserLength = 7.01; // Warning: Careful when modifying. This is a tuned value.
_keyCapShankOffsetRiserWidth = 4.55; // Warning: Careful when modifying. This is a tuned value.
_keyCapShankOffsetTowardSwitch = 3;

//constants
_numScreenKeys = 25;
_numBasicKeys = 5;

//formulas


main();

module main(){
    translate([0,0,_plateHeight+_keyCapShankOffsetRiserLength/4]){
        //screenKeyCap();
    }
    
    //rowPlate(1);

    controlBoardModel();
}

module screenModel(){
    cube([_screenWidth, _screenLength, _screenHeight]);
}



module screenKeyCap(){
    union(){
        difference(){
            //main key body
            roundedCube(size=[_keyWidth, _keyLength, _keyHeight], radius=.4, apply_to="none");

            //screen cutout
            translate([_keyWidthPadding,_keyLengthPadding,(_keyHeightPadding)+1]){
                screenModel();
            }

            //internal hollowing
            translate([_keyWidthPadding, _keyLengthPadding, -_keyHeight+_keyHollowingHeightOffset]){
                cube(size=[_screenWidth, _screenLength-_keyLengthOverhangOffset-_keyLengthPadding,
                _keyHollowingHeightOffset]);
            }

        }

        translate([(_keyWidth-_keyCapShankOffsetRiserLength)/2,(_keyLength-_keyCapShankOffsetRiserWidth)/2,
        -_keyHeight+_keyHollowingHeightOffset+_keyCapShankOffsetTowardSwitch]){
                keyCapShankConnector();
        }
    }
}

module controlBoardModel(){
    screwHoleEdgeDistance = 2.5;
     screwHoleADistFromXAxis = 14.0;
    screwHoleADistFromYAxis = _controlBoardWidth-screwHoleEdgeDistance;

    screwHoleBDistFromXAxis = 15.3;
    screwHoleBDistFromYAxis = screwHoleEdgeDistance;

    screwHoleCDistFromXAxis = 90.2;
    screwHoleCDistFromYAxis = screwHoleEdgeDistance;

    screwHoleDDistFromXAxis = 96.52;
    screwHoleDDistFromYAxis = _controlBoardWidth-screwHoleEdgeDistance;
    union(){
        translate([0,6,0]){
            difference(){
                union(){
                    cube(size=[_controlBoardWidth, _controlBoardLength, 2]);
                    //screwhole standoffs
                    translate([screwHoleADistFromYAxis,screwHoleADistFromXAxis,1]){
                        cylinder(r=_controlBoardScrewHoleDiameter-.9, h=3, $fn=100);
                    }

                    translate([screwHoleBDistFromYAxis,screwHoleBDistFromXAxis,1]){
                        cylinder(r=_controlBoardScrewHoleDiameter-.9, h=3, $fn=100);
                    }

                    translate([screwHoleCDistFromYAxis,screwHoleCDistFromXAxis,1]){
                        cylinder(r=_controlBoardScrewHoleDiameter-.9, h=3, $fn=100);
                    }

                    translate([screwHoleDDistFromYAxis,screwHoleDDistFromXAxis,1]){
                        cylinder(r=_controlBoardScrewHoleDiameter-.9, h=3, $fn=100);
                    }
                }
               

                //screwholes
                translate([screwHoleADistFromYAxis,screwHoleADistFromXAxis,-1]){
                    cylinder(r=_controlBoardScrewHoleDiameter/2, h=6, $fn=100);
                }

                translate([screwHoleBDistFromYAxis,screwHoleBDistFromXAxis,-1]){
                    cylinder(r=_controlBoardScrewHoleDiameter/2, h=6, $fn=100);
                }

                translate([screwHoleCDistFromYAxis,screwHoleCDistFromXAxis,-1]){
                    cylinder(r=_controlBoardScrewHoleDiameter/2, h=6, $fn=100);
                }

                translate([screwHoleDDistFromYAxis,screwHoleDDistFromXAxis,-1]){
                    cylinder(r=_controlBoardScrewHoleDiameter/2, h=6, $fn=100);
                }
            }
        }
        
        maxPortHeight = 15;
        dcJackPortWidth=9.5;
        usbPortWidth=11.5;
        usbPortHeight=5.5;
        dcRearOverhangLength = 3;
        //test port alignments
        translate([0,-dcRearOverhangLength,0]){
            
            difference(){
                union(){
                     cube(size=[_controlBoardWidth, 5, maxPortHeight]);
                     translate([0,5,0])
                     cube(size=[_controlBoardWidth, dcRearOverhangLength+1, 2]);
                }
               

                translate([_controlBoardWidth-7,7,9]){
                    rotate([90,0,0])
                    cylinder(r=dcJackPortWidth/2, h=8, $fn=100);
                }

                translate([9,-1,4]){
                    cube(size=[usbPortWidth, 8, usbPortHeight]);
                }
            }
        }
    }
}

module keyCapShankConnector()
{
    union()
    {
        // Shank
        translate([0,0,-_keyCapShankOffsetTowardSwitch])
            difference()
            //union()
            {
                shankConnectorDepth = 3.8;
                roundedCube(size=[_keyCapShankOffsetRiserLength, _keyCapShankOffsetRiserWidth, shankConnectorDepth], radius=0.4, apply_to="none");

                //crossPunch
                crossPunchFinLength = 4.3; // Warning: Careful when modifying. This is a tuned value.
                crossPunchFinWidth = 1.21; // Warning: Careful when modifying. This is a tuned value.
                crossPunchFinAdditionalCut = 2;

                translate([_keyCapShankOffsetRiserLength/2, _keyCapShankOffsetRiserWidth/2, -1])
                    union()
                    {
                        translate([-crossPunchFinLength/2, -crossPunchFinWidth/2, 0])
                            roundedCube(size=[crossPunchFinLength, crossPunchFinWidth, shankConnectorDepth+2], radius=0.25, apply_to="none");
                        rotate([0,0,90])
                            translate([-(crossPunchFinLength+crossPunchFinAdditionalCut)/2, -crossPunchFinWidth/2, 0])
                                roundedCube(size=[crossPunchFinLength+crossPunchFinAdditionalCut, crossPunchFinWidth, shankConnectorDepth+2], radius=0.25, apply_to="none");
                    }
            }

        roundedCube(size=[_keyCapShankOffsetRiserLength, _keyCapShankOffsetRiserWidth, _keyCapShankOffsetTowardSwitch], radius=0.4, apply_to="none");
        
    }
}

module rowPlate(rowSwitches = 1){
    plateWidth = rowSwitches*(_keySpacingDist+_keyWidth);
    plateCornerPadding=6;
    plateLength = _keyLength+(_keySpacingDist*2);

    screenRouteCutoutDist = 2;
    screenRouteWidth = 10;
    screenRouteLength = 3;
    difference(){
        cube(size=[plateWidth, plateLength, _plateHeight]);

        translate([plateCornerPadding, (plateLength/2)-(_keySwitchCutoutLength/2)-_keySpacingDist, 0]){

            for(i=[0:rowSwitches]){
                if(i<rowSwitches){
                    translate([(i*_keyWidth)+_keySpacingDist,_keySpacingDist,-.5]){
                        //key cutout
                        cube(size=[_keySwitchCutoutWidth, _keySwitchCutoutLength, 6]);

                        //screen wire route
                        translate([(_keySwitchCutoutWidth/2)-screenRouteWidth/2,(_keySwitchCutoutLength)+screenRouteCutoutDist,0]){
                            roundedCube(size=[screenRouteWidth,screenRouteLength,6], radius=.5, apply_to="none");
                        }
                    }
                }
            }
        }
    }

}

/// Builds a cube with rounded corners
/// size - dimension vector
/// center - centered on xyz planes?
/// radius - rounding radius
/// apply_to - which sides to round
module roundedCube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all")
{
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius, $fn=20);
						} else {
							rotate =
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true, $fn=20);
						}
					}
				}
			}
		}
	}
}