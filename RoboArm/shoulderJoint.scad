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

//MOUNT PARAMS
MOUNT_OUTER_WIDTH = 80;//mm
MOUNT_WALL_THICKNESS = 19.95;
MOUNT_PANEL_RADIUS = 50; 

//Upper Arm
UPPER_ARM_LENGTH = 175;//mm
UPPER_ARM_BRACE_WIDTH = 135;//mm
UPPER_ARM_BRACE_THIC = 20.13;//mm
UPPER_ARM_BRACE_HT = 20;//mm

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

main();

module main(){
    //import("E:/Programerinos/userSave/RoboArm/drawings/rb_LIDv2.stl");
    difference(){
        union(){
            //platformAttachment();
    
           

            //motor stand-in 
            // translate([MOTOR_HEIGHT/1.2, 0-LID_RAD/3, MOTOR_WIDTH+LID_HEIGHT+4]) {
            //     rotate([-90, 0, 90]) {
            //         motorStandIn();
            //     }
            // }

            mainLowerArm();
            //axleDriveGear();

            //shoulderMotorBracket();
        }
        axle();
        // /crossSection(50);
    }
}

module platformAttachment(){
    union(){
        difference(){
            translate([0, 0, LID_HEIGHT+15]) {
                platformSidePanels();
            }
            bearingInsert();
            mirror([1, 0, 0]) {
                bearingInsert();
            }
        }
        bearingMount();
        mirror([1, 0, 0]) {
            bearingMount();
        }
    }
  
}

module platformSidePanels(){
    difference(){
        union(){
            rotate([0, 90, 0]) {
                difference(){
                    cylinder(r=MOUNT_PANEL_RADIUS, h=MOUNT_OUTER_WIDTH, center=true, $fn=_sideRes);
                    translate([(MOUNT_PANEL_RADIUS/2)+15, 0, 0]) {
                        cube(size=[MOUNT_PANEL_RADIUS, MOUNT_PANEL_RADIUS*2.5, MOUNT_PANEL_RADIUS*2.5], center=true);
                    }
                    cylinder(r=MOUNT_PANEL_RADIUS+2, h=MOUNT_OUTER_WIDTH-MOUNT_WALL_THICKNESS, center=true, $fn=_sideRes);

                    translate([-16.7, -26.5, -50]) {
                        cylinder(r=2, h=40, center=true, $fn=_sideRes);
                    }

                    translate([5, -26.5, -50]) {
                        cylinder(r=2, h=40, center=true, $fn=_sideRes);
                    }
                }
            }

            // translate([-MOTOR_HEIGHT+5, -5.3, MOTOR_WIDTH-15]) {
            //     rotate([0, 90, 0]) {
            //         shoulderMotorBracket();
            //     }
            // }
            
            translate([MOUNT_OUTER_WIDTH/2, BEARING_OD/2, FLANGE_HEIGHT/1.5]){
                 lowerArmStopPeg();
            }

            translate([MOUNT_OUTER_WIDTH/2, -BEARING_OD/2, FLANGE_HEIGHT/1.5]){
                 lowerArmStopPeg();
            }  

            mirror([1,0,0]){
                translate([MOUNT_OUTER_WIDTH/2, BEARING_OD/2, FLANGE_HEIGHT/1.5]){
                 lowerArmStopPeg();
            }

            translate([MOUNT_OUTER_WIDTH/2, -BEARING_OD/2, FLANGE_HEIGHT/1.5]){
                 lowerArmStopPeg();
            }  
            }
           
            translate([0, -MOUNT_PANEL_RADIUS, 0]){
                cube(size=[MOUNT_OUTER_WIDTH, FLANGE_LENGTH-3, FLANGE_HEIGHT], center=true);
            }
            translate([0, MOUNT_PANEL_RADIUS, 0]){
                cube(size=[MOUNT_OUTER_WIDTH, FLANGE_LENGTH-2, FLANGE_HEIGHT], center=true);
            }  
        }
    }
}


module lowerArmStopPeg(){
    rotate([0, 90, 0]) {
        cylinder(r=5,h=6,$fn=_sideRes);
    }
}


