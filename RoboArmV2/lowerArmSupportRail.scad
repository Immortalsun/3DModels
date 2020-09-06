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
_sideRes=200;
//translation constants
_yOffset = 4;
main();

module main(){
    union(){
        //importLowerArm();
        //supportRailMountBracketMain();
        // mirror([0,1,0]){
        //     supportRailMountBracketMain();
        // }
        supportRailMain();
        // mirror([0, 0, 1]) {
        //     supportRailMain();
        // }
    }
}

module importLowerArm(){
    import("E:/Programerinos/userSave/RoboArm/drawings/rb_elbow_Mountv10.stl");
}

module supportRailMain(){
    railBracketLength = bracketFlangeWidth+8;
    railBracketWidth = ELBOW_ARM_BRIDGE_WIDTH-12;
    railBracketHeight = 5;
    railBracketXTrans = ELBOW_ARM_OUTER_LENGTH/2.5;
    railBracketZTrans = (LOWER_ARM_BRACE_THIC/2)+railBracketHeight-bracketFlangeHeight+1;
    union(){
        translate([railBracketXTrans,0,railBracketZTrans]){
            union(){
                //base mounting plate
                difference(){
                    //main bracket shape
                    cube([railBracketLength,railBracketWidth,railBracketHeight],center=true);

                    //mount bracket inset
                    //the brackets are translated relative to the arm, they 
                    //need to be backed out from the translations in this scope
                    translate([-railBracketXTrans,0,-railBracketZTrans]){
                        //very slight scaling to make fitting simpler
                        scale([1,1.02,1.01]){
                            supportRailMountBracketMain(true);
                        }
                        mirror([0,1,0]){
                            scale([1, 1.02, 1.01]) {
                                supportRailMountBracketMain(true);
                            }
                        }
                    }
                    //end mount bracket inset

                    //central hole for mounting
                    translate([0,0,2]){
                        union(){
                            cylinder(r=MTR_SCREW_COUNTERSINK_RAD, h=3, center=true, $fn=_sideRes);
                            translate([0,0,0]){
                                cylinder(r=MTR_SCREW_RAD, h=15, center=true, $fn=_sideRes);
                            }
                        }
                    }
                    //end central hole
                }
                //end mounting plate

                //rail and piston attachment 
                union(){
                    //endstop braces and rail points
                    translate([(railBracketLength/2)-2, 0, 4]) {
                        cube([4,railBracketWidth/2, 5], center=true);
                        translate([-1.9,0, -1.9]){
                            rotate([90, 0, 0]) {
                                quarterCylinder(4, 1.5,railBracketWidth/2);
                            }
                        } 
                        //central brace triangle
                        translate([0, 0, 4]) {
                            rotate([0, -90, 0]) {
                                difference(){
                                     cylinder(r=10, h=railBracketHeight-1, center=true, $fn=3);
                                     translate([6.5, 0, 0]){
                                         cube([7,25,5],center=true);
                                     } 
                                }
                               
                            }
                        }
                        //side triangles
                        translate([0, (railBracketWidth/2)/4, 4]) {
                            rotate([0, -90, 0]) {
                                difference(){
                                    cylinder(r=5, h=railBracketHeight-1, center=true, $fn=3);
                                    translate([6.5, 0, 0]){
                                        cube([7,25,5],center=true);
                                    } 
                                }
                            }
                        }
                        translate([0, -(railBracketWidth/2)/4, 4]) {
                            rotate([0, -90, 0]) {
                                 difference(){
                                    cylinder(r=5, h=railBracketHeight-1, center=true, $fn=3);
                                    translate([6.5, 0, 0]){
                                        cube([7,25,5],center=true);
                                    } 
                                }
                            }
                        }
                        //end side triangles
                    }
                     translate([-(railBracketLength/2)+2, 0, 4]) {
                        cube([4,railBracketWidth/2, 5], center=true);
                        translate([1.9,0, -1.9]){
                            rotate([90, 0, 0]) {
                                quarterCylinder(1, 1.5,railBracketWidth/2);
                            }
                        } 
                        //central brace triangle
                        translate([0, 0, 4]) {
                            rotate([0, -90, 0]) {
                                difference(){
                                     cylinder(r=10, h=railBracketHeight-1, center=true, $fn=3);
                                     translate([6.5, 0, 0]){
                                         cube([7,25,5],center=true);
                                     } 
                                }
                               
                            }
                        }
                        //side triangles
                        translate([0, (railBracketWidth/2)/4, 4]) {
                            rotate([0, -90, 0]) {
                                difference(){
                                    cylinder(r=5, h=railBracketHeight-1, center=true, $fn=3);
                                    translate([6.5, 0, 0]){
                                        cube([7,25,5],center=true);
                                    } 
                                }
                            }
                        }
                        translate([0, -(railBracketWidth/2)/4, 4]) {
                            rotate([0, -90, 0]) {
                                 difference(){
                                    cylinder(r=5, h=railBracketHeight-1, center=true, $fn=3);
                                    translate([6.5, 0, 0]){
                                        cube([7,25,5],center=true);
                                    } 
                                }
                            }
                        }
                        //end side triangles
                    }
                    //end endstop braces and rail points
                    
                    //rail arrangement
                    
                }
                //end rail and piston attachment
            }
        }
    }

}

