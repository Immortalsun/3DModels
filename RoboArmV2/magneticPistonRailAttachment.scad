//part constants
//import lid platform to build off of
//main base dimensions
BASE_RAD = 69;//mm
BASE_HEIGHT = 75;//mm
BASE_THICKNESS = 5;//mm

//LID PARAMS
//Lid Dimensions
LID_RAD = 69;
LID_HEIGHT= 4;

//shoulder mount flange dimensions
FLANGE_HEIGHT = 30;//mm
FLANGE_WIDTH = LID_RAD*1.5;
FLANGE_LENGTH = 10;//mm

//Motor Dimensions
MOTOR_WIDTH = 42.3;//mm
MOTOR_HEIGHT = 34;//mm //smaller NEMA motor, other height is 38.5
MOTOR_SHAFT_THRU_RADIUS = 11;//mm
MOTOR_SHAFT_RADIUS = 2.5;//mm

//motor screwhole dimensions
MTR_SCREW_RAD = 1.55;//mm
MTR_SCREW_HEIGHT = 5.3;//mm
MTR_SCREW_COUNTERSINK_HEIGHT = 2;//mm
MTR_SCREW_COUNTERSINK_RAD = 2.7;//mm

//bearing dimensions
BEARING_ID = 10.2;//mm
BEARING_OD = 30.2;//mm
BEARING_HEIGHT = 9.2;//mm

//SHOULDER MOUNT PARAMS
MOUNT_OUTER_WIDTH = 90;//mm
MOUNT_OUTER_LENGTH = 100;//mm
MOUNT_OUTER_HEIGHT = MOTOR_WIDTH + 15;
MOUNT_WALL_THICKNESS = 8;

//Lower Arm
LOWER_ARM_OUTER_LENGTH = 75;//mm
LOWER_ARM_BRACE_WIDTH = 8;//mm
LOWER_ARM_BRACE_THIC = 23;//mm
LOWER_ARM_BRACE_HT = 20;//mm
LOWER_ARM_BRACE_WALL = 6;

LOWER_ARM_BRIDGE_LENGTH = 8;
LOWER_ARM_BRIDGE_WIDTH = (((LID_RAD/2)-3)*2)-LOWER_ARM_BRACE_WIDTH;
LOWER_ARM_BRIDGE_HEIGHT = LOWER_ARM_BRACE_THIC;

//elbow servo mount
ELBOW_ARM_OUTER_LENGTH = 85;//mm
ELBOW_ARM_BRACE_WIDTH = 8;//mm
ELBOW_ARM_BRACE_THIC = 23;//mm
ELBOW_ARM_BRACE_HT = 20;//mm
ELBOW_ARM_BRACE_WALL = 6;

ELBOW_ARM_BRIDGE_LENGTH = 8;
ELBOW_ARM_BRIDGE_WIDTH = (((LID_RAD/2)-3)*2)-LOWER_ARM_BRACE_WIDTH+(ELBOW_ARM_BRACE_WIDTH*2);
ELBOW_ARM_BRIDGE_HEIGHT = LOWER_ARM_BRACE_THIC;
//elbow bracket constants
mountBracketLength = LOWER_ARM_OUTER_LENGTH/3;
mountBracketWidth = 3;
mountBracketHeight = LOWER_ARM_BRACE_HT + 9.2;
bracketFlangeWidth = 20;//mm 
bracketFlangeHeight = 3;//mm
//support rail constants
railBracketLength = bracketFlangeWidth+8;
railBracketWidth = ELBOW_ARM_BRIDGE_WIDTH-12;
railBracketHeight = 5;
railBracketXTrans = ELBOW_ARM_OUTER_LENGTH/2.5;
railBracketZTrans = (LOWER_ARM_BRACE_THIC/2)+railBracketHeight-bracketFlangeHeight+1;
magStripLength = 19.2;//mm
magStripWidth = 6.5;//mm
magStripHeight = 3.25;//mm
supportRailZTrans = 3.55;//3.55 - NORMAL DISTANCE
supportRailCentralBracketLength = magStripLength+.5;
//rail piston attachment constants
centralRailRadius = 4;//mm
YMountThickness = 5;
capRadius = 5.4;


