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

//Motor Flange mount params//
FLANGE_MOUNT_RADIUS = 15.5;//mm

//Shoulder Axle params
AXLE_RAD = 5.25;//mm
AXLE_HEIGHT = MOUNT_OUTER_WIDTH+(BEARING_HEIGHT*14);
SUPPORT_HEIGHT = 75;
//Arm mount params
ARM_MOUNT_HEIGHT = MOUNT_OUTER_WIDTH-(BEARING_HEIGHT*2)-15;
ARM_SHLDR_ELBW_HEIGHT = 175;
//global constants
_sideRes = 300;
_hollowLengthOffset = 5;//mm
_holeRadiusOffset = .2;//mm
_yAxisJoinDepth = .2;
//part translations
lowerArmXTrans = 0;
lowerArmYTrans = (LID_RAD/2)-3;
lowerArmZTrans = MOUNT_OUTER_HEIGHT/2+MOTOR_SHAFT_RADIUS/1.5;
motorYTransBuffer = 33.03;
motorZTransBuffer = 5;
//end part translations
main();

module main(){
    //import("E:/Programerinos/userSave/RoboArm/drawings/rb_LIDv3.stl");
    difference(){
        union(){
            //shoulderMain();
            lowerArmMain();
        }
        //crossSection(50);
    }
}

module shoulderMain(){
    difference(){
        union(){
             //begin main mount structure
            translate([0, 0, (MOUNT_OUTER_HEIGHT/2)+LID_HEIGHT]){
                shoulderBracketMotorWall();
                mirror([0, 1, 0]) {
                    shoulderBracketMotorWall();
                }
            }

             rearWallLimitSwitchScrewZTrans = MOUNT_OUTER_HEIGHT/12;
            //front and rear walls
            translate([(LID_RAD/2)+8.5, 0, (MOUNT_OUTER_HEIGHT/4)])  {
               
                difference(){
                    cube([MOUNT_WALL_THICKNESS/2, MOUNT_OUTER_WIDTH+5, MOUNT_OUTER_HEIGHT/2],center=true);

                 translate([0, 0, rearWallLimitSwitchScrewZTrans]) {
                    rotate([0, 90, 0]) {
                         cylinder(r=MTR_SCREW_RAD, h=MOUNT_WALL_THICKNESS, $fn=_sideRes, center=true);
                    }
                 }

                   translate([0, MOUNT_OUTER_WIDTH/6,rearWallLimitSwitchScrewZTrans]) {
                        rotate([0, 90, 0]) {
                            cylinder(r=MTR_SCREW_RAD, h=MOUNT_WALL_THICKNESS, $fn=_sideRes, center=true);
                        }
                   }

                   translate([0, -MOUNT_OUTER_WIDTH/6, rearWallLimitSwitchScrewZTrans]) {
                        rotate([0, 90, 0]) {
                            cylinder(r=MTR_SCREW_RAD, h=MOUNT_WALL_THICKNESS, $fn=_sideRes, center=true);
                        }
                   }

                   
                }
            }

            translate([-(LID_RAD/2)-8.5, 0, (MOUNT_OUTER_HEIGHT/4)])  {
                difference(){
                    cube([MOUNT_WALL_THICKNESS/2, MOUNT_OUTER_WIDTH+5, MOUNT_OUTER_HEIGHT/2],center=true);
                    
                    translate([0, 0, rearWallLimitSwitchScrewZTrans]) {
                        rotate([0, 90, 0]) {
                            cylinder(r=MTR_SCREW_RAD, h=MOUNT_WALL_THICKNESS, $fn=_sideRes, center=true);
                        }
                    }

                    translate([0, MOUNT_OUTER_WIDTH/6,rearWallLimitSwitchScrewZTrans]) {
                            rotate([0, 90, 0]) {
                                cylinder(r=MTR_SCREW_RAD, h=MOUNT_WALL_THICKNESS, $fn=_sideRes, center=true);
                            }
                    }

                    translate([0, -MOUNT_OUTER_WIDTH/6, rearWallLimitSwitchScrewZTrans]) {
                            rotate([0, 90, 0]) {
                                cylinder(r=MTR_SCREW_RAD, h=MOUNT_WALL_THICKNESS, $fn=_sideRes, center=true);
                            }
                    }
                }
            }
            //end front and rear walls
            //end main mount structure
        }
       

        //motor difference for mounts
        translate([0, MOTOR_HEIGHT+motorYTransBuffer, ((MOTOR_WIDTH/2)+LID_HEIGHT)+motorZTransBuffer]) {
            rotate([90, 0, 0]) {
                motorStandIn();
            }
        }

        mirror([0, 1, 0]) {
             translate([0, MOTOR_HEIGHT+motorYTransBuffer, ((MOTOR_WIDTH/2)+LID_HEIGHT)+motorZTransBuffer]) {
                rotate([90, 0, 0]) {
                    motorStandIn();
                }
            }
        }
        //end motor difference for mounts

    }
}