module axle(){
    translate([0, 0, MOUNT_PANEL_RADIUS+LID_HEIGHT+5]) {
        rotate([0, 90, 0]) {
            cylinder(r=AXLE_RAD, h=AXLE_HEIGHT, center=true, $fn=_sideRes);
        }
    }
}

module axleDriveGear(){
    translate([-25, 0, MOUNT_PANEL_RADIUS+LID_HEIGHT+5]) {
        rotate([0, 180, 0]){ 
            difference(){
                 import("E:/Programerinos/userSave/RoboArm/drawings/M1-T24 Gear.stl");
                 translate([17, 0, 0]) {
                    cube(20, center=true);
                 }

                  translate([-19.7, 0, 0]) {
                    cube(30, center=true);
                 }
            }
           
        }
    }
}


module motorStandIn(){
    union(){
        cube([MOTOR_WIDTH, MOTOR_WIDTH, MOTOR_HEIGHT]);
        translate([MOTOR_WIDTH/2, MOTOR_WIDTH/2, MOTOR_HEIGHT]) {
            cylinder(r=MOTOR_SHAFT_THRU_RADIUS, h=3, center = true, $fn=_sideRes);
            translate([0, 0, 12]) {
                cylinder(r=MOTOR_SHAFT_RADIUS,h=21, center=true,$fn=_sideRes);
            }
        }
    } 
}

module bearingMount(){
    translate([MOUNT_OUTER_WIDTH-BEARING_OD-(BEARING_HEIGHT*2.14), 0, MOUNT_PANEL_RADIUS+BEARING_ID/1.1]) {
        rotate([0, 90, 0]) {
            difference(){
               cylinder(r=(BEARING_OD/2)+3.2,h=BEARING_HEIGHT+1.5, $fn=_sideRes);
                translate([0, 0, 2.]) {
                     cylinder(r=(BEARING_OD/2),h=BEARING_HEIGHT, $fn=_sideRes);
                }
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
        }
    }
    
}

module bearingCapOuterArm(){
    translate([BEARING_HEIGHT/2.4, 0, ARM_SHLDR_ELBW_HEIGHT/7]) {
        difference(){
             union(){
                cube(size=[BEARING_HEIGHT/1.2, BEARING_OD/1.5 , ARM_SHLDR_ELBW_HEIGHT/8], center=true);
            
                translate([0,0,12]){
                    rotate([90, 90, 0]){
                        cylinder(r=BEARING_OD/3, h=20.13, center=true, $fn=3);
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
    translate([BEARING_HEIGHT+3, 0, 0]) {
        rotate([45, 0, 0]) {
              axleFlangeMount();
        }
    }
}

module axleFlangeMount(){
     difference(){
        union(){
            translate([-3.3, 0, 0]) {
                 rotate([0, 90, 0]) {
                    difference(){
                        cylinder(r=17.5, h=3, center=true, $fn=_sideRes);
                        translate([0, 0, 1]) {
                            cylinder(r=16.2, h=BEARING_HEIGHT, center=true, $fn=_sideRes);
                        }
                    }
                }
            }
          
            translate([-8.29, 0, 0]) {
                cube([BEARING_HEIGHT/1.2,35,35], center=true);
            }
        }

         

           translate([-16, 12, 0]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(38,5,30);
               }
           }

            translate([-16, -12, 0]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(38,5,30);
               }
           }     

           
            translate([-16, 0, 12]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(38,5,30);
               }
           }    

           
            translate([-16, 0, -12]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(38,5,30);
               }
           }       
           

       
        rotate([0, 90, 0]) {
             cylinder(r=AXLE_RAD+.2, h=35, center=true, $fn=_sideRes);
        }
    }
}


module mainLowerArm(){
    innerArmSupport();
    //outerArmSupport();
}

module innerArmSupport(){
    union(){
        
