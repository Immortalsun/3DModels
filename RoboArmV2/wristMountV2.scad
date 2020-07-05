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

//Forearm+wrist mounted flange dimensions
flangeOuterRadius = 17.5;
flangeInnerRadius = flangeOuterRadius-1.3;
flangeScrewHoleDist = 12;
axleFlangeHeight = 3;

mountCubeX = SERVO_LENGTH+7;
mountCubeY = 35;
mountCubeZ = 4.5;

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
_standardXOffset = .5;
_yAxisJoinDepth = .2;
//part translations
wristMountXTrans = 0;
wristMountYTrans = 0;
wristMountZTrans = 0;
//end part translations

main();


module main(){
    translate([wristMountXTrans, wristMountYTrans, wristMountZTrans]){
        union(){
            wristMountBase();
            wristMountServoHolder();
            wristMountBearingHolder();
            wristMountAttachmentPlatform();
        }
    }
}

module wristMountAttachmentPlatform(){
    mountWidth = SERVO_HEIGHT+servoHornHeight*2;
    mountLength = SERVO_HEIGHT/3.5;
    mountHeight = servoHornBaseRadius*2.5;
    bearingIR = 3.85;
    bearingOR = 11.2;
    bearingHeight = 7;
    union(){
        //bearing attachment side
        wristMountBearingSidePlatformMount();

        //servo attachment side
        wristMountServoSidePlatformMount();

        //connecting bridge between servo and bearing sides
        wristMountBridgeConnector();

    }
}

module wristMountServoSidePlatformMount(){
    mountWidth = SERVO_HEIGHT+servoHornHeight*2;
    mountLength = SERVO_HEIGHT/3.5;
    mountHeight = servoHornBaseRadius*2.5;
    bearingIR = 3.85;
    bearingOR = 11.2;
    bearingHeight = 7;
     union(){
            difference(){
                translate([(SERVO_HEIGHT/2)+mountHeight/1.2, 5, (mountHeight/2)+servoHornBaseRadius/2]) {
                    union(){
                        cube([mountLength,mountWidth,mountHeight], center=true);
                        translate([0,mountWidth/2,0]){
                            rotate([0,90,0]){
                                cylinder(r=mountHeight/2, h=mountLength, center=true, $fn=_sideRes);
                            }
                        }

                        translate([0, -29.2, 0]) {
                            cube([mountLength,5,mountHeight], center=true);
                        }
                    }
                }

                translate([servoHornBaseRadius+SERVO_HORN_RAD/2+SERVO_HEIGHT/2,10,(SERVO_HEIGHT/3)]){
                    rotate([90, 0, 90]) {
                        servoHorn();
                    }
                    
                }
            }
            //bridge attachment point
                translate([SERVO_HEIGHT-10.8,SERVO_WIDTH+7,22.2]){
                    difference(){
                            union(){
                                rotate([90, 0, 0]) {
                                    triangle(mountLength-2,11.7,mountWidth);
                                }

                                translate([2.5, -SERVO_WIDTH-6.7, 8]) {
                                    cube([5, mountWidth, 12], center=true);
                                }
                        }

                         translate([2.5, -SERVO_WIDTH-6.7, 9.5]) {
                                rotate([0,90,0]){
                                cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=10, $fn=_sideRes, center=true);
                            }
                        }

                         translate([2.5, (-SERVO_WIDTH-6.7)+mountWidth/3, 9.5]) {
                                rotate([0,90,0]){
                                cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=10, $fn=_sideRes, center=true);
                            }
                        }

                        translate([2.5,(-SERVO_WIDTH-6.7)-mountWidth/3, 9.5]) {
                                rotate([0,90,0]){
                                cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=10, $fn=_sideRes, center=true);
                            }
                        }
                    }
                    
                  
                }
           
        }
}

