//measurements in millimeters
_screenHeight = 3;
_screenWidth = 19.45;
_screenLength = 24.2;
_switchLength = 15;
_switchWidth = 15;

_keyWidthPadding = 2;
_keyHeightPadding = 5;
_keyLengthPadding = 1;
_keyLengthOverhangOffset= 1.6;

_keyCapInternalHollowingSide = 18;

_keyWidth = _screenWidth+(_keyWidthPadding*2);
_keyLength = _screenLength+(_keyLengthPadding-_keyLengthOverhangOffset);
_keyHeight = _screenHeight + (_keyHeightPadding);
_keyHollowingHeightOffset = _keyHeightPadding+.5;

_keyCoverThickness = 2.5;
_keyCoverWidth = _keyWidth+_keyCoverThickness;
_keyCoverLength = _keyLength+_keyCoverThickness+(_keyLengthOverhangOffset*2);
_keyCoverHeight = _screenHeight+2;
_keyCoverInternalFitTolerance = .15;

_keyCapHoleEdgeOffset = .55;

_switchPaddingLength = 2.25;
_switchPaddingWidth = 2.25;
_keySwitchCutoutLength = 13.95; //14.05
_keySwitchCutoutWidth = 13.95; //14.05

_controlBoardLength = 102;//mm
_controlBoardWidth = 53.5;//mm
_controlBoardScrewHoleDiameter = 3.4;

_m2KnurlCutoutDiameter = 3.6;//mm
_m2KnurlCutoutHeight = 3;//mm

_keySpacingDist = 2; //mm between each key

_plateHeight = 5;

_keyCapShankOffsetRiserLength = 7.01; // Warning: Careful when modifying. This is a tuned value.
_keyCapShankOffsetRiserWidth = 4.55; // Warning: Careful when modifying. This is a tuned value.
_keyCapShankOffsetTowardSwitch = 3;

_housingThickness = 5;
_housingFitTolerance = .25;

//constants
_screenKeysPerRow = 1;
_basicKeysPerRow = 0;
_numScreenKeys = 25;
_numBasicKeys = 5;

//calculated values
_plateLengthWireExtension = 3;
_keyRowWidth = (_screenKeysPerRow+_basicKeysPerRow)*(_keySpacingDist+_keyCoverWidth); //row of X screen keys and 1 basic
_keyRowLength = _keyLength+(_keySpacingDist*2)+_plateLengthWireExtension;
_housingInternalHeightClearance = 10; //distance between bottom of plate and internal bottom of housing

//housing calculations must include arduino plate sizing later
_housingExternalWidth = _keyRowWidth+_housingThickness;
_housingExternalLength = _keyRowLength+_housingThickness;
_housingHeight = _plateHeight + _housingInternalHeightClearance;


main();

module main(){
    translate([0,0,_plateHeight+_keyCapShankOffsetRiserLength/4]){
        //screenKeyCap();

        translate([(-_keyCoverThickness/2)-_keyCoverInternalFitTolerance/2,-_keyCoverThickness/2-_keyCoverInternalFitTolerance/2,5]){
            //screenKeyCapCover();
        }
        
    }
    
    housing();

    translate([(_housingThickness/2)+_housingFitTolerance/2,(_housingThickness/2)+_housingFitTolerance/2,_housingHeight-(_plateHeight)]){
         keyPlate(true, true, true);
    }
   

    //controlBoardModel();
}

module screenModel(){
    cube([_screenWidth, _screenLength, _screenHeight]);
}



module screenKeyCap(){
    union(){
        difference(){
            //main key body
            roundedCube(size=[_keyWidth, _keyLength, _keyHeight], radius=.4, apply_to="none");

            screenYOffset = 1.25;
            //screen cutout
            translate([_keyWidthPadding,_keyLengthPadding+screenYOffset,(_keyHeightPadding)+.1]){
                screenModel();

                trenchLength = 7;
                trenchScreenEdgeDist = 12;
                //resistors trench cutout
                translate([0,trenchScreenEdgeDist-(trenchLength/2),-1]){
                    cube(size=[_screenWidth, 9, 1.5]);
                }
            }

            


            //internal hollowing
            translate([(_keyWidth/2)-(_keyCapInternalHollowingSide/2), (_keyLength/2)-
            (_keyCapInternalHollowingSide/2), -_keyHeight+_keyHollowingHeightOffset]){
                cube(size=[_keyCapInternalHollowingSide, _keyCapInternalHollowingSide,
                _keyHollowingHeightOffset]);
            }

        }