        //center axis
        translate([0, 0,(MOTOR_HEIGHT+ARM_SHLDR_ELBW_HEIGHT/1.5)]) {
            union(){
                
                difference(){
                     //central brace
                    braceWidth = MOUNT_OUTER_WIDTH+(BEARING_HEIGHT*3.5);
                    union(){
                        translate([0, 0, -ARM_SHLDR_ELBW_HEIGHT/4]) {
                                 crossBrace();
                        }       
                       
                    }

                    translate([0, 0, 25]) {
                        cylinder(r=AXLE_RAD, h=ARM_SHLDR_ELBW_HEIGHT+75, center=true, $fn=_sideRes);
                    }

                    centralAxleStabilizer();

                     translate([0, 0, ARM_MOUNT_HEIGHT]){
                        centralAxleStabilizer();
                    }

                     translate([0, 0, ARM_MOUNT_HEIGHT*2]){
                        centralAxleStabilizer();
                    }
                  
                }
            }
        }

        translate([0, 0, 118]) {
            rotate([0, 0, 90]) {
                  //outerArmShell();
            }
        }

        // //outer shell attachment
        translate([0, 0, 110.5]) {
            difference(){
                cylinder(r1=BEARING_OD+2, r2=BEARING_OD+8.5, h=15, center = true, $fn=_sideRes);
               
               translate([0, 0,ARM_SHLDR_ELBW_HEIGHT/1.95]) {
                    cylinder(r=AXLE_RAD, h=ARM_SHLDR_ELBW_HEIGHT, center=true, $fn=_sideRes);
               }
               

                translate([0, BEARING_OD+2, 0]) {
                    cylinder(r=1.65,h=60,center=true,$fn=_sideRes);
                       translate([0, 0, -14]) {
                        cylinder(r=2.7, h=14, $fn=_sideRes);
                    }
                }
                

                translate([0, -BEARING_OD-2, 0]) {
                    cylinder(r=1.65,h=60,center=true,$fn=_sideRes);
                     translate([0, 0, -14]) {
                        cylinder(r=2.7, h=14, $fn=_sideRes);
                    }
                }


                 translate([-BEARING_OD-8, 0, 0]) {
                    cylinder(r=3,h=60,center=true,$fn=_sideRes);
                }

                 translate([BEARING_OD+8, 0, 0]) {
                    cylinder(r=3,h=60,center=true,$fn=_sideRes);
                }
            }

             translate([0,0,(-ARM_SHLDR_ELBW_HEIGHT/8)+.2]){
                difference(){
                    innerArmXBrace(0);
                    translate([0, 0, -10.8]) {
                        cube(50,center=true);
                    }
                }    
            }
           
        }
    }
}

module crossBrace(){
     union(){
        union(){
            difference(){
                    cube(size=[UPPER_ARM_BRACE_WIDTH, UPPER_ARM_BRACE_THIC, 8], center=true);

                translate([0, 0, 2]) {
                    cylinder(r=AXLE_RAD, h=5, center=true, $fn=_sideRes);
                }

                    translate([(UPPER_ARM_BRACE_WIDTH/2)-16.5,0,-6.2]){
                    boltAndCaptiveNut(25,7,25);
                    }

                    translate([(UPPER_ARM_BRACE_WIDTH/2)-27.5,0,-6]){
                    boltAndCaptiveNut(25,7,25);
                    }

                    mirror([1,0,0]){
                        translate([(UPPER_ARM_BRACE_WIDTH/2)-16.5,0,-6.2]){
                        boltAndCaptiveNut(25,7,25);
                    }

                    translate([(UPPER_ARM_BRACE_WIDTH/2)-27.5,0,-6]){
                        boltAndCaptiveNut(25,7,25);
                    }
                    }
            }
            
            //slide in arm attachment
            translate([(UPPER_ARM_BRACE_WIDTH/2)-22,0,-11]){
                    bearingCapInsert();
                }