module wristMountBearingSidePlatformMount(){
    mountWidth = SERVO_HEIGHT+servoHornHeight*2;
    mountLength = SERVO_HEIGHT/3.5;
    mountHeight = servoHornBaseRadius*2.5;
    bearingIR = 3.97;
    bearingOR = 11.2;
    bearingHeight = 7;
     union(){
            translate([-SERVO_HEIGHT+bearingHeight*2, bearingOR-1.5, bearingOR+1.5]) {
                rotate([0, 90, 0]) {
                    union(){
                        cylinder(r=bearingIR, h=bearingHeight+10, center=true, $fn=_sideRes);
                        cylinder(r1=bearingIR+2, r2 = bearingIR-1.5, h=bearingHeight, center=true, $fn=_sideRes);
                    }
                   
                }
            }

            translate([-(SERVO_HEIGHT/2)-mountHeight/1.2, .3,  (mountHeight/2)+servoHornBaseRadius/2]) {
                difference(){
                    union(){
                        cube([mountLength,mountWidth,mountHeight], center=true);
                         translate([0,-mountWidth/2,0]){
                            rotate([0,90,0]){
                                cylinder(r=mountHeight/2, h=mountLength, center=true, $fn=_sideRes);
                            }
                        }
                    }    
                }
            }

            mirror([1, 0, 0]) {
                union(){
                     union(){
                        translate([SERVO_HEIGHT-10.8,SERVO_WIDTH+7,22.2]){
                            difference(){
                                union(){
                                    rotate([90, 0, 0]) {
                                        triangle(mountLength-2,11.7,mountWidth);
                                    }

                                    translate([2.5, -SERVO_WIDTH-6.7, 8]) {
                                        cube([5, mountWidth, 12], center=true);
                                    }
                                }
                                 translate([2.5, -SERVO_WIDTH-6.7, 9.5]) {
                                        rotate([0,90,0]){
                                        cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=10, $fn=_sideRes, center=true);
                                    }
                                }

                                    translate([2.5, (-SERVO_WIDTH-6.7)+mountWidth/3, 9.5]) {
                                        rotate([0,90,0]){
                                        cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=10, $fn=_sideRes, center=true);
                                    }
                                }

                                translate([2.5,(-SERVO_WIDTH-6.7)-mountWidth/3, 9.5]) {
                                        rotate([0,90,0]){
                                        cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=10, $fn=_sideRes, center=true);
                                    }
                                }
                                       
                            }
                        }
                    }                   
                }
            }
            
        }
}

module wristMountBridgeConnector(){
    mountWidth = SERVO_HEIGHT+servoHornHeight*2;
    mountLength = SERVO_HEIGHT/3.5;
    mountHeight = servoHornBaseRadius*2.5;
    bearingIR = 3.85;
    bearingOR = 11.2;
    bearingHeight = 7;
    union(){
            translate([0, 0, mountHeight+26.5]) {
                difference(){
                    cube([mountLength*5.5, mountWidth+3, 8], center=true);

                    translate([22, 22, -7]) {
                        boltAndCaptiveNut(80,5,30);
                    }

                    translate([-22, 22, -7]) {
                        boltAndCaptiveNut(80,5,30);
                    }

                        translate([-22, -22, -7]) {
                        boltAndCaptiveNut(80,5,30);
                    }

                    translate([22, -22, -7]) {
                        boltAndCaptiveNut(80,5,30);
                    }
                }
                
            }

            translate([mountWidth/1.71, 0, mountHeight+25.5]) {
                rotate([90, 0, 0]) {
                    quarterCylinder(1,5,mountWidth+3);
                }
            }

            translate([-mountWidth/1.72, 0, mountHeight+25.5]) {
                rotate([90, 0, 0]) {
                    quarterCylinder(4,5,mountWidth+3);
                }
            }
            
            //bearing side connector
            translate([-mountWidth/1.67, 0, mountHeight+14]) {
                difference(){
                    union(){
                            cube([8, mountWidth+3, mountHeight-10], center=true);
                            translate([0, 0, 6]) {
                                cube([8, mountWidth+3, 11],center=true);
                            }
                    }
                    
                    translate([0, 0, -5]) {
                            cube([5.5,mountWidth+.5, mountHeight-5], center=true);
                    }

                    translate([0, 0, -.6]) {
                        rotate([0, 90, 0]) {
                            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=15, $fn=_sideRes, center=true);
                        }
                    }

                    translate([0, mountWidth/3, -.6]) {
                        rotate([0, 90, 0]) {
                            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=15, $fn=_sideRes, center=true);
                        }
                    }