        translate([(_keyWidth-_keyCapShankOffsetRiserLength)/2,(_keyLength-_keyCapShankOffsetRiserWidth)/2,
        -_keyHeight+_keyHollowingHeightOffset+_keyCapShankOffsetTowardSwitch]){
                keyCapShankConnector();
        }
    }
}

module screenKeyCapCover(){
    union(){
        difference(){
            //main body
            roundedCube(size=[_keyCoverWidth, _keyCoverLength, _keyCoverHeight], radius=.4, apply_to="all");
            //internal keycap cutout
            translate([_keyCoverThickness/2, _keyCoverThickness/2, -_keyCoverHeight+.5]){
                roundedCube(size=[_keyWidth+_keyCoverInternalFitTolerance,
                _keyLength+_keyCoverInternalFitTolerance+(_keyLengthOverhangOffset*2), _keyHeight], radius=.4, apply_to="none");
            }

            displayAreaX = 12.5;
            displayAreaY = 12.6;
            //screen Window cutout
            translate([(_keyCoverWidth/2)-displayAreaX/2,_keyLength/2,0]){
                cube(size=[displayAreaX, displayAreaY, 5]);
            }
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
                        cylinder(r=_controlBoardScrewHoleDiameter-.9, h=4, $fn=100);
                    }

                    translate([screwHoleBDistFromYAxis,screwHoleBDistFromXAxis,1]){
                        cylinder(r=_controlBoardScrewHoleDiameter-.9, h=4, $fn=100);
                    }

                    translate([screwHoleCDistFromYAxis,screwHoleCDistFromXAxis,1]){
                        cylinder(r=_controlBoardScrewHoleDiameter-.9, h=4, $fn=100);
                    }

                    translate([screwHoleDDistFromYAxis,screwHoleDDistFromXAxis,1]){
                        cylinder(r=_controlBoardScrewHoleDiameter-.9, h=4, $fn=100);
                    }
                }
               

                //screwholes
                translate([screwHoleADistFromYAxis,screwHoleADistFromXAxis,-1]){
                    cylinder(r=_controlBoardScrewHoleDiameter/2, h=8, $fn=100);
                }

                translate([screwHoleBDistFromYAxis,screwHoleBDistFromXAxis,-1]){
                    cylinder(r=_controlBoardScrewHoleDiameter/2, h=8, $fn=100);
                }

                translate([screwHoleCDistFromYAxis,screwHoleCDistFromXAxis,-1]){
                    cylinder(r=_controlBoardScrewHoleDiameter/2, h=8, $fn=100);
                }

