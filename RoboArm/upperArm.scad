
//LID PARAMS
//Lid Dimensions
LID_RAD = 69;
LID_HEIGHT= 4;

//shoulder mount flange dimensions
FLANGE_HEIGHT = 20;//mm
FLANGE_WIDTH = LID_RAD*1.5;
FLANGE_LENGTH = 10;//mm

//Motor Dimensions
MOTOR_WIDTH = 42.3;//mm
MOTOR_HEIGHT = 34;//mm //smaller NEMA motor, other height is 38.5
MOTOR_SHAFT_THRU_RADIUS = 11;//mm
MOTOR_SHAFT_RADIUS = 2.5;//mm

//motor screwhole dimensions
MTR_SCREW_RAD = 1.45;//mm
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

//Shoulder Axle params
AXLE_RAD = 5.1;//mm
AXLE_HEIGHT = MOUNT_OUTER_WIDTH+(BEARING_HEIGHT*4);
SUPPORT_HEIGHT = 75;
//Arm mount params
ARM_MOUNT_HEIGHT = MOUNT_OUTER_WIDTH-(BEARING_HEIGHT*2)-15;
ARM_SHLDR_ELBW_HEIGHT = 175;

//Outer housing
OUTER_SHELL_RAD = BEARING_OD+8;//mm
OUTER_SHELL_HEIGHT =  ARM_SHLDR_ELBW_HEIGHT-40;
SHELL_THICKNESS = 3.5;//mm

//Elbow Platform
PLATFORM_HEIGHT = 5;//mm
PLTFRM_PANEL_THICKNESS = 5;//mm
PLTFRM_PANEL_HT = 39;//mm
PLTFRM_PANEL_WTH = 25;//mm

//Upper Arm
UPPER_ARM_LENGTH = 175;//mm
UPPER_ARM_BRACE_WIDTH = 93.6;//mm
UPPER_ARM_BRACE_THIC = 20.13;//mm
UPPER_ARM_BRACE_HT = 20;//mm

//Wire route hole
ROUTE_HT = 4.4;//mm
ROUTE_DEPTH=10;//mm
ROUTE_WTH = 28;//mm

//global constants
_sideRes = 300;

main();

module main(){
    //import elbow
    difference(){
         union(){
            //importElbowJoint();
            difference(){
                 rotate(a=0, v=[1, 0, 0]) {
                      upperArmInternal();
                 }
                
                 axle();
            }

            translate([PLTFRM_PANEL_HT-9.5,PLTFRM_PANEL_WTH-5, 5]){
                rotate([90,0,-90]){
                     //motorStandIn();
                }
               
            } 
           
        }

        axle();
    }
   
}

module importElbowJoint(){
    translate([0, 0, -ARM_SHLDR_ELBW_HEIGHT-32]) {
         import("E:/Programerinos/userSave/RoboArm/drawings/rb_Elbow_Mountv5.stl");
    }
}

module upperArmInternal(){
    union(){
        braceZTrans = (PLATFORM_HEIGHT*5)+ARM_MOUNT_HEIGHT+BEARING_HEIGHT*2.5;
        braceYTrans = PLTFRM_PANEL_WTH+10.87;
        axleShaftYTans = -MOUNT_PANEL_RADIUS;
        axleShaftZTrans = braceZTrans;

        //outer caps axle mounts
        bearingCap();
        mirror([1,0,0]){
            bearingCap();
        }


        //main brace
        translate([0, braceYTrans, braceZTrans]) {
            difference(){
                cube([UPPER_ARM_BRACE_WIDTH,UPPER_ARM_BRACE_THIC,UPPER_ARM_BRACE_HT],center=true);
                //subtract axle
                translate([0, axleShaftYTans-braceYTrans, 0]) {
                    rotate([90, 0, 0]) {
                        cylinder(r=AXLE_RAD, h = UPPER_ARM_LENGTH+12, center=true, $fn=_sideRes);
                    }
                }
            }
        }

            //central axis mount
        translate([0,axleShaftYTans,axleShaftZTrans]){
            upperArmAxleShaft();
        }

