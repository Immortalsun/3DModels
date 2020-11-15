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
MOTOR_SHAFT_RADIUS = 3.15;//mm

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

//servo dimensions
SERVO_LENGTH = 40.2;//mm
SERVO_WIDTH = 20.25;//mm
SERVO_HEIGHT = 40.75;//mm
SERVO_FLANGE_DIST = 25;//mm
SERVO_FLANGE_HEIGHT = 5;//mm
SERVO_FLANGE_LENGTH = 54.75;//mm
SERVO_FLANGE_SCREWHOLE_DIST = 9.25;//mm
SERVO_HORN_RAD = 3;

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
lowerArmZTrans = 0;
elbowMountXTrans = 0;
elbowMountYTrans = 0;
elbowMountZTrans = 0;
motorYTransBuffer = 33.03;
motorZTransBuffer = 5;
//end part translations

main();

module main(){
    union(){
        difference(){
            union(){
                //elbowMain();
                lowerArmMain();
            }
            //rail brace screw holes
            //braceEndcapScrewHole();

            mirror([0, 1, 0]) {
                //braceEndcapScrewHole();
            }
            //end screw holes
        }
    }
}


module elbowMain(){
    union(){
        translate([elbowMountXTrans,elbowMountYTrans,elbowMountZTrans]){
            elbowBridge();

            elbowBraceServoArm();

            translate([0,-((ELBOW_ARM_BRIDGE_WIDTH/2)+ELBOW_ARM_BRACE_WIDTH/2)*2,0]){
                elbowBraceBearingArm();
            }

            translate([-ELBOW_ARM_BRACE_WIDTH*2,(ELBOW_ARM_BRIDGE_WIDTH/2)-(ELBOW_ARM_BRIDGE_WIDTH/2),0]){
                 elbowCentralXSupport();
            }
        }
    }
}

module elbowBraceServoArm(){
    servoYOffset = 1;
    servoXOffset = SERVO_LENGTH-5;
    translate([(ELBOW_ARM_OUTER_LENGTH/2)+(ELBOW_ARM_BRIDGE_LENGTH/2)+SERVO_LENGTH/4,(ELBOW_ARM_BRIDGE_WIDTH/2)+ELBOW_ARM_BRACE_WIDTH/2,0]){
        union(){
            difference(){
                union(){
                    cube([ELBOW_ARM_OUTER_LENGTH+SERVO_LENGTH/2, ELBOW_ARM_BRACE_WIDTH, ELBOW_ARM_BRACE_THIC], center=true);
                    translate([((ELBOW_ARM_OUTER_LENGTH/2)+ELBOW_ARM_BRACE_THIC/2)-2,0,-ELBOW_ARM_BRACE_THIC/2]){
                        rotate([-90, 0, 0]) {
                            quarterCylinder(2,ELBOW_ARM_BRACE_THIC,ELBOW_ARM_BRACE_WIDTH);
                        }
                    }
                }

                //hollow for brace inserts
                translate([-SERVO_LENGTH/2,0,0]){
                    cube([ELBOW_ARM_OUTER_LENGTH-ELBOW_ARM_BRACE_WALL-SERVO_LENGTH+servoXOffset/3, ELBOW_ARM_BRACE_WIDTH+ELBOW_ARM_BRACE_WALL, ELBOW_ARM_BRACE_THIC-ELBOW_ARM_BRACE_WALL], center=true);
                }
                //end brace

                //hollow for servo mount
                translate([servoXOffset,(SERVO_WIDTH/2)+(ELBOW_ARM_BRACE_WIDTH/2)+servoYOffset,0]){
                    rotate([90,0,0]){
                        servoStandIn();
                    }
                }
                //end brace
            }

            braceInterval=ELBOW_ARM_OUTER_LENGTH/3;
            translate([-braceInterval-6,0,0]){
                for(i=[0:1]){
                    translate([braceInterval*i,0,0]){
                        XBraceSupport(LOWER_ARM_OUTER_LENGTH, LOWER_ARM_BRACE_WIDTH, 3);
                    }
                }
            }
        }
    }
}