                    mirror([1,0,0]){
                        translate([(UPPER_ARM_BRACE_WIDTH/2)-22,0,-11]){
                        bearingCapInsert();
                    }
                }
        }
    }
}

module centralAxleStabilizer(){
    rotate([45, 90, 0]){
       union(){
        cylinder(r=1.65,h=60,center=true,$fn=_sideRes);
            translate([0, 0, -19]) {
                cylinder(r=2.5, h=5, center=true, $fn=_sideRes);
            }
            
            translate([0,0,-12]) {
                cube([5.8,55,2.8], center=true);
            
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

module innerArmXBrace(snapRadius = 3.30){
    difference(){
         union(){
            rotate([0, 0, 45]) {
                cube(size=[MOUNT_OUTER_WIDTH-36, BEARING_OD/3, ARM_SHLDR_ELBW_HEIGHT/3], center=true);
            }

            rotate([0, 0, -45]) {
                cube(size=[MOUNT_OUTER_WIDTH-36, BEARING_OD/3, ARM_SHLDR_ELBW_HEIGHT/3], center=true);
            }

            translate([10, 10, 4]) {
                cylinder(r=3, h=(ARM_SHLDR_ELBW_HEIGHT/3), center=true, $fn=_sideRes);
            }

             translate([-10, 10, 4]) {
                cylinder(r=3, h=(ARM_SHLDR_ELBW_HEIGHT/3), center=true, $fn=_sideRes);
            }

             translate([-10, -10, 4]) {
                cylinder(r=3, h=(ARM_SHLDR_ELBW_HEIGHT/3), center=true, $fn=_sideRes);
            }

             translate([10, -10, 4]) {
                cylinder(r=3, h=(ARM_SHLDR_ELBW_HEIGHT/3), center=true, $fn=_sideRes);
            }
        }

          translate([10, 10, -27.75]) {
                cylinder(r=snapRadius, h=5, center=true, $fn=_sideRes);
            }

             translate([-10, 10, -27.75]) {
                cylinder(r=snapRadius, h=5, center=true, $fn=_sideRes);
            }

             translate([-10, -10, -27.75]) {
                cylinder(r=snapRadius, h=5, center=true, $fn=_sideRes);
            }

             translate([10, -10, -27.75]) {
                cylinder(r=snapRadius, h=5, center=true, $fn=_sideRes);
            }

        translate([0, 0, -52]) {
                union(){
                    translate([0, 0,18]) {
                        difference(){
                            cylinder(r=(MOUNT_OUTER_WIDTH-34)/2,h=ARM_SHLDR_ELBW_HEIGHT, $fn=_sideRes);
                            translate([0, 0, -2]) {
                                    cylinder(r=((MOUNT_OUTER_WIDTH-34)/2)-2,h=ARM_SHLDR_ELBW_HEIGHT+5, $fn=_sideRes);
                            }
                            
                        }
                    }
            }
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

module outerArmShell(){
    union(){

       outerArmEndCap();

        translate([0, 0,15]) {
            difference(){
                cylinder(r=(MOUNT_OUTER_WIDTH-34)/1.7,h=ARM_SHLDR_ELBW_HEIGHT-40, $fn=_sideRes);
                translate([0, 0, -2]) {
                        cylinder(r=((MOUNT_OUTER_WIDTH-34)/2),h=ARM_SHLDR_ELBW_HEIGHT+5, $fn=_sideRes);
                }
            }
        }
        
        translate([0,0,168]){
            mirror([0,0,1]){
                  outerArmEndCap();
            }
        }
        
    }
}

module outerArmEndCap(){
 difference(){
        difference(){
            cylinder(r1=BEARING_OD+8,r2=(MOUNT_OUTER_WIDTH-35)/1.7,h=20, $fn=_sideRes);
            translate([0,0,-2]){
                cylinder(r1=BEARING_OD+6, r2=(MOUNT_OUTER_WIDTH-33)/2.3,h=20, $fn=_sideRes);
            }
            translate([0,0,16]){
                cylinder(r=((MOUNT_OUTER_WIDTH-38)/2)+2,h=20, $fn=_sideRes);
            } 
        }

        footMountingScrewHole();

        mirror([1, 0, 0]) {
            footMountingScrewHole();
        }
        

    }
}

module footMountingScrewHole(){
     translate([BEARING_OD+2, 0, -10]) {
            cylinder(r=1.65,h=35,$fn=_sideRes);

            translate([0, 0, 17]){
                cylinder(r=2.85, h=14, $fn=_sideRes);
            } 

            // //nut slot
            // translate([-1.3, 0, 19]) {
            //     cube([9,5.8,2.8], center=true);
            // }
        }
}

module shoulderMotorBracket(){
    extensionOffset = 6;
    union(){
        difference(){
           cube([MOTOR_WIDTH,MOTOR_WIDTH+extensionOffset+1,MOTOR_HEIGHT+1]);

            translate([-2, 2, -4.5]) {
                cube([MOTOR_WIDTH+5,MOTOR_WIDTH+7,MOTOR_HEIGHT+4]);
            }

            translate([(MOTOR_WIDTH)/2, ((MOTOR_WIDTH+6)/2)+extensionOffset-.3, MOTOR_HEIGHT-5]) {
                cylinder(r=11.35,h=25,$fn=_sideRes);
            }

            translate([5.8, 8.6+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }

            translate([MOTOR_WIDTH-5.8, 8.6+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }

            translate([5.8, 39+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }

            translate([MOTOR_WIDTH-5.8, 39+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }

        }

        difference(){
                scale([2.5, 1, 1]) {
                translate([MOTOR_WIDTH/5, 0, 25]){
                    rotate([0, 0, 45]){
                        cylinder(r1=MOTOR_WIDTH/4.3, r2=.1, h=MOTOR_WIDTH, center=true, $fn=4);
                    } 
                } 
            }

            translate([2,2,0]){
                cube([MOTOR_HEIGHT+6,MOTOR_HEIGHT,MOTOR_HEIGHT]);
            }
            translate([0,-2,MOTOR_HEIGHT+1.001]){
                cube(MOTOR_HEIGHT);
            }
        }
      
       

        translate([0, (-MOTOR_WIDTH/2), 0]) {
            difference(){
                union(){
                    translate([0, -20, 0]) {
                        cube([MOTOR_WIDTH,(MOTOR_WIDTH/2)+20,5]);
                    }
                    translate([MOTOR_WIDTH/2, -16, 11.575]){
                        rotate([90, 30, 0]) {
                            cylinder(r=(MOTOR_WIDTH/2)+2, h=8, center=true, $fn=3);
                        }
                    } 
                   
                }
                

                translate([MOTOR_WIDTH-10, 0, -5.8]) {
                    cylinder(r=1.65,h=10,$fn=_sideRes);
                    translate([0, 0, 9]) {
                        cylinder(r=2.5, h=2, $fn = _sideRes);
                    }
                }

                translate([MOTOR_WIDTH/4, 0, -5.8]) {
                    cylinder(r=1.65,h=10,$fn=_sideRes);
                    translate([0, 0, 9]) {
                        cylinder(r=2.5, h=2, $fn = _sideRes);
                    }
                }
                             
            }
        }

        if(extensionOffset != 0){
            translate([0,0,extensionOffset+2]){
                cube([MOTOR_WIDTH,extensionOffset+2.3,(MOTOR_HEIGHT-extensionOffset)-2]);
            }
                        
        }
    }
}

module bearingCapInsert(){
    difference(){
        union(){
            cube(size=[24, UPPER_ARM_BRACE_THIC, 15], center=true);
            translate([-12, 0, 2.4]) {
                rotate([90,-30,0]){
                    cylinder(r=9.9, h=UPPER_ARM_BRACE_THIC, center=true, $fn=3);
                }
            }

            mirror([1,0,0]){
                    translate([-12, 0, 2.4]) {
                    rotate([90,-30,0]){
                        cylinder(r=9.9, h=UPPER_ARM_BRACE_THIC, center=true, $fn=3);
                    }
                }
            }
        }
        braceBearingSlideAttachment();
    }
}

module braceBearingSlideAttachment(){
    union(){
         rotate([90, 90, 0]){
            cylinder(r=(BEARING_OD/3)+1.4, h=25.13, center=true, $fn=3);
        }

        translate([5.5, 0, 0]) {
            rotate([0,180,0]) {
                boltAndCaptiveNut(0,5,25);
            }
        }

        translate([-5.5, 0, 0]) {
            rotate([0,180,0]) {
                boltAndCaptiveNut(0,5,25);
            }
        }
        translate([0, 0, -6]) {
            cube(size=[(BEARING_HEIGHT/1.2)+1, 25, 10], center=true); 
        }
    }
}