            //sleeve attachment point
        translate([0, braceYTrans+1, braceZTrans-UPPER_ARM_BRACE_HT/1.6]){
                upperArmSleeveMount();
        } 

        //wrist attachment mount
        translate([0, -UPPER_ARM_LENGTH+26, axleShaftZTrans]){
            upperArmWristMount();
        }         
    }
}

module upperArmSleeveMount(){
    union(){
        cylinder(r=25, h=5, center=true, $fn=_sideRes);
        translate([0, 0, 17]){
            difference(){
                cylinder(r1=22.5, r2=25.5, h=39, center=true, $fn=_sideRes);

              
                translate([0, -8.7, 0]) {
                    rotate([45, 0, 0]) {
                        difference(){
                            cylinder(r=(UPPER_ARM_BRACE_WIDTH/3.5)+12, h=40, center=true, $fn=_sideRes);
                            translate([0, 0, -1]) {
                                cylinder(r=(UPPER_ARM_BRACE_WIDTH/3.5)+.25, h=45, center=true, $fn=_sideRes);
                            }
                        }
                    }
                }
            }
        }

        union(){
            translate([4, -1, -26]){
                 rotate([90,0,90]){
                    cylinder(r=AXLE_RAD+3, h=AXLE_HEIGHT/3, center=true, $fn=_sideRes);
                }
            }

            translate([0, 0, -12])  {
                rotate([0, 0, 0]) {
                    cylinder(r1=8, r2=22, h=20, center=true, $fn=4);
                }
            }
           
        } 
    }
}

module upperArmWristMount(){
    union(){
        translate([0, 4, 0]) {
              difference(){
                rotate([90, 0, 0]) {
                    cylinder(r=UPPER_ARM_BRACE_WIDTH/6, h=6, center=true, $fn=_sideRes);
                }
                rotate([90, 0, 0]) {
                    cylinder(r=UPPER_ARM_BRACE_WIDTH/7, h=14, center=true, $fn=_sideRes);
                }
            }
        }
      
    }
}

module upperArmAxleShaft(){
    shaftThiccness = 2.5;//mm
    flangeDepth = 10;
    rotate([90,0,0]){
        //axle shaft
        difference(){
            union(){
                difference(){
                    cylinder(r=AXLE_RAD+shaftThiccness, h = UPPER_ARM_LENGTH, center=true, $fn=_sideRes);

                    union(){
                        translate([0,10,8]){
                            centralAxleStabilizer();
                        }
                         
                        translate([0, 10, (UPPER_ARM_LENGTH/4)+8]){
                            centralAxleStabilizer();
                        }

                        translate([0,10,(-UPPER_ARM_LENGTH/4)+8]){
                             centralAxleStabilizer();
                        } 
                    }
                }
                
                 //support Flange
                
                 supportFlangeZTrans = (-UPPER_ARM_LENGTH/2)+flangeDepth;
                 difference(){  
                     axleShaftSupportFlange();
                     //bottom flange trim

                     translate([0,-20,supportFlangeZTrans-(UPPER_ARM_LENGTH/12)]) {
                         rotate([-90, 0, 0]){
                             cube([50,40,15],center=true);
                         } 
                     }
                 }

                mirror([0,0,1]){
                   difference(){
                       axleShaftSupportFlange();
                       translate([0, 0, -UPPER_ARM_LENGTH/2]) {
                            difference(){
                            cylinder(r=(UPPER_ARM_BRACE_WIDTH/3.5)+2, h=40, center=true, $fn=_sideRes);
                                translate([0, 0, -1]) {
                                    cylinder(r=(UPPER_ARM_BRACE_WIDTH/3.5)-8, h=45, center=true, $fn=_sideRes);
                                }
                            }
                       }
                   } 
                }

                translate([0, 10, 8]) {
                    difference(){
                        cube(size=[10, 10, UPPER_ARM_LENGTH-20], center=true);

                        centralAxleStabilizer();
                        translate([0, 0, UPPER_ARM_LENGTH/4]){
                            centralAxleStabilizer();
                        }

                        translate([0,0,-UPPER_ARM_LENGTH/4]){
                             centralAxleStabilizer();
                        } 
                    }
                    
                }

                
            }
            
            cylinder(r=AXLE_RAD, h = UPPER_ARM_LENGTH+12, center=true, $fn=_sideRes);
        }
        
    }
}