                translate([screwHoleDDistFromYAxis,screwHoleDDistFromXAxis,-1]){
                    cylinder(r=_controlBoardScrewHoleDiameter/2, h=8, $fn=100);
                }
            }
        }
        
        maxPortHeight = 23;
        dcJackPortWidth=9.5;
        usbPortWidth=11.5;
        usbPortHeight=8;
        dcRearOverhangLength = 3;
        //test port alignments
        translate([0,-dcRearOverhangLength,0]){
            
            difference(){
                union(){
                     cube(size=[_controlBoardWidth, 5, maxPortHeight]);
                     translate([0,5,0])
                     cube(size=[_controlBoardWidth, dcRearOverhangLength+1, 2]);
                }
               

                translate([_controlBoardWidth-7.5,7,14]){
                    rotate([90,0,0])
                    cylinder(r=dcJackPortWidth/2, h=8, $fn=100);
                }

                translate([10,-1,5.5]){
                    roundedCube(size=[usbPortWidth, 8, usbPortHeight], radius=.4, apply_to="all");
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

module housing(){
    union(){
        difference(){
            roundedCube(size = [_housingExternalWidth, _housingExternalLength, _housingHeight], radius = .4, apply_to="yMax");

            translate([_housingThickness/2,_housingThickness/2,_housingThickness/2]){
                cube(size = [_keyRowWidth + _housingFitTolerance, _keyRowLength+_housingFitTolerance, _housingHeight]);
            }

             //side screw mounts
            translate([-.1,(_keyRowLength/6)+_housingThickness/2,_housingHeight-(_plateHeight/2)]){
                rotate([0,90,0]){
                    cylinder(r=_m2KnurlCutoutDiameter/2, h=_m2KnurlCutoutHeight, $fn=200);
                }
            }

            translate([-.1,(_keyRowLength-6)+_housingThickness/2,_housingHeight-(_plateHeight/2)]){
                rotate([0,90,0]){
                    cylinder(r=_m2KnurlCutoutDiameter/2, h=_m2KnurlCutoutHeight, $fn=200);
                }
            }

            translate([_keyRowWidth + _housingFitTolerance+(_m2KnurlCutoutDiameter/2)
            ,(_keyRowLength/6)+_housingThickness/2,_housingHeight-(_plateHeight/2)]){
                rotate([0,90,0]){
                    cylinder(r=_m2KnurlCutoutDiameter/2, h=_m2KnurlCutoutHeight, $fn=200);
                }
            }

            translate([_keyRowWidth + _housingFitTolerance+(_m2KnurlCutoutDiameter/2),
            (_keyRowLength-6)+_housingThickness/2,_housingHeight-(_plateHeight/2)]){
                rotate([0,90,0]){
                    cylinder(r=_m2KnurlCutoutDiameter/2, h=_m2KnurlCutoutHeight, $fn=200);
                }
            }
        }
        //inner shelving
        translate([_housingThickness/2,_housingThickness/2,_housingHeight-_plateHeight]){
            rotate([270,0,0]){
                rightTriangle(size=[3,4,_keyRowLength+_housingFitTolerance]);
            }
        }

          translate([(_keyRowWidth+_housingThickness/2)+_housingFitTolerance,(_keyRowLength+_housingThickness/2)+_housingFitTolerance,_housingHeight-_plateHeight]){
                rotate([270,0,180]){
                    rightTriangle(size=[3,4,_keyRowLength+_housingFitTolerance]);
                }
            }
    }
}

module keyPlate(includeRoute = true, includeLeftScrews = true, includeRightScrews = true){
    plateWidth = (_keySpacingDist+_keyCoverWidth);
    plateLength = _keyLength+(_keySpacingDist*2)+_plateLengthWireExtension;
    screenRouteCutoutDist = 4.5;
    screenRouteWidth = 18;
    screenRouteLength = 4;
    difference(){
        cube(size=[plateWidth, plateLength, _plateHeight]);

        translate([(plateWidth/2)-(_keySwitchCutoutWidth/2), (plateLength/2)-(_keySwitchCutoutLength/2)-_keySpacingDist, -.5]){
            //key cutout
            cube(size=[_keySwitchCutoutWidth, _keySwitchCutoutLength, 6]);

            if(includeRoute){
                //screen wire route
                translate([(_keySwitchCutoutWidth/2)-screenRouteWidth/2,(_keySwitchCutoutLength)+screenRouteCutoutDist,0]){
                    roundedCube(size=[screenRouteWidth,screenRouteLength,6], radius=.5, apply_to="none");
                }
            }
        }

        //side screw mounts
        if(includeLeftScrews){
            translate([-.1,plateLength/6,(_plateHeight/2)]){
                rotate([0,90,0]){
                    cylinder(r=_m2KnurlCutoutDiameter/2, h=_m2KnurlCutoutHeight, $fn=200);
                }
            }

             translate([-.1,plateLength-6,(_plateHeight/2)]){
                rotate([0,90,0]){
                    cylinder(r=_m2KnurlCutoutDiameter/2, h=_m2KnurlCutoutHeight, $fn=200);
                }
            }
        }

        if(includeRightScrews){
              translate([plateWidth-_m2KnurlCutoutHeight+.1,plateLength/6,(_plateHeight/2)]){
                rotate([0,90,0]){
                    cylinder(r=_m2KnurlCutoutDiameter/2, h=_m2KnurlCutoutHeight, $fn=200);
                }
            }

             translate([plateWidth-_m2KnurlCutoutHeight+.1,plateLength-6,(_plateHeight/2)]){
                rotate([0,90,0]){
                    cylinder(r=_m2KnurlCutoutDiameter/2, h=_m2KnurlCutoutHeight, $fn=200);
                }
            }
        }
    }
}

module rightTriangle(size = [1,1,1]){
    difference(){
        legA = size[0];
        legB = size[1];
        cube(size = [size[0], size[1], size[2]]);
        translate([legA,0,-1]){
            rotate([0,0,45]){
                cube(size = [size[0], size[1]+5, size[2]+5]);
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