module lowerArmMain(){
    translate([lowerArmXTrans,lowerArmYTrans,lowerArmZTrans]) {
         difference(){
            union(){
                //motor attachment for left and right motors
                lowerArmMotorAttachment();
                
                translate([0, (-lowerArmYTrans)*2, 0]) {
                    rotate([180,0,0]){
                        lowerArmMotorAttachment();
                    }
                }
                //end motor attachment\

                //begin bridge
                lowerArmBridge();
                //end bridge

                //begin lower arm central support
                centralXSupport();
                //end central support
                
            }
            //begin screw/fastening arrangements to difference from entire object

        }
    }
}

module lowerArmBridge(){
    translate([LOWER_ARM_OUTER_LENGTH+LOWER_ARM_BRACE_WALL+LOWER_ARM_BRIDGE_LENGTH, (-LOWER_ARM_BRIDGE_WIDTH/2)-LOWER_ARM_BRACE_WIDTH/2, 0]) {
        difference(){
            union(){
                cube([LOWER_ARM_BRIDGE_LENGTH, LOWER_ARM_BRIDGE_WIDTH+_yAxisJoinDepth, LOWER_ARM_BRIDGE_HEIGHT], center=true);
                translate([-LOWER_ARM_BRIDGE_LENGTH/2,LOWER_ARM_BRIDGE_WIDTH/2,0]){
                    quarterCylinder(1,LOWER_ARM_BRACE_WIDTH, LOWER_ARM_BRIDGE_HEIGHT);
                }
                translate([-LOWER_ARM_BRIDGE_LENGTH/2,-LOWER_ARM_BRIDGE_WIDTH/2,0]){
                    quarterCylinder(2,LOWER_ARM_BRACE_WIDTH, LOWER_ARM_BRIDGE_HEIGHT);
                }
            }

            YAxlisAlignedScrewHoleInterval = ((LOWER_ARM_BRIDGE_WIDTH+_yAxisJoinDepth)/3)-5;
            ZAxisAlignedScrewHoleInterval = (LOWER_ARM_BRIDGE_HEIGHT/3);
            translate([0,-YAxlisAlignedScrewHoleInterval,0]){
                for(i=[0:2]){
                    translate([0,YAxlisAlignedScrewHoleInterval*i,0]){
                        rotate([0,90,0]){
                            cylinder(r=MTR_SCREW_RAD, h=LOWER_ARM_BRIDGE_HEIGHT+5, $fn=_sideRes, center=true);
                        }
                    }
                }
            }

            translate([0, 0, -ZAxisAlignedScrewHoleInterval]) {
                for(i=[0:2]){
                    translate([0, 0, ZAxisAlignedScrewHoleInterval*i]) {
                        rotate([0,90,0]){
                            cylinder(r=MTR_SCREW_RAD, h=LOWER_ARM_BRIDGE_HEIGHT+5, $fn=_sideRes, center=true);
                        }
                    }
                }
            }
        }
    }
}