module axleShaftSupportFlange(){
    flangeDepth = 10;
    translate([0, 0, (-UPPER_ARM_LENGTH/2)+flangeDepth])  {
        cylinder(r1=UPPER_ARM_BRACE_WIDTH/4, r2 =2,  h=UPPER_ARM_BRACE_HT+10, center=true, $fn=_sideRes);
    }
}


module axle(){
     translate([0, MOUNT_PANEL_RADIUS-14, MOUNT_PANEL_RADIUS+LID_HEIGHT+2]) {
        rotate([0, 90, 0]) {
            cylinder(r=AXLE_RAD, h=AXLE_HEIGHT, center=true, $fn=_sideRes);
        }
    }
}

module centralAxleStabilizer(){
    rotate([90, 90, 0]) {
         union(){
            cylinder(r=1.65,h=60,center=true,$fn=_sideRes);
            translate([0, 0, -4]) {
                cylinder(r=2.5, h=5, center=true, $fn=_sideRes);
            }
            
          cube([5.8,22,2.8], center=true);
        }
    }
   
}

module motorStandIn(){
    union(){
        cube([MOTOR_WIDTH, MOTOR_WIDTH, MOTOR_HEIGHT]);
        translate([MOTOR_WIDTH/2, MOTOR_WIDTH/2, MOTOR_HEIGHT]) {
            cylinder(r=MOTOR_SHAFT_THRU_RADIUS, h=3, center = true, $fn=_sideRes);
            translate([0, 0, 11]) {
                cylinder(r=MOTOR_SHAFT_RADIUS,h=30, center=true,$fn=_sideRes);
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
   rotate([0, 90, 0]) {
        cylinder(r=(BEARING_OD/2)+.1,h=BEARING_HEIGHT, $fn=_sideRes);
    }
}

module bearingCap(){
    union(){
        translate([MOUNT_OUTER_WIDTH-BEARING_OD-(BEARING_HEIGHT), MOUNT_OUTER_WIDTH/2.23, MOUNT_PANEL_RADIUS+BEARING_ID/1.86]) {
            rotate([0, 90, 0]) {
                cylinder(r=(BEARING_OD/2)+2.5,h=BEARING_HEIGHT, $fn=_sideRes);
            }
            bearingCapLockMount();
            bearingCapOuterArm();
        }
    }
    
}

module bearingCapOuterArm(){
    translate([BEARING_HEIGHT/3, 0, ARM_SHLDR_ELBW_HEIGHT/6]) {
        cube(size=[BEARING_HEIGHT/1.5, BEARING_OD/1.5 , ARM_SHLDR_ELBW_HEIGHT/6], center=true);
    }
}

module bearingCapLockMount(){
    translate([BEARING_HEIGHT+4.2, 0, 0]) {
        difference(){
             union(){
                rotate([0, 90, 0]) {
                    difference(){
                        cylinder(r=15.4, h=BEARING_HEIGHT, center=true, $fn=_sideRes);
                        translate([0, 0, 1]) {
                            cylinder(r=12.8, h=BEARING_HEIGHT, center=true, $fn=_sideRes);
                        }
                    }
                }
            }
            translate([0, 9, 10]) {
                cylinder(r=1.65,h=10,center=true,$fn=_sideRes);
                translate([0, 0, 0]){
                    cylinder(r=2.5, h=5, $fn=_sideRes);
                } 
                
            }
            translate([0, -9, 10]) {
                cylinder(r=1.65,h=10,center=true,$fn=_sideRes);
                translate([0, 0, 0]){
                    cylinder(r=2.5, h=5, $fn=_sideRes);
                } 
            }

        }
    }
}