module elbowBraceBearingArm(){
    translate([(ELBOW_ARM_OUTER_LENGTH/2)+ELBOW_ARM_BRIDGE_LENGTH/2,((ELBOW_ARM_BRIDGE_WIDTH/2)+ELBOW_ARM_BRACE_WIDTH/2),0]){
        union(){
            difference(){
                cube([ELBOW_ARM_OUTER_LENGTH, ELBOW_ARM_BRACE_WIDTH, ELBOW_ARM_BRACE_THIC], center=true);
                //hollow for brace inserts
                cube([ELBOW_ARM_OUTER_LENGTH-ELBOW_ARM_BRACE_WALL, ELBOW_ARM_BRACE_WIDTH+ELBOW_ARM_BRACE_WALL, ELBOW_ARM_BRACE_THIC-ELBOW_ARM_BRACE_WALL], center=true);
                //end brace

                 translate([(BEARING_OD+SERVO_LENGTH/2)+SERVO_HORN_RAD*1.5,0,0]){
                     rotate([-90, 0, 0]) {
                        cylinder(r=(BEARING_OD/2),h=BEARING_HEIGHT, $fn=_sideRes, center=true);
                     }
                 }
            }

            //triangular brace cutouts
            braceInterval=ELBOW_ARM_OUTER_LENGTH/3;
            translate([-braceInterval,0,0]){
                 for(i=[0:2]){
                    translate([braceInterval*i,0,0]){
                        XBraceSupport(LOWER_ARM_OUTER_LENGTH, LOWER_ARM_BRACE_WIDTH, 3);
                    }
                }
            }

            //10mm bore bearing mount
            translate([(BEARING_OD+SERVO_LENGTH/2)+SERVO_HORN_RAD*1.6,0,0]){
                rotate([-90,0,0]){
                    bearingMount();
                }
            }
        }
    }
}


module elbowBridge(){
    difference(){
        union(){
            cube([ELBOW_ARM_BRIDGE_LENGTH, ELBOW_ARM_BRIDGE_WIDTH+_yAxisJoinDepth, ELBOW_ARM_BRIDGE_HEIGHT], center=true);
            translate([ELBOW_ARM_BRIDGE_LENGTH/2,ELBOW_ARM_BRIDGE_WIDTH/2,0]){
                quarterCylinder(4,ELBOW_ARM_BRACE_WIDTH, ELBOW_ARM_BRIDGE_HEIGHT);
            }
            translate([ELBOW_ARM_BRIDGE_LENGTH/2,-ELBOW_ARM_BRIDGE_WIDTH/2,0]){
                quarterCylinder(3,ELBOW_ARM_BRACE_WIDTH, ELBOW_ARM_BRIDGE_HEIGHT);
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

module bearingMount(){
    difference(){
        cylinder(r=(BEARING_OD/2)+3.2,h=BEARING_HEIGHT+1.5, $fn=_sideRes,center=true);
        translate([0, 0, 2.]) {
                cylinder(r=(BEARING_OD/2)+.2,h=BEARING_HEIGHT, $fn=_sideRes, center=true);
        }

        cylinder(r=AXLE_RAD+.2, h=BEARING_HEIGHT+10, $fn=_sideRes, center=true);
    }   
}

module elbowCentralXSupport(){
    centralXBuffer = ELBOW_ARM_OUTER_LENGTH*_yAxisJoinDepth/2;
    translate([MOUNT_OUTER_LENGTH/2,-elbowMountYTrans,0]){
        difference(){
            union(){
                rotate([0, 0, 60]) {
                    centralXSupportBar();
                }
                rotate([0, 0, -60]) {
                    centralXSupportBar();
                }
                cylinder(r=MTR_SCREW_RAD+6, h=ELBOW_ARM_BRIDGE_HEIGHT, center=true, $fn=_sideRes);
            }
            cylinder(r=MTR_SCREW_RAD, h=ELBOW_ARM_BRIDGE_HEIGHT+10, center=true, $fn=_sideRes);
        }
    }
}

module centralXSupportBar(){
     centralXBuffer = ELBOW_ARM_OUTER_LENGTH*_yAxisJoinDepth/2;
      union(){
        difference(){
            cube([ELBOW_ARM_OUTER_LENGTH+centralXBuffer, ELBOW_ARM_BRACE_WIDTH, ELBOW_ARM_BRACE_THIC], center=true);
            //hollow for brace inserts

            cube([ELBOW_ARM_OUTER_LENGTH-ELBOW_ARM_BRACE_WALL, ELBOW_ARM_BRACE_WIDTH+ELBOW_ARM_BRACE_WALL, ELBOW_ARM_BRACE_THIC-ELBOW_ARM_BRACE_WALL], center=true);
            //end brace
        }

        //endcaps
        translate([ELBOW_ARM_OUTER_LENGTH/2,0,0]){
            difference(){
                cylinder(r=ELBOW_ARM_BRACE_WIDTH-1.6, h=ELBOW_ARM_BRACE_THIC, $fn=_sideRes, center=true);
                cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=ELBOW_ARM_BRACE_THIC+5, $fn=_sideRes, center=true);
            }
        }

        translate([-ELBOW_ARM_OUTER_LENGTH/2,0,0]){
            difference(){
                cylinder(r=ELBOW_ARM_BRACE_WIDTH-1.6, h=ELBOW_ARM_BRACE_THIC, $fn=_sideRes, center=true);
                cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=ELBOW_ARM_BRACE_THIC+5, $fn=_sideRes, center=true);
            }
        }

        //end endcaps

        //triangular brace cutouts
        braceInterval=ELBOW_ARM_OUTER_LENGTH/3;
        translate([-braceInterval,0,0]){
            for(i=[0:2]){
                translate([braceInterval*i,0,0]){
                    XBraceSupport(LOWER_ARM_OUTER_LENGTH, LOWER_ARM_BRACE_WIDTH, 3);
                }
            }
        }
        //end brace cutouts
    }
}



module lowerArmMain(){
    translate([lowerArmXTrans,lowerArmYTrans,lowerArmZTrans]) {
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
                            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=LOWER_ARM_BRIDGE_HEIGHT+5, $fn=_sideRes, center=true);
                        }
                    }
                }
            }

            translate([0, 0, -ZAxisAlignedScrewHoleInterval]) {
                for(i=[0:2]){
                    translate([0, 0, ZAxisAlignedScrewHoleInterval*i]) {
                        rotate([0,90,0]){
                            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=LOWER_ARM_BRIDGE_HEIGHT+5, $fn=_sideRes, center=true);
                        }
                    }
                }
            }
        }
    }
}