                    translate([0, -mountWidth/3, -.6]) {
                        rotate([0, 90, 0]) {
                            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=15, $fn=_sideRes, center=true);
                        }
                    }
                }
            }

            //servo side connector
            translate([mountWidth/1.66, 0, mountHeight+14]) {
                difference(){
                        union(){
                            cube([8, mountWidth+3, mountHeight-10], center=true);
                            translate([0, 0, 6]) {
                                cube([8, mountWidth+3, 11],center=true);
                            }
                    }
                    translate([0, 0, -5]) {
                            cube([5.5,mountWidth+.5, mountHeight-5], center=true);
                    }

                    translate([0, 0, -.6]) {
                        rotate([0, 90, 0]) {
                            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=15, $fn=_sideRes, center=true);
                        }
                    }

                    translate([0, mountWidth/3, -.6]) {
                        rotate([0, 90, 0]) {
                            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=15, $fn=_sideRes, center=true);
                        }
                    }

                    translate([0, -mountWidth/3, -.6]) {
                        rotate([0, 90, 0]) {
                            cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=15, $fn=_sideRes, center=true);
                        }
                    }
                }
            }

            translate([0, 0, 55]) {
                union(){
                    upperArmWristMount();
                    translate([0, 0, -5]) {
                        cylinder(r=27, h=5, center=true, $fn=_sideRes);
                    }
                }
                
            }
        }
}

module wristMountServoHolder(){
    translate([0,0,(mountCubeZ+SERVO_WIDTH/2)+.25]){
        difference(){
            translate([(SERVO_LENGTH/2),0,0]){
                union(){
                    translate([.25, 0, -1]) {
                        cube([6.5,,SERVO_FLANGE_LENGTH+1,SERVO_WIDTH+3],center=true);
                    }

                    translate([-3,17.5,-12.6]){
                        rotate([0, 90, 0]) {
                            triangle(10.39,4.5,6.5);
                        }
                    }

                    mirror([0,1,0]){
                         translate([-3,17.5,-12.6]){
                            rotate([0, 90, 0]) {
                                triangle(10.39,4.5,6.5);
                            }
                        }
                    }
                }
               
            }

            translate([4,0,-2.4]){
                rotate([90, 0, 90]) {
                    servoStandIn();
                }

                translate([(SERVO_LENGTH/2)-4, 0, 12]) {
                    cube([8, SERVO_LENGTH, 5], true);
                }
            }
        }
    }
}

module wristMountBearingHolder(){
    translate([-(SERVO_LENGTH/2)-.5,0,(mountCubeZ+SERVO_WIDTH/2)+.25]){
        difference(){
            union(){
                translate([.25, 0, -1]) {
                    cube([6.5,,SERVO_FLANGE_LENGTH+1,SERVO_WIDTH+3],center=true);
                }

                translate([-3,17.5,-12.6]){
                    rotate([0, 90, 0]) {
                        triangle(10.39,4.5,6.5);
                    }
                }

                mirror([0,1,0]){
                        translate([-3,17.5,-12.6]){
                        rotate([0, 90, 0]) {
                            triangle(10.39,4.5,6.5);
                        }
                    }
                }
            }

            //bearing mount matching with servo horn
            translate([-40,0,-2.4]){
                rotate([90, 0, 90]) {
                   translate([(-SERVO_LENGTH/2)+30,0,(SERVO_HEIGHT/2)+2.1]){
                       difference(){
                            cylinder(r=11.2, h=44.6, $fn=_sideRes, center=true);
                            //cylinder(r=3.85, h=55.6, $fn=_sideRes, center=true);
                       }
                       
                    }
                }
            }
            
            //space for structural fill
            translate([0,-13,-2.4]){
                cube([SERVO_WIDTH,SERVO_LENGTH/2,SERVO_WIDTH],center=true);
            }
        }

        //structural fill
        translate([.25,-13,-2.4]){
            rotate([45, 0, 0]) {
                cube([6.5,SERVO_LENGTH/1.3,SERVO_WIDTH/4],center=true);
            }

             rotate([-45, 0, 0]) {
                cube([6.5,SERVO_LENGTH/1.3,SERVO_WIDTH/4],center=true);
            }
        }
    }
}

