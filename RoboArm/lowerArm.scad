
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
AXLE_HEIGHT = MOUNT_OUTER_WIDTH+(BEARING_HEIGHT*2);
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
PLTFRM_PANEL_HT = MOTOR_HEIGHT+PLATFORM_HEIGHT;
PLTFRM_PANEL_WTH = 25;//mm

//Wire route hole
ROUTE_HT = 4.4;//mm
ROUTE_DEPTH=10;//mm
ROUTE_WTH = 28;//mm

//global constants
_sideRes = 300;


main();



module main(){
    //import shoulder and connected frame
    //internalArmFrame();
    difference(){
         union(){
            translate([0, 0, ARM_SHLDR_ELBW_HEIGHT+PLATFORM_HEIGHT+16]) {
                elbowPlatform();
                elbowMountHousingMain();
            }
        }
        translate([0, 0, (ARM_SHLDR_ELBW_HEIGHT/3)+2]){ 
            outerArmShell();
        }
    }
    // translate([0, 0, (ARM_SHLDR_ELBW_HEIGHT/3)]){ 
    //     outerArmShell();
    // }
   
}


module internalArmFrame(){
    translate([0, 0, -60]) {
        import("E:/Programerinos/userSave/RoboArm/drawings/rb_lower_arm_supportv2.stl");
    }
}

module outerArmShell(){
     difference(){
        cylinder(r=OUTER_SHELL_RAD,h=OUTER_SHELL_HEIGHT, $fn=_sideRes);
        translate([0,0,-2]){
            cylinder(r=OUTER_SHELL_RAD-SHELL_THICKNESS,h=ARM_SHLDR_ELBW_HEIGHT+5, $fn=_sideRes);
        }
    }
}

module elbowPlatform(){
    union(){
        difference(){
            cylinder(r=OUTER_SHELL_RAD+SHELL_THICKNESS+2, h=PLATFORM_HEIGHT,center = true ,$fn=_sideRes);
            cylinder(r=AXLE_RAD+.5, h=PLATFORM_HEIGHT+5,center=true,$fn=_sideRes);
        }

        //motor stand-in 
        // translate([MOTOR_HEIGHT/1.2, 0-LID_RAD/3, MOTOR_WIDTH]) {
        //     rotate([-90, 0, 90]) {
        //         motorStandIn();
        //     }
        // }       
    }
}

module elbowMountHousingMain(){
    difference(){
         union(){
            elbowHousingSidePanel();
            mirror([1, 0, 0]) {
                elbowHousingSidePanel(); 
            }

            //front support clearance for arm and motor\
            union(){
                 difference(){
                    elbowHousingFrontSupport();

                    translate([25, -PLTFRM_PANEL_WTH, PLTFRM_PANEL_HT/1.8]) {
                        cube([13,20,30],center=true);
                    }            
                }
                
            }
           
            


            mirror([0, 1, 0]) {
                union(){
                    translate([0, 2, 0]) {
                        difference(){
                             elbowHousingFrontSupport();
                             translate([0, -25, 32.55]) {
                                 cube([MOTOR_WIDTH+18,PLTFRM_PANEL_THICKNESS,8], center=true);
                             }
                        }
                    }
                    //rear triangular brace
                    union(){
                         translate([0,-5.5, 15]){
                            difference(){
                                rotate([0, 0, 45]) {
                                    cylinder(r1=24, r2 = (MOTOR_WIDTH+44)/2, h=PLTFRM_PANEL_WTH+2, center = true, $fn=4);
                                }
                                translate([0, 7, 0]) {
                                    cube(size=[MOTOR_WIDTH+20, 48, PLTFRM_PANEL_WTH+55], center=true);
                                }
                            }
                        }
                        //45 degree gap fill
                        translate([MOTOR_WIDTH-17.2, -MOTOR_WIDTH+15,20.5]) {
                            difference(){
                                 cube(size=[8, 10, 15], center=true);
                                 translate([0, -4, -7]) {
                                      rotate([45, 0, 0]) {
                                        cube(size=[10, 10, 14], center=true);
                                    }
                                 }
                                
                            }
                        }

                        mirror([1,0,0]){
                            translate([MOTOR_WIDTH-17.2, -MOTOR_WIDTH+15, 20.5]) {
                                difference(){
                                    cube(size=[8, 10, 15], center=true);
                                    translate([0, -4, -7]) {
                                        rotate([45, 0, 0]) {
                                            cube(size=[10, 10, 14], center=true);
                                        }
                                    }
                                    
                                }
                            }
                        }
                        //end gap fill
                    }
                }
            }
        }
    }
}

module elbowHousingFrontSupport(){
    translate([0, -25.5, PLATFORM_HEIGHT+11]){ 
        union(){
            cube([MOTOR_WIDTH+18,PLTFRM_PANEL_THICKNESS-1.7,PLTFRM_PANEL_WTH+6.9], center=true);
        }
    }
}

module elbowHousingSidePanel(){
    translate([MOTOR_WIDTH-PLTFRM_PANEL_WTH/2.35, -1, 22]) {
          union(){
            cube([PLTFRM_PANEL_THICKNESS,MOTOR_WIDTH+10,PLTFRM_PANEL_WTH+15], center=true);
            difference(){
                 union(){
                    translate([0, PLTFRM_PANEL_WTH, PLTFRM_PANEL_HT/2]) {
                        rotate([45, 0, 0]) {
                            cube([PLTFRM_PANEL_THICKNESS,MOTOR_WIDTH+2,PLTFRM_PANEL_WTH+10], center=true);
                        }
                        translate([-2.5, 12, 12]){
                            bearingMount();
                        }
                    }
                }
                //axle mount
                translate([-1.2, PLTFRM_PANEL_WTH+12, (PLTFRM_PANEL_HT/2)+12]){
                    rotate([0, 90, 0]){
                        cylinder(r=AXLE_RAD+.2, h=MOTOR_WIDTH+10, center=true, $fn=_sideRes);
                    }
                    translate([.5, 0, 0]) {
                         bearingInsert();
                    }
                   
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
        cylinder(r=(BEARING_OD/2)+.4,h=BEARING_HEIGHT, $fn=_sideRes);
    }
}

module wireRouteHole(){
    cube([ROUTE_DEPTH,ROUTE_HT,ROUTE_WTH], center=true);    
}