//translation constants
capZHeightTrans = 11.3;//mm
capXRotationDegree = 0;
capYRotationDegree = 0;
capZRotationDegree = 0;
capXTrans = 0;
capYTrans = 0;
capZTrans = 0;

/* These translations will position the cap manget mount along the rail
capZHeightTrans = 13.3;//mm
capXRotationDegree = -90;
capYRotationDegree = 0;
capZRotationDegree = 90;
capXTrans = 25;
capYTrans = 0;
capZTrans = 29.5;
*/


_yOffset = 4;
_sideRes=200;


main();

module main(){
    union(){
        translate([capXTrans, capYTrans, capZTrans]) {
            rotate([capXRotationDegree,capYRotationDegree,capZRotationDegree]){
                magneticAttachementMain();
            }
        }
        translate([0, 0, -2.5]){
            //supportRailCentralRailBracket();
        } 
    }
}

module magneticAttachementMain(){
    union(){ 
        importThreadedPistonAttachment();
        translate([0,0,capZHeightTrans]){
            capMountingBase();
            railMountYBrace();
        }
    }
}

module capMountingBase(){
    union(){
        cylinder(r=capRadius, h=3, center=true, $fn=6);
        //rounded tip
        translate([0, 0, (capRadius/2)-1.5]) {
            difference(){
                sphere(r=capRadius-.75, $fn=_sideRes);
                translate([0,0,(-capRadius)]){
                    cube(capRadius*2, center=true);
                }
            }
        }
        //end rounded tip

        //join with YBrace
        translate([0, 5, 5]) {
            rotate([-45, 0, 0]) {
                cylinder(r=3, h=8, center=true, $fn=_sideRes);
            }
        }
        //end join
    }
}

module railMountYBrace(){
    yMountZTrans = 2.5;
    yMountYTrans = 0;
    union(){
        translate([0,yMountYTrans,yMountZTrans]){
            //y base attachment
        
            //end base attach
            //y brace main join shape
            translate([0, 14, 5.8]){
                difference(){
                    cylinder(r=centralRailRadius+YMountThickness, h=5, center=true, $fn=_sideRes);
                    //central rail fit
                    cylinder(r=centralRailRadius, h=supportRailCentralBracketLength, center=true, $fn=_sideRes);
                    //end centrail rail fit
                    //halfing for magnet inset arms
                    translate([0,(centralRailRadius+YMountThickness+.1)/2,0]){
                        cube([centralRailRadius*5, centralRailRadius+YMountThickness, 8], center=true);
                    }
                    //end halfing
                }
            }
            //end y brace main join shape
            //left magnetic mounting
            yExtensionLength = 4;
            translate([(centralRailRadius)+(YMountThickness/2), yExtensionLength, 0]){
                union(){
                    translate([0, (YMountThickness+centralRailRadius*2)-(yExtensionLength/2)+.2, 5.8]){
                        cube([YMountThickness,yExtensionLength,YMountThickness], center=true);
                    } 
                    YBraceMagnetMount();
                }
            } 
            //end left magnetic mounting
            //right magnetic mounting
            translate([-(centralRailRadius)-(YMountThickness/2),yExtensionLength,0]){
                union(){
                    mirror([1, 0, 0]) {
                          union(){
                            translate([0, (YMountThickness+centralRailRadius*2)-(yExtensionLength/2)+.2, 5.8]){
                                cube([YMountThickness,yExtensionLength,YMountThickness], center=true);
                            } 
                            YBraceMagnetMount();
                        }
                    }
                }
            }
            //end right magnetic mounting  
        }
    }
}

module YBraceMagnetMount(){
    fullSlotMagnetWidth = 5.05;//mm
    fullSlotMagnetLength = 8.35;//mm
    magnetSlotWidth = 1.7;//mm
    slotMagnetFaceLength = 6.5;//mm
    slotMagnetHeight = 6.8;//mm
    magnetSlotLength = (fullSlotMagnetLength-slotMagnetFaceLength)/2;//mm