module braceEndcapScrewHole(){
     translate([((SERVO_LENGTH/2)-7), ELBOW_ARM_BRIDGE_WIDTH/2, 0]) {
        cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=ELBOW_ARM_BRACE_THIC+5, $fn=_sideRes, center=true);
    }

       translate([((SERVO_LENGTH*1.55)-7), ELBOW_ARM_BRIDGE_WIDTH/2, 0]) {
        cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=ELBOW_ARM_BRACE_THIC+5, $fn=_sideRes, center=true);
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

                            //triangular brace cutouts
                            braceInterval=LOWER_ARM_OUTER_LENGTH/3;
                            translate([-braceInterval,0,0]){
                                for(i=[0:2]){
                                    translate([braceInterval*i,0,0]){
                                        XBraceSupport(LOWER_ARM_OUTER_LENGTH, LOWER_ARM_BRACE_WIDTH, 3);
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
                                        XBraceSupport(LOWER_ARM_OUTER_LENGTH, LOWER_ARM_BRACE_WIDTH, 3);
                                    }
                                }
                            }
                            //end brace cutouts
                        }
                }

                cylinder(r=MTR_SCREW_RAD+5.5, h=LOWER_ARM_BRIDGE_HEIGHT, center=true, $fn=_sideRes);
            }
        //cylinder(r=MTR_SCREW_RAD, h=LOWER_ARM_BRIDGE_HEIGHT+10, center=true, $fn=_sideRes);
        
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

module servoStandIn(){
    union(){
        //main servo structure
        cube([SERVO_LENGTH,SERVO_WIDTH,SERVO_HEIGHT], center=true);
        //servo flange
        translate([0,0,(SERVO_HEIGHT/2)-10]){
            cube([SERVO_FLANGE_LENGTH, SERVO_WIDTH, SERVO_FLANGE_HEIGHT],center=true);
        }

        //servo horn
        translate([(-SERVO_LENGTH/2)+30,0,(SERVO_HEIGHT/2)+2.1]){
            cylinder(r=SERVO_HORN_RAD, h=4.6, $fn=_sideRes, center=true);
        }

        //servo screw mounts
        translate([(SERVO_LENGTH/2)+4,SERVO_FLANGE_SCREWHOLE_DIST/2,0]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([(SERVO_LENGTH/2)+4,-SERVO_FLANGE_SCREWHOLE_DIST/2,0]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([-(SERVO_LENGTH/2)-4,SERVO_FLANGE_SCREWHOLE_DIST/2,0]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([-(SERVO_LENGTH/2)-4,-SERVO_FLANGE_SCREWHOLE_DIST/2,0]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
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
                        XBraceSupport(LOWER_ARM_OUTER_LENGTH, LOWER_ARM_BRACE_WIDTH, 3);
                    }
                }
            }
            //end brace cutouts
        }
        //end lower brace arm
    }
}

module XBraceSupport(outerLength, width, interval = 3 ,height = 3.5){
    flangeSinkPercentage = .05;
    union(){
         rotate([0,45,0]){
            cube([(outerLength/interval)+(outerLength*flangeSinkPercentage),width, 3.5], center=true);
        }
        rotate([0,-45,0]){
           cube([(outerLength/interval)+(outerLength*flangeSinkPercentage),width, 3.5], center=true);
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
        radiusOffset = 6;
        //screwHoles form a 12mm square, so 6mm from center
        translate([radiusOffset, radiusOffset, 0]){
            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=cutCylinderHt, center=true, $fn=_sideRes);
        } 

        translate([-radiusOffset, radiusOffset, 0]){
            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=cutCylinderHt, center=true, $fn=_sideRes);
        } 

        translate([radiusOffset, -radiusOffset, 0]){
            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=cutCylinderHt, center=true, $fn=_sideRes);
        } 

            translate([-radiusOffset, -radiusOffset, 0]){
            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=cutCylinderHt, center=true, $fn=_sideRes);
        } 
    }
}