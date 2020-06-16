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
MOTOR_WIDTH = 42.4;//mm
MOTOR_HEIGHT = 38.5;//mm //smaller NEMA motor, other height is 38.5
MOTOR_SHAFT_THRU_RADIUS = 11.5;//mm
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

//servo dimensions
SERVO_LENGTH = 40.2;//mm
SERVO_WIDTH = 20.25;//mm
SERVO_HEIGHT = 40.75;//mm
SERVO_FLANGE_DIST = 25;//mm
SERVO_FLANGE_HEIGHT = 5;//mm
SERVO_FLANGE_LENGTH = 54.75;//mm
SERVO_FLANGE_SCREWHOLE_DIST = 9.25;//mm
SERVO_HORN_RAD = 3;

//elbow bracket + motor mount
ELBOW_BRKT_LENGTH = SERVO_LENGTH;//mm
ELBOW_BRKT_WIDTH = MOTOR_WIDTH + 11;//mm
ELBOW_BRKT_HEIGHT = MOTOR_HEIGHT+8;

//Motor Flange mount params//
FLANGE_MOUNT_RADIUS = 15.5;//mm

//Shoulder Axle params
AXLE_RAD = 5.25;//mm
AXLE_HEIGHT = MOUNT_OUTER_WIDTH+(BEARING_HEIGHT*14);
SUPPORT_HEIGHT = 75;
//Arm mount params
ARM_MOUNT_HEIGHT = MOUNT_OUTER_WIDTH-(BEARING_HEIGHT*2)-15;
ARM_SHLDR_ELBW_HEIGHT = 175;
//servo horn params
servoHornLength = 35;//mm
servoHornHeight = 6.6;//mm
servoHornWidth = 6;//mm
servoHornBaseRadius = 7.4;//mm
servoHornZTransBuffer = .5;//mm
servoHornXTransBuffer = .5;//mm

//global constants
_sideRes = 300;
_hollowLengthOffset = 5;//mm
_holeRadiusOffset = .3;//mm
_yAxisJoinDepth = .2;
//part translations
elbowMountXTrans = 0;
elbowMountYTrans = 0;
elbowMountZTrans = 0;
//end part translations


main();

module main(){
    union(){
        //elbowBracketMain();
        //elbowMain();
        eblowBracketBearingMount();
    }
}

module elbowBracketMain(){
    bracketBearingExtension = 5;
    union(){
        translate([elbowMountXTrans,elbowMountYTrans,elbowMountZTrans]){
            union(){
                //bearing mount extension
                translate([0,(-ELBOW_BRKT_WIDTH/2)-(BEARING_HEIGHT),0]){
                    //eblowBracketBearingMount();
                }

                //servo horn mount extension
                translate([servoHornLength-10, (ELBOW_BRKT_WIDTH/2)-.95, 0]){
                    elbowServoHornMount();
                } 

                //main bracket + motor mount
                difference(){     
                   cube([ELBOW_BRKT_LENGTH, ELBOW_BRKT_WIDTH, ELBOW_BRKT_HEIGHT], center=true);

                    //center servo horn mount
                    translate([.5, (ELBOW_BRKT_WIDTH/2), 0]){
                        rotate([90, 0, 0]) {
                            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=12, $fn=_sideRes, center=true);
                            translate([0, 0, 3.2]){
                                 cylinder(r=MTR_SCREW_COUNTERSINK_RAD, h=5, $fn=_sideRes, center=true);
                            } 
                            
                        }
                       
                    } 
                   
                    motorStandIn();
                    //cut for motor slide-through
                    translate([(MOTOR_SHAFT_RADIUS*2)+bracketBearingExtension, 0, MOTOR_HEIGHT-12]) {
                        cube([MOTOR_SHAFT_THRU_RADIUS+10, ((MOTOR_SHAFT_THRU_RADIUS+.2)*2)-.1, 15], center=true);
                    }

                    //attachment point for bearing peg
                    translate([0,(-ELBOW_BRKT_WIDTH/2)-(BEARING_HEIGHT)+(bracketBearingExtension-1),0]){
                        rotate([0,90,90]){
                            boltAndCaptiveNut(50,5,30);
                        }
                    }

                    //trimming for servo horn attachment
                    translate([MOTOR_WIDTH-21,ELBOW_BRKT_WIDTH/2,0]){
                        rotate([90, 0, 0]) {
                            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=12, $fn=_sideRes, center=true);
                            
                        }
                    }
                }
                
                
            }
        }
    }
}