    translate([1, 16, 5.8]) {
        difference(){
            cube([(centralRailRadius+3), centralRailRadius+2, fullSlotMagnetLength+1.5], center=true);
            //magnet stand-in
            translate([.5, .8, 0]) {
                union(){
                    cube([slotMagnetFaceLength,fullSlotMagnetWidth, slotMagnetHeight], center=true);
                    //slot cut out
                    cube([slotMagnetFaceLength, magnetSlotWidth, fullSlotMagnetLength], center=true);
                    //end slot cut out
                }
            }
            //end magnet stand-in
        }
        
       //taper join triangle set
        union(){
            //upper triangle taper join
            translate([-3.5, -2.99, 2.5]){
                rotate([180, -90, 0]) {
                    triangle(centralRailRadius-2,(centralRailRadius+3)-4.55,5);
                }
            } 
            //end upper taper join

            //lower taper join
            mirror([0,0,1]){
                translate([-3.5, -2.99, 2.5]){
                    rotate([180, -90, 0]) {
                        triangle(centralRailRadius-2,(centralRailRadius+3)-4.55,5);
                    }
                } 
            }
            //end lower taper join

            //outside (vertical) join
            difference(){
                translate([1.5,-3, -(fullSlotMagnetLength+5)/2.7]){
                    rotate([0,0,-90]){
                        triangle(2,1.7,fullSlotMagnetLength+1.56);
                    }
                } 
                //edge trimming 
                translate([0,-4.5,4.3]){
                    rotate([-39, 0, 0]){
                        cube([fullSlotMagnetLength, 1.5, 3], center=true);
                    } 
                }

                mirror([0,0,1]){
                     translate([0,-4.5,4.3]){
                        rotate([-39, 0, 0]){
                            cube([fullSlotMagnetLength, 1.5, 3], center=true);
                        } 
                    }
                }
                //end edge trimming

            }
            //end outside join

            //fill cylinder for vertical join
            scale([1, 1.1, 1]) {
                translate([1.25, -4.1, 0]){
                    cylinder(r=.55, h=fullSlotMagnetLength-2.5, center=true, $fn=_sideRes);
                    translate([0, 0, (fullSlotMagnetLength-2.5)/2]){
                        sphere(r=.55, $fn=_sideRes);
                    } 
                    translate([0, 0, -(fullSlotMagnetLength-2.5)/2]){
                        sphere(r=.55, $fn=_sideRes);
                    } 
                } 
            }
            //end fill cylinder
        }
        //end taper join set
        
    }  
}

module importThreadedPistonAttachment(){
    import("E:/Programerinos/userSave/[UTILITY]m6capV3Hex.stl");
}

