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
    import("E:/Programerinos/userSave/RoboArm/drawings/rb_LIDv2.stl");
    difference(){
        union(){
            platformAttachment();
    
        }
        // /crossSection(50);
    }
}

module platformAttachment(){
    union(){
        
    }
}

module platformSidePanels(){
}




module axle(){
   
}


module motorStandIn(){
      union(){
        cube([MOTOR_WIDTH, MOTOR_WIDTH, MOTOR_HEIGHT], center=true);

        translate([0, 0, MOTOR_HEIGHT/2]) {
            cylinder(r=MOTOR_SHAFT_THRU_RADIUS, h=10, center = true, $fn=_sideRes);
            translate([0, 0, 12]) {
                cylinder(r=MOTOR_SHAFT_RADIUS,h=29, center=true,$fn=_sideRes);
            }
        }

        translate([(MOTOR_WIDTH/2)+2.5, 0, (-MOTOR_HEIGHT/2)+4.5]) {
            cube(size=[20, 16, 9], center=true);
        }

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

module mainLowerArm(){

}

module innerArmSupport(){

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