module eblowBracketBearingMount(){
    bracketBearingExtension = 10;
    rotate([90,0,0]){
        //create screw hole for mounting to main bracket
        difference(){
            union(){
                cylinder(r=AXLE_RAD-_holeRadiusOffset, h=BEARING_HEIGHT+bracketBearingExtension, center=true, $fn=_sideRes);
                translate([0,0,-BEARING_HEIGHT+2]){
                    cylinder(r1=AXLE_RAD+5, r2=AXLE_RAD+3, h=5 ,$fn=4, center=true);
                }
            }
            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=BEARING_HEIGHT*3, center=true, $fn=_sideRes);  
        }
    }
}

module elbowServoHornMount(){
    servoYOffset = 1;
    servoXOffset = SERVO_LENGTH-5;
    difference(){
        union(){
            rotate([90,0,0]){
                cylinder(r=servoHornBaseRadius+.74, h=BEARING_HEIGHT-.2,$fn=_sideRes, center=true);
            }
            translate([-servoHornLength/2,0,0]){
                cube([servoHornLength, servoHornWidth*1.5, (servoHornBaseRadius*2.2)], center=true);
            }
        }
        
       translate([(-servoHornLength/2)-7, (servoHornHeight/2)+_holeRadiusOffset*6, 0]) {
            rotate([90,0,0]){
                servoHorn();
            }
       }
       
    }
}