module supportRailCentralRailBracket(){
    difference(){
        union(){
            //magnet stabilizer and base plate
            translate([0,0,supportRailZTrans]){
                //central mount
                union(){
                    difference(){
                        cube([supportRailCentralBracketLength, magStripWidth+3, 2], center=true);
                        //central screw mount
                        cylinder(r=MTR_SCREW_RAD+.2, h=2.5, center=true, $fn=_sideRes);
                        translate([0,0,.7]){
                            cylinder(r=MTR_SCREW_COUNTERSINK_RAD, h=2.5, center=true, $fn=_sideRes);
                        }
                        //end central screw mount
                    }
                    //right triangles magnet taper support
                    translate([(-magStripLength/2)-.25,magStripWidth-1.75,-1]){
                        rotate([90,0,90]){
                            triangle(2,2.5,supportRailCentralBracketLength);
                        }
                    }

                    translate([(magStripLength/2)+.25,-magStripWidth+1.75,-1]){
                        rotate([90,0,-90]){
                            triangle(2,2.5,supportRailCentralBracketLength);
                        }
                    }
                    //end taper support
                }
                //end central mount
            }

            translate([0,(magStripWidth*2)+3.65,supportRailZTrans]){
                //right hand side (from positive quadrant perspective)
               outerBacketSupportEdge();
                //end right hand side
            }

             translate([0,-(magStripWidth*2)-3,supportRailZTrans]){
                 //left hand side
                 mirror([0, 1, 0]) {
                      outerBacketSupportEdge();
                 }
                //end left hand side
            }
            //end magnet stabilizer and base plate
            //triangle brace and central rail
            
            railHeight = 20;
            translate([0,0,supportRailZTrans-railHeight/2]){
                 //central rail cylinder
                difference(){
                    union(){
                        translate([0,0,railHeight]){
                            rotate([0, 90, 0]) {
                                cylinder(r=4, h=supportRailCentralBracketLength, center=true, $fn=_sideRes);
                            }

                            //support cylinders
                            translate([-4,0,-5]){
                                rotate([0, 45, 0]) {
                                    cylinder(r=1.2, h=(supportRailCentralBracketLength/2)+2.5, center=true, $fn=_sideRes);
                                }
                                translate([-2, 0, 2]) {
                                    rotate([0, -45, 0]) {
                                        cylinder(r=1.2, h=(supportRailCentralBracketLength/2)/1.8, center=true, $fn=_sideRes);
                                    }
                                }
                            
                            }
                            translate([4,0,-5]){
                                rotate([0, -45, 0]) {
                                    cylinder(r=1.2, h=(supportRailCentralBracketLength/2)+2.5, center=true, $fn=_sideRes);
                                }
                                translate([2, 0, 2]) {
                                    rotate([0, 45, 0]) {
                                        cylinder(r=1.2, h=(supportRailCentralBracketLength/2)/1.8, center=true, $fn=_sideRes);
                                    }
                                }
                            }
                        }
                    }
                    //central screw pass through
                    translate([0,0,railHeight]){
                        cylinder(r=2.9, h=25, center=true, $fn=_sideRes);
                    }

                }
                //end central rail cylinder
                 //rail outside braces
                translate([0, 8, (railHeight-5)]) {
                    railOutsideHypotenuseBrace();
                }
                translate([0, -8, (railHeight-5)]) {
                    mirror([0,1,0]){
                        railOutsideHypotenuseBrace();
                    }
                }
                //end outside braces
                //central vertical brace
                translate([0,0,14]){
                    difference(){
                        cube([supportRailCentralBracketLength, 2.5, 10], center=true);
                        cube(size=[supportRailCentralBracketLength-2, 3, 20], center=true);
                    }
                }
                //end central vertical brace

                //extra support V braces
                translate([0,-4,12.6]){
                    rotate([45, 0, 0]) {
                         difference(){
                            cube([supportRailCentralBracketLength, 2.5, 7.5], center=true);
                            cube(size=[supportRailCentralBracketLength-2, 3, 20], center=true);
                        }
                    }
                }
                mirror([0,1,0]){
                    translate([0,-4,12.6]){
                        rotate([45, 0, 0]) {
                            difference(){
                                cube([supportRailCentralBracketLength, 2.5, 7.5], center=true);
                                cube(size=[supportRailCentralBracketLength-2, 3, 20], center=true);
                            }
                        }
                    }
                }
                //end extra support V braces

            }
          
            //end triangle brace and central rail
        }      
    }
}

module railOutsideHypotenuseBrace(){
    rotate([55, 0, 0]) {
            difference(){
                cube([supportRailCentralBracketLength, 2.5, 17.5], center=true);
                cube(size=[supportRailCentralBracketLength-3, 3, 20], center=true);
                translate([0, 0, -10]) {
                    rotate([-55,0,0]){
                        cube([supportRailCentralBracketLength+1,4,1],center=true);
                    }
                }
            }
        }
}

module outerBacketSupportEdge(){
    union(){
        translate([0, 0, 1]) {
            cube([supportRailCentralBracketLength, magStripWidth/2, 4], center=true);
        }
        //right hand triangle taper
        translate([(magStripLength/2)+.25,-magStripWidth/4,-1]){
            rotate([90,0,-90]){
                triangle(2,2.5,supportRailCentralBracketLength);
            }
        }
        //end right hand triangle taper
    }
}

/**
 * Standard right-angled triangle
 *
 * @param number  o_len  Length of the opposite side
 * @param number  a_len  Length of the adjacent side
 * @param number  depth  How wide/deep the triangle is in the 3rd dimension
 * @param boolean center Whether to center the triangle on the origin
 * @todo a better way ?
 */
module triangle(o_len, a_len, depth, center=false)
{
    centroid = center ? [-a_len/3, -o_len/3, -depth/2] : [0, 0, 0];
    translate(centroid) linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}