module supportRailMountBracketMain(isInset){
    union(){
        translate([LOWER_ARM_OUTER_LENGTH/2.2,((ELBOW_ARM_BRIDGE_WIDTH/2)+mountBracketWidth*2)+_yOffset, 0]) {
            supportRailMountBracket(isInset);
        }
    }
}

//inset param just toggles whether the screw holes for mounting
//are differenced cylinders or not
module supportRailMountBracket(isInset){ 
    
    bracketSpacingZOffset = .4;
    union(){
        //main bracket
        cube([mountBracketLength, mountBracketWidth, mountBracketHeight-6], center=true);
        //top flange
        translate([0, (-bracketFlangeWidth/2)-1.4, (mountBracketHeight/2)-(bracketFlangeHeight/2)]){
             supportBracketFlange(true,isInset);
        }
        //bottom flange
        translate([0, (-bracketFlangeWidth/2)-1.4, -(mountBracketHeight/2)+(bracketFlangeHeight/2)]){
            supportBracketFlange(false, isInset);
        }

    }
}

module supportBracketFlange(isTop, isInset){
    if(!isInset){
        difference(){
            difference(){
                union(){
                    cube([mountBracketLength, bracketFlangeWidth, bracketFlangeHeight],center=true);
                    translate([0, -bracketFlangeWidth+2.8, 0]){
                        rotate([0, 0, 30]){
                            cylinder(r=(mountBracketLength/2)+1.95, h=bracketFlangeHeight, center=true, $fn=3);
                        } 
                    }
                    //screw mount tabs
                    screwTabLength = mountBracketLength+25;
                    translate([0, 1.7, 0]) {
                        difference(){
                            cube([screwTabLength,ELBOW_ARM_BRACE_THIC/1.5,bracketFlangeHeight],center=true);
                            //screwholes for attaching to arm
                            translate([(screwTabLength/2)-MTR_SCREW_RAD*2.45,-.3,0]){
                                cylinder(r=MTR_SCREW_RAD+.5, h=mountBracketHeight+5, center=true, $fn=_sideRes);
                            }
                            translate([-(screwTabLength/2)+MTR_SCREW_RAD*2.6,-.3,0]){
                                cylinder(r=MTR_SCREW_RAD+.5, h=mountBracketHeight+5, center=true, $fn=_sideRes);
                            }
                            //end screwHoles

                            //trim inner edges
                            translate([bracketFlangeWidth+5,(-bracketFlangeWidth/2)+3,0]){
                                rotate([0,0,60]){
                                    cube([10,5.8,30],center=true);
                                }
                            }

                            translate([-bracketFlangeWidth-5,(-bracketFlangeWidth/2)+3,0]){
                                rotate([0,0,-60]){
                                    cube([10,5.8,30],center=true);
                                }
                            }
                            //end trim
                        }
                    }
                    //end mount tabs

                    //quarter cylinder join
                    if(isTop == true){
                    translate([0,(bracketFlangeWidth/2)-.1,-1.51]){
                            rotate([0,90,0]){
                                quarterCylinder(4,3,mountBracketLength);
                            }
                        } 
                    }
                    else{
                        translate([0,(bracketFlangeWidth/2)-.1,+1.51]){
                            rotate([0,90,0]){
                                quarterCylinder(1,3,mountBracketLength);
                            }
                        } 
                    }
                }
                 //centeral point trim
                translate([0,-bracketFlangeWidth-9,0]){
                    cube([10,10,20], center=true);
                }
                //end trim
            }

            //rail central mount holes
            railControlMountHoles();
            //end central mount holes
        }
    }
    else{
        union(){
            difference(){
                union(){
                    cube([mountBracketLength, bracketFlangeWidth, bracketFlangeHeight],center=true);
                    translate([0, -bracketFlangeWidth+2.8, 0]){
                        rotate([0, 0, 30]){
                            cylinder(r=(mountBracketLength/2)+1.95, h=bracketFlangeHeight, center=true, $fn=3);
                        } 
                    }
                    //screw mount tabs
                    screwTabLength = mountBracketLength+25;
                    translate([0, 1.7, 0]) {
                        difference(){
                            cube([screwTabLength,ELBOW_ARM_BRACE_THIC/1.5,bracketFlangeHeight],center=true);
                            //screwholes for attaching to arm
                            translate([(screwTabLength/2)-MTR_SCREW_RAD*2.45,-.3,0]){
                                cylinder(r=MTR_SCREW_RAD+.5, h=mountBracketHeight+5, center=true, $fn=_sideRes);
                            }
                            translate([-(screwTabLength/2)+MTR_SCREW_RAD*2.6,-.3,0]){
                                cylinder(r=MTR_SCREW_RAD+.5, h=mountBracketHeight+5, center=true, $fn=_sideRes);
                            }
                            //end screwHoles

                            //trim inner edges
                            translate([bracketFlangeWidth+5,(-bracketFlangeWidth/2)+3,0]){
                                rotate([0,0,60]){
                                    cube([10,5.8,30],center=true);
                                }
                            }

                            translate([-bracketFlangeWidth-5,(-bracketFlangeWidth/2)+3,0]){
                                rotate([0,0,-60]){
                                    cube([10,5.8,30],center=true);
                                }
                            }
                            //end trim
                        }
                    }
                    //end mount tabs

                    //quarter cylinder join
                    if(isTop == true){
                    translate([0,(bracketFlangeWidth/2)-.1,-1.51]){
                            rotate([0,90,0]){
                                quarterCylinder(4,3,mountBracketLength);
                            }
                        } 
                    }
                    else{
                        translate([0,(bracketFlangeWidth/2)-.1,+1.51]){
                            rotate([0,90,0]){
                                quarterCylinder(1,3,mountBracketLength);
                            }
                        } 
                    }
                }
                //centeral point trim
                translate([0,-bracketFlangeWidth-9,0]){
                    cube([10,10,20], center=true);
                }
                //end trim
            }
            //rail central mount holes
            railControlMountHoles();
            //end central mount holes
        }
    }
}