module centralXSupport(){
    centralXBuffer = LOWER_ARM_OUTER_LENGTH*_yAxisJoinDepth;
    translate([MOUNT_OUTER_LENGTH/2,-lowerArmYTrans,0]){
        difference(){
                union(){
                    rotate([0, 0, 45]) {
                        union(){
                            difference(){
                                cube([LOWER_ARM_OUTER_LENGTH+centralXBuffer, LOWER_ARM_BRACE_WIDTH, LOWER_ARM_BRACE_THIC], center=true);
                                //hollow for brace inserts

                                cube([LOWER_ARM_OUTER_LENGTH-LOWER_ARM_BRACE_WALL, LOWER_ARM_BRACE_WIDTH+LOWER_ARM_BRACE_WALL, LOWER_ARM_BRACE_THIC-LOWER_ARM_BRACE_WALL], center=true);
                                //end brace
                            }

                            // translate([(-(LOWER_ARM_OUTER_LENGTH+centralXBuffer)/2)+_yAxisJoinDepth,(LOWER_ARM_BRACE_WIDTH/2),0]) {
                            //     quarterCylinder(3,LOWER_ARM_BRACE_WIDTH,LOWER_ARM_BRACE_THIC);
                            // }

                          
                        
                            //triangular brace cutouts
                            braceInterval=LOWER_ARM_OUTER_LENGTH/3;
                            translate([-braceInterval,0,0]){
                                for(i=[0:2]){
                                    translate([braceInterval*i,0,0]){
                                        lowerArmXBraceSupport();
                                    }
                                }
                            }
                            //end brace cutouts
                        }
                    }
                    rotate([0, 0, -45]) {
                        union(){
                            difference(){
                                cube([LOWER_ARM_OUTER_LENGTH+centralXBuffer, LOWER_ARM_BRACE_WIDTH, LOWER_ARM_BRACE_THIC], center=true);
                                //hollow for brace inserts

                                cube([LOWER_ARM_OUTER_LENGTH-LOWER_ARM_BRACE_WALL, LOWER_ARM_BRACE_WIDTH+LOWER_ARM_BRACE_WALL, LOWER_ARM_BRACE_THIC-LOWER_ARM_BRACE_WALL], center=true);
                                //end brace
                            }

                           
                            //triangular brace cutouts
                            braceInterval=LOWER_ARM_OUTER_LENGTH/3;
                            translate([-braceInterval,0,0]){
                                for(i=[0:2]){
                                    translate([braceInterval*i,0,0]){
                                        lowerArmXBraceSupport();
                                    }
                                }
                            }
                            //end brace cutouts
                        }
                }

                cylinder(r=MTR_SCREW_RAD+6, h=LOWER_ARM_BRIDGE_HEIGHT, center=true, $fn=_sideRes);
            }
        cylinder(r=MTR_SCREW_RAD, h=LOWER_ARM_BRIDGE_HEIGHT+10, center=true, $fn=_sideRes);
        
        }
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

module lowerArmMotorAttachment(){
   flangeSinkPercentage = .65;
   union(){
        motorAxleFlangeConnector();
        translate([(LOWER_ARM_OUTER_LENGTH/2)+(FLANGE_MOUNT_RADIUS*(flangeSinkPercentage)),0,0]){
            difference(){
                lowerBraceArm();
                translate([-((LOWER_ARM_OUTER_LENGTH/2)+(FLANGE_MOUNT_RADIUS*(flangeSinkPercentage))),0,0]){
                    rotate([-90, 0, 0]) {
                    cylinder(r=FLANGE_MOUNT_RADIUS, h=LOWER_ARM_BRACE_THIC+2, $fn=_sideRes, center=true);
                    }
                }
            }   
        }
    }
}

module lowerBraceArm(){
    union(){
        //lower brace arm
          union(){
            difference(){
                cube([LOWER_ARM_OUTER_LENGTH, LOWER_ARM_BRACE_WIDTH, LOWER_ARM_BRACE_THIC], center=true);
                //hollow for brace inserts

                cube([LOWER_ARM_OUTER_LENGTH-LOWER_ARM_BRACE_WALL, LOWER_ARM_BRACE_WIDTH+LOWER_ARM_BRACE_WALL, LOWER_ARM_BRACE_THIC-LOWER_ARM_BRACE_WALL], center=true);
                //end brace
            }
           
            //triangular brace cutouts
            braceInterval=LOWER_ARM_OUTER_LENGTH/3;
            translate([-braceInterval,0,0]){
                 for(i=[0:2]){
                    translate([braceInterval*i,0,0]){
                        lowerArmXBraceSupport();
                    }
                }
            }
            //end brace cutouts
        }
        //end lower brace arm
    }
}

module lowerArmXBraceSupport(){
    flangeSinkPercentage = .05;
    union(){
         rotate([0,45,0]){
            cube([(LOWER_ARM_OUTER_LENGTH/3)+(LOWER_ARM_OUTER_LENGTH*flangeSinkPercentage),LOWER_ARM_BRACE_WIDTH, 3.5], center=true);
        }
        rotate([0,-45,0]){
            cube([(LOWER_ARM_OUTER_LENGTH/3)+(LOWER_ARM_OUTER_LENGTH*flangeSinkPercentage),LOWER_ARM_BRACE_WIDTH, 3.5], center=true);
        }
    }
   
}


module motorAxleFlangeConnector(){
    union(){
        difference(){
            rotate([-90, 0, 0]) {
                cylinder(r=FLANGE_MOUNT_RADIUS, h=10, center=true, $fn=_sideRes);
            }
            
            rotate([-90, 0, 0]) {
                translate([0, 0, 4.5]) {
                    moterAxleFlangeStandIn(28);
                }
            }
        }
    }
}

module moterAxleFlangeStandIn(cutCylinderHt = 5){
    flangeRad = 11+_holeRadiusOffset;
    union(){
        cylinder(r=flangeRad, h=3, center=true, $fn=_sideRes);

        cylinder(r=MOTOR_SHAFT_RADIUS+_holeRadiusOffset, h=cutCylinderHt, center=true, $fn=_sideRes);

        //screwHoles form a 12mm square, so 6mm from center
        translate([6, 6, 0]){
            cylinder(r=MTR_SCREW_RAD, h=cutCylinderHt, center=true, $fn=_sideRes);
        } 

        translate([-6, 6, 0]){
            cylinder(r=MTR_SCREW_RAD, h=cutCylinderHt, center=true, $fn=_sideRes);
        } 

        translate([6, -6, 0]){
            cylinder(r=MTR_SCREW_RAD, h=cutCylinderHt, center=true, $fn=_sideRes);
        } 

            translate([-6, -6, 0]){
            cylinder(r=MTR_SCREW_RAD, h=cutCylinderHt, center=true, $fn=_sideRes);
        } 
    }
}

module shoulderBracketMotorWall(){
     union(){
         //main wall
         difference(){
             cube([MOUNT_OUTER_WIDTH, MOUNT_OUTER_LENGTH, MOUNT_OUTER_HEIGHT], center=true);

             translate([0, -MOUNT_WALL_THICKNESS, -2]) {
                 cube([MOUNT_OUTER_WIDTH+MOUNT_WALL_THICKNESS, MOUNT_OUTER_LENGTH+MOUNT_WALL_THICKNESS, MOUNT_OUTER_HEIGHT+5], center=true);
             }
         }
         //motor support
         translate([(-MOTOR_WIDTH/2)-2.5, MOUNT_OUTER_LENGTH/2, -MOTOR_WIDTH+19]) {
             union(){
                 difference(){
                    rotate([0,90,0]){
                        triangle(MOTOR_WIDTH-4, MOTOR_HEIGHT/3, MOTOR_WIDTH+5);
                    }

                    //trim triangle edges
                    translate([25,42, 0]) {
                        cube([MOTOR_WIDTH+8, MOTOR_WIDTH/3, MOTOR_HEIGHT/3], center=true);
                    }

                    translate([25,2, -15]) {
                        cube([MOTOR_WIDTH+8, MOTOR_WIDTH/3, MOTOR_HEIGHT/3], center=true);
                    }
                }

                translate([(MOTOR_WIDTH/2)+2.5, (MOTOR_WIDTH/2)-4.5, 20]) {
                    union(){
                        cube([MOTOR_WIDTH+3, MOTOR_WIDTH-8, MOTOR_WIDTH], center=true);

                        //wall supports
                        translate([(-MOTOR_WIDTH/2)-1.5, (-MOTOR_HEIGHT/2)+.5, -MOTOR_WIDTH/2]) {
                            rotate([0, 0, 90]) {
                                triangle(MOTOR_WIDTH/4, 15, MOTOR_WIDTH);
                            }
                        }

                        translate([(MOTOR_WIDTH/2)+1.5, (-MOTOR_HEIGHT/2)+.5, -MOTOR_WIDTH/2]) {
                            rotate([0, 0, 0]) {
                                triangle(MOTOR_WIDTH/4, 15, MOTOR_WIDTH);
                            }
                        }
                        //end wall supports
                    }
                    
                }
                
             }
         }
    }
}


module motorStandIn(){
      union(){
        cube([MOTOR_WIDTH, MOTOR_WIDTH, MOTOR_HEIGHT], center=true);

        translate([0, 0, MOTOR_HEIGHT/2]) {
            cylinder(r=MOTOR_SHAFT_THRU_RADIUS+.2, h=10, center = true, $fn=_sideRes);
            translate([0, 0, 12]) {
                cylinder(r=MOTOR_SHAFT_RADIUS,h=29, center=true,$fn=_sideRes);
            }
        }

        //wire attachment port
        translate([(MOTOR_WIDTH/2)+2.5, 0, (-MOTOR_HEIGHT/2)+4.5]) {
            cube(size=[20, 16, 9], center=true);
        }

        //screw mounts
        translate([(MOTOR_WIDTH/2)-5,(MOTOR_WIDTH/2)-5.5,MOTOR_HEIGHT/2]){
            cylinder(r=MTR_SCREW_RAD+.2, h=12, center=true, $fn=_sideRes);
        }

        rotate([0,0,90]){
            translate([(MOTOR_WIDTH/2)-5.5,(MOTOR_WIDTH/2)-5,MOTOR_HEIGHT/2]){
                cylinder(r=MTR_SCREW_RAD+.2, h=12, center=true, $fn=_sideRes);
            }
        }

        rotate([0,0,180]){
            translate([(MOTOR_WIDTH/2)-5,(MOTOR_WIDTH/2)-5.5,MOTOR_HEIGHT/2]){
                cylinder(r=MTR_SCREW_RAD+.2, h=12, center=true, $fn=_sideRes);
            }
        }

        rotate([0,0,270]){
            translate([(MOTOR_WIDTH/2)-5.5,(MOTOR_WIDTH/2)-5,MOTOR_HEIGHT/2]){
                cylinder(r=MTR_SCREW_RAD+.2, h=12, center=true, $fn=_sideRes);
            }
        }
    } 
}

module bearingMount(){
     rotate([0, 90, 0]) {
        difference(){
            cylinder(r=(BEARING_OD/2)+3.2,h=BEARING_HEIGHT+1.5, $fn=_sideRes);
            translate([0, 0, 2.]) {
                    cylinder(r=(BEARING_OD/2),h=BEARING_HEIGHT, $fn=_sideRes);
            }
        }   
    }
}

module bearingInsert(){
    translate([MOUNT_OUTER_WIDTH-BEARING_OD-(BEARING_HEIGHT*2.05), 0, MOUNT_PANEL_RADIUS+BEARING_ID/1.1]) {
        rotate([0, 90, 0]) {
            cylinder(r=(BEARING_OD/2)+2.2,h=BEARING_HEIGHT, $fn=_sideRes);
        }
    }
}

module bearingCap(){
    union(){
        translate([MOUNT_OUTER_WIDTH-BEARING_OD-(BEARING_HEIGHT)+1, 0, MOUNT_PANEL_RADIUS+BEARING_ID/1.2]) {
            bearingCapLockMount();
            bearingCapOuterArm();
            bearingCapStopPeg();
        }
    }
    
}


module bearingCapOuterArm(){
    translate([BEARING_HEIGHT/2.4, 0, ARM_SHLDR_ELBW_HEIGHT/7]) {
        difference(){
             union(){
                cube(size=[BEARING_HEIGHT/1.2, BEARING_OD/1.5 , ARM_SHLDR_ELBW_HEIGHT/10], center=true);
            
                translate([0,0,12]){
                    rotate([90, 90, 0]){
                        cylinder(r=BEARING_OD/3, h=20.13, center=true, $fn=3);
                    } 
                }

                translate([3, 0, -5.3]) {
                    rotate([90, 30, 0]) {
                        cylinder(r=7, h=BEARING_OD/1.5, center=true, $fn=3);
                    }
                }
            }

            translate([5.5, 0, 14.8]) {
               rotate([0,180,0]) {
                    boltAndCaptiveNut(0,15,15);
               }
            }

             translate([-5.5, 0, 14.8]) {
               rotate([0,180,0]) {
                    boltAndCaptiveNut(0,15,15);
               }
            }


        }
    }
}

module bearingCapLockMount(){
    translate([10, 0, 0]) {
        rotate([45, 0, 180]) {
              axleFlangeMount();
        }
    }
}

module axleFlangeMount(){
     difference(){
        union(){
            translate([.4, 0, 0]) {
                 rotate([0, 90, 0]) {
                    difference(){
                        cylinder(r=19, h=BEARING_HEIGHT+10, center=true, $fn=_sideRes);
                        translate([0, 0, 1]) {
                            cylinder(r=16.2, h=BEARING_HEIGHT+16, center=true, $fn=_sideRes);
                        }

                        translate([(BEARING_HEIGHT+16)/1.5, 0, ]) {
                            cube([5,7,8], center=true);
                        }

                        rotate([0,0,180]){
                            translate([(BEARING_HEIGHT+16)/1.4, 0, ]) {
                                cube([5,7,8], center=true);
                            }
                        }

                        rotate([0,0,-90]){
                            translate([(BEARING_HEIGHT+16)/1.4, 0, ]) {
                                cube([5,7,8], center=true);
                            }
                        }

                         rotate([0,0,90]){
                            translate([(BEARING_HEIGHT+16)/1.4, 0, ]) {
                                cube([5,7,8], center=true);
                            }
                        }
                    }
                }
            }
          
            translate([-6.45, 0, 0]) {
                difference(){
                    rotate([0,90,0]){
                        cylinder(r=19, h=5.5, center=true, $fn=_sideRes);
                    }   
                }   
               
            }
        }

         

           translate([-16, 12, 0]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(0,5,30);
               }
           }

            translate([-16, -12, 0]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(0,5,30);
               }
           }     

           
            translate([-16, 0, 12]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(0,5,30);
               }
           }    

           
            translate([-16, 0, -12]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(0,5,30);
               }
           }       
           

       
        rotate([0, 90, 0]) {
             cylinder(r=AXLE_RAD+.2, h=35, center=true, $fn=_sideRes);
        }
    }
}



module boltAndCaptiveNut(nutlength = 25, headlength = 5, boltLength = 30){
    union(){

        cylinder(r=2,h=boltLength,center=true,$fn=_sideRes);

        translate([0, 0, boltLength/2]) {
            cylinder(r=2.65, h=headlength, center=true, $fn=_sideRes);
        }
        
        translate([0,0,boltLength/4]) {
            cube([5.8,nutlength,2.8], center=true);
        }
    
    }
}


module outerArmSupport(){
    union(){
        bearingCap();
        mirror([1, 0, 0]) {
            //bearingCap();
        }
    }
}

module crossSection(thiccness){
    rotate([0, 0, -90]) {
        translate([-BASE_RAD*2, 0, -1]) {
            cube([BASE_HEIGHT*4,thiccness,BASE_HEIGHT*4]);
        }   
    }
}

module oppositeCrossSection(thiccness){
    rotate([0, 0, 0]) {
        translate([-BASE_RAD*2, 0, -1]) {
            cube([BASE_HEIGHT*4,thiccness,BASE_HEIGHT*4]);
        }   
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