module elbowMain(){
    union(){
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

module elbowBraceServoArm(){
    servoYOffset = 1;
    servoXOffset = SERVO_LENGTH-5;
    translate([(ELBOW_ARM_OUTER_LENGTH/2)+(ELBOW_ARM_BRIDGE_LENGTH/2)+SERVO_LENGTH/4,(ELBOW_ARM_BRIDGE_WIDTH/2)+ELBOW_ARM_BRACE_WIDTH/2,0]){
        union(){
            union(){
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
                cylinder(r=(BEARING_OD/2),h=BEARING_HEIGHT, $fn=_sideRes, center=true);
        }

        cylinder(r=AXLE_RAD+.2, h=BEARING_HEIGHT+10, $fn=_sideRes, center=true);
    }   
}

module elbowCentralXSupport(){
    centralXBuffer = ELBOW_ARM_OUTER_LENGTH*_yAxisJoinDepth/2;
    translate([MOUNT_OUTER_LENGTH/2,0,0]){
        difference(){
                union(){
                    rotate([0, 0, 60]) {
                        union(){
                            difference(){
                                cube([ELBOW_ARM_OUTER_LENGTH+centralXBuffer, ELBOW_ARM_BRACE_WIDTH, ELBOW_ARM_BRACE_THIC], center=true);
                                //hollow for brace inserts

                                cube([ELBOW_ARM_OUTER_LENGTH-ELBOW_ARM_BRACE_WALL, ELBOW_ARM_BRACE_WIDTH+ELBOW_ARM_BRACE_WALL, ELBOW_ARM_BRACE_THIC-ELBOW_ARM_BRACE_WALL], center=true);
                                //end brace
                            }

                            //endcaps
                            translate([ELBOW_ARM_OUTER_LENGTH/2,0,0]){
                                cylinder(r=ELBOW_ARM_BRACE_WIDTH-1.6, h=ELBOW_ARM_BRACE_THIC, $fn=_sideRes, center=true);
                            }

                            translate([-ELBOW_ARM_OUTER_LENGTH/2,0,0]){
                                cylinder(r=ELBOW_ARM_BRACE_WIDTH-1.6, h=ELBOW_ARM_BRACE_THIC, $fn=_sideRes, center=true);
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
                    rotate([0, 0, -60]) {
                        union(){
                            difference(){
                                cube([ELBOW_ARM_OUTER_LENGTH+centralXBuffer, ELBOW_ARM_BRACE_WIDTH, ELBOW_ARM_BRACE_THIC], center=true);
                                //hollow for brace inserts

                                cube([ELBOW_ARM_OUTER_LENGTH-ELBOW_ARM_BRACE_WALL, ELBOW_ARM_BRACE_WIDTH+ELBOW_ARM_BRACE_WALL, ELBOW_ARM_BRACE_THIC-ELBOW_ARM_BRACE_WALL], center=true);
                                //end brace
                            }

                             //endcaps
                            translate([ELBOW_ARM_OUTER_LENGTH/2,0,0]){
                                cylinder(r=ELBOW_ARM_BRACE_WIDTH-1.6, h=ELBOW_ARM_BRACE_THIC, $fn=_sideRes, center=true);
                            }

                            translate([-ELBOW_ARM_OUTER_LENGTH/2,0,0]){
                                cylinder(r=ELBOW_ARM_BRACE_WIDTH-1.6, h=ELBOW_ARM_BRACE_THIC, $fn=_sideRes, center=true);
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

                cylinder(r=MTR_SCREW_RAD+6, h=ELBOW_ARM_BRIDGE_HEIGHT, center=true, $fn=_sideRes);
            }
        cylinder(r=MTR_SCREW_RAD, h=ELBOW_ARM_BRIDGE_HEIGHT+10, center=true, $fn=_sideRes);
        
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
        translate([(SERVO_LENGTH/2)+4,SERVO_FLANGE_SCREWHOLE_DIST/2,-8]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([(SERVO_LENGTH/2)+4,-SERVO_FLANGE_SCREWHOLE_DIST/2,-8]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([-(SERVO_LENGTH/2)-4,SERVO_FLANGE_SCREWHOLE_DIST/2,-8]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([-(SERVO_LENGTH/2)-4,-SERVO_FLANGE_SCREWHOLE_DIST/2,-8]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([servoHornBaseRadius+SERVO_HORN_RAD,0,(SERVO_HEIGHT/2)+(servoHornHeight/2)+servoHornZTransBuffer]){
            //servoHorn();
        }

    }
}

module servoHorn(){
    union(){
        //servoHorn base, attaches to servo gear
        cylinder(r=servoHornBaseRadius+_holeRadiusOffset, h=servoHornHeight, $fn=_sideRes, center=true);
        //servoHorn base screw mount
        union(){
             cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=servoHornHeight+15, $fn=_sideRes, center=true);
             translate([0, 0, 8]) {
                 cylinder(r=MTR_SCREW_COUNTERSINK_RAD, h=5, $fn=_sideRes, center=true);
             }
        }
       
        //servo horn gradient spacers (triangles)
        union(){
            translate([5,2,-servoHornHeight/2]){
                rotate([0, 0, 8]) {
                    triangle((servoHornBaseRadius/2),(servoHornBaseRadius/2)+3,(servoHornHeight));
                }
            }

            mirror([0,1,0]){
                  translate([5,2,-servoHornHeight/2]){
                     rotate([0, 0, 8]) {
                        triangle((servoHornBaseRadius/2),(servoHornBaseRadius/2)+3,(servoHornHeight));
                    }
                }
            }
            
        }
        //servo horn body, attaches to load
        union(){
            translate([servoHornBaseRadius*1.5,0,.3]){
                difference(){
                    cube([servoHornLength, servoHornHeight, servoHornWidth], center=true);
                    //cut out for screw heads
                    translate([(-servoHornBaseRadius/2)+servoHornZTransBuffer,0,-2]){
                            cube([15.3,servoHornHeight+.2,2.12],center=true);
                    }
                }
            }

            //servo horn screw mounts
            translate([(servoHornLength-servoHornBaseRadius-MTR_SCREW_RAD),0,0]){
                union(){
                    cylinder(r=MTR_SCREW_RAD+.2, h=servoHornWidth+22, $fn=_sideRes, center=true);
                    translate([-MTR_SCREW_RAD*2-1.45, 0, 0]) {
                        cylinder(r=MTR_SCREW_RAD+.2, h=servoHornWidth+22, $fn=_sideRes, center=true);
                    }
                    translate([-MTR_SCREW_RAD,0,3]){
                         cube([(MTR_SCREW_RAD)*2,(MTR_SCREW_RAD+.2)*2,MTR_SCREW_RAD*12], center=true);
                    }
                    translate([-MTR_SCREW_RAD*2,0,3]){
                         cube([(MTR_SCREW_RAD)*2,(MTR_SCREW_RAD+.2)*2,MTR_SCREW_RAD*12], center=true);
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
            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=12, center=true, $fn=_sideRes);
        }

        rotate([0,0,90]){
            translate([(MOTOR_WIDTH/2)-5.5,(MOTOR_WIDTH/2)-5.5,MOTOR_HEIGHT/2]){
                cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=12, center=true, $fn=_sideRes);
            }
        }

        rotate([0,0,180]){
            translate([(MOTOR_WIDTH/2)-5.5,(MOTOR_WIDTH/2)-5.5,MOTOR_HEIGHT/2]){
                cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=12, center=true, $fn=_sideRes);
            }
        }

        rotate([0,0,270]){
            translate([(MOTOR_WIDTH/2)-5.5,(MOTOR_WIDTH/2)-5,MOTOR_HEIGHT/2]){
                cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=12, center=true, $fn=_sideRes);
            }
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