module railControlMountHoles(){
    union(){
        translate([-8,-bracketFlangeWidth/2,0]){
            rotate([0, 0, 0]){
                cylinder(r=MTR_SCREW_RAD+.2, h=mountBracketHeight/2, center=true, $fn=_sideRes);
            }
        }

        translate([0,(-bracketFlangeWidth/2)-10,0]){
            rotate([0, 0, 0]){
                cylinder(r=MTR_SCREW_RAD+.2, h=mountBracketHeight/2, center=true, $fn=_sideRes);
            }
        }

        translate([8,(-bracketFlangeWidth/2),0]){
            rotate([0, 0, 0]){
                cylinder(r=MTR_SCREW_RAD+.2, h=mountBracketHeight/2, center=true, $fn=_sideRes);
            }
        }
    }
}

module halfCylinder(quadrant=1,radius=5,height=5){
    union(){

    }
}

module quarterCylinder(quadrant = 1, radius = 5, height = 15){
    radiusBuffer = .01;
    difference(){
        cylinder(r=radius, h=height, center=true, $fn=_sideRes);
        if(quadrant == 1){
            translate([-radius/2,0,0]){
                cube([radius+radiusBuffer, (radius*2)+radiusBuffer, height*1.5], center=true);
            }
            translate([0,-radius/2,0]){
                cube([(radius*2)+radiusBuffer,radius+radiusBuffer, height*1.5], center=true);
            }
        }
        else if(quadrant == 2){
            translate([-radius/2,0,0]){
                cube([radius+radiusBuffer, (radius*2)+radiusBuffer, height*1.5], center=true);
            }
            translate([0,radius/2,0]){
                cube([(radius*2)+radiusBuffer,radius+radiusBuffer, height*1.5], center=true);
            }
        }
        else if(quadrant == 3){
            translate([radius/2,0,0]){
                 cube([radius+radiusBuffer, (radius*2)+radiusBuffer, height*1.5], center=true);
            }
            translate([0,radius/2,0]){
                 cube([(radius*2)+radiusBuffer,radius+radiusBuffer, height*1.5], center=true);
            }
        }
         else if(quadrant == 4){
            translate([radius/2,0,0]){
               cube([radius+radiusBuffer, (radius*2)+radiusBuffer, height*1.5], center=true);
            }
            translate([0,-radius/2,0]){
                 cube([(radius*2)+radiusBuffer,radius+radiusBuffer, height*1.5], center=true);
            }
        }
        
    }
}