module wristMountBase(){
     difference(){
        union(){
            translate([0,0,-axleFlangeHeight]){
                difference(){
                    cylinder(r=flangeOuterRadius, h=axleFlangeHeight, center=true, $fn=_sideRes);
                    translate([0, 0, 1]) {
                        cylinder(r=flangeInnerRadius, h=BEARING_HEIGHT, center=true, $fn=_sideRes);
                    }
                }
            }
          
            cube([mountCubeX,mountCubeY,mountCubeZ], center=true);
        }
            //cutout for bearing
             translate([-43.6,0,12.46]){
                rotate([90, 0, 90]) {
                   translate([(-SERVO_LENGTH/2)+30,0,(SERVO_HEIGHT/2)+2.1]){
                        cylinder(r=11.2, h=8, $fn=_sideRes, center=true);
                    }
                }
            }

           translate([0, flangeScrewHoleDist, -7.5]){
              boltAndCaptiveNut(38,5,30);
           }

            translate([0, -flangeScrewHoleDist, -7.5]){
               boltAndCaptiveNut(38,5,30);
           }     

           
            translate([flangeScrewHoleDist, 0, -7.5]){
              boltAndCaptiveNut(38,5,30);
           }    

           
            translate([-flangeScrewHoleDist, 0, -7.5]){
                boltAndCaptiveNut(38,5,30);
           }       
           

       
        cylinder(r=AXLE_RAD+.2, h=35, center=true, $fn=_sideRes);
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
        translate([0, 0, 2.5]) {
            union(){
                cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=servoHornHeight+15, $fn=_sideRes, center=true);
                translate([0, 0, 8]) {
                    cylinder(r=MTR_SCREW_COUNTERSINK_RAD, h=5, $fn=_sideRes, center=true);
                }
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
            translate([(servoHornLength-servoHornBaseRadius-MTR_SCREW_RAD)-_standardXOffset,0,0]){
                union(){
                    cylinder(r=MTR_SCREW_RAD+.2, h=servoHornWidth+22, $fn=_sideRes, center=true);
                    translate([-MTR_SCREW_RAD*2-1.45, 0, 0]) {
                        cylinder(r=MTR_SCREW_RAD+.2, h=servoHornWidth+22, $fn=_sideRes, center=true);
                    }
                    translate([-MTR_SCREW_RAD,0,5]){
                         cube([(MTR_SCREW_RAD)*2,(MTR_SCREW_RAD+.2)*2,MTR_SCREW_RAD*12], center=true);
                    }
                    translate([-MTR_SCREW_RAD*2,0,5]){
                         cube([(MTR_SCREW_RAD)*2,(MTR_SCREW_RAD+.2)*2,MTR_SCREW_RAD*12], center=true);
                    }
                   
                }
            }
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

module wristKeyTemplate(){
    difference(){
         union(){
            cylinder(r=26, h = 5, center=true, $fn=_sideRes);
            cube(size=[68.5, 10.5, 5], center=true);
            cube(size=[10.5, 68.5, 5], center=true);
        }

        translate([0, 0, 1]) {
             difference(){
                cylinder(r=35, h=8, center=true, $fn=_sideRes);
                translate([0, 0, 3]) {
                    cylinder(r=26.5, h=12, center=true, $fn=_sideRes);
                }

                translate([0, 0, -4]) {
                    cylinder(r=33.2, h=12, center=true, $fn=_sideRes);
                }
            }
        }
    }
   
}

module wristKey(){
    difference(){

        union(){
            cylinder(r=26, h = 3, center=true, $fn=_sideRes);
            translate([0, 0, 0]) {
                cube(size=[68, 9.8, 3], center=true);
                cube(size=[9.8, 68, 3], center=true);
            }
        }

        translate([0, 0, 1]) {
             difference(){
                cylinder(r=35, h=8, center=true, $fn=_sideRes);
                // translate([0, 0, 3]) {
                //     cylinder(r=26.5, h=12, center=true, $fn=_sideRes);
                // }

                translate([0, 0, -4]) {
                    cylinder(r=33.2, h=12, center=true, $fn=_sideRes);
                }
            }
        }
       
        keyInteriorScrewMounts();
        keyExteriorScrewMounts();
        cylinder(r=AXLE_RAD+.2, h=40, center=true, $fn=_sideRes);  
    }
}

module upperArmWristMount(){
    snapRadius = 3.25;
    union(){
        difference(){
            //identical plate for elbow crossbrace
            union(){
                 cylinder(r1=28, r2=38, h=8, center=true, $fn=_sideRes);

                  rotate([0, 0, 45]){
                    translate([30, 0, -2]){
                        cylinder(r=4, h=10, center=true, $fn=_sideRes);
                    } 
                }

                 rotate([0, 0, 135]){
                    translate([30, 0, -2]){
                        cylinder(r=4, h=10, center=true, $fn=_sideRes);
                    } 
                }  

                 rotate([0, 0, 225]){
                    translate([30, 0, -3]){
                        cylinder(r=4, h=10, center=true, $fn=_sideRes);
                    } 
                }  
                
                rotate([0, 0, 315]){
                    translate([30, 0, -2]){
                        cylinder(r=4, h=10, center=true, $fn=_sideRes);
                    } 
                }

            }
           

                rotate([0, 0, 45]){
                    translate([30, 0, 0]){
                        cylinder(r=2, h=40, center=true, $fn=_sideRes);
                    } 
                }

                 rotate([0, 0, 135]){
                    translate([30, 0, 0]){
                        cylinder(r=2, h=40, center=true, $fn=_sideRes);
                    } 
                }  

                 rotate([0, 0, 225]){
                    translate([30, 0, 0]){
                        cylinder(r=2, h=40, center=true, $fn=_sideRes);
                    } 
                }  
                
                rotate([0, 0, 315]){
                    translate([30, 0, 0]){
                        cylinder(r=2, h=40, center=true, $fn=_sideRes);
                    } 
                }

                translate([0, 0, 4]) {
                    difference(){
                        cylinder(r=18.5, h=5, center=true, $fn=_sideRes);
                        cylinder(r=12.5, h=15, center=true, $fn=_sideRes);
                    }  
                }
                
        }

        translate([0, 0, 8]) {
            difference(){
                difference(){
                    cylinder(r=35, h=8, center=true, $fn=_sideRes);
                    translate([0, 0, 3]) {
                        cylinder(r=26.5, h=12, center=true, $fn=_sideRes);
                    }

                    translate([0, 0, -4]) {
                        cylinder(r=33.2, h=12, center=true, $fn=_sideRes);
                    }
                }

                translate([0,0,2]){
                    wristKeyTemplate();
                }

                rotate([0, 0, 45]){
                    translate([30, 0, 0]){
                        cylinder(r=2, h=40, center=true, $fn=_sideRes);
                    } 
                }

                 rotate([0, 0, 135]){
                    translate([30, 0, 0]){
                        cylinder(r=2, h=40, center=true, $fn=_sideRes);
                    } 
                }  

                 rotate([0, 0, 225]){
                    translate([30, 0, 0]){
                        cylinder(r=2, h=40, center=true, $fn=_sideRes);
                    } 
                }  
                
                rotate([0, 0, 315]){
                    translate([30, 0, 0]){
                        cylinder(r=2, h=40, center=true, $fn=_sideRes);
                    } 
                }  
            }
             
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