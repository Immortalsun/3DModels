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
AXLE_RAD = 5.25;//mm
AXLE_HEIGHT = MOUNT_OUTER_WIDTH+(BEARING_HEIGHT*14);
SUPPORT_HEIGHT = 75;
//Arm mount params
ARM_MOUNT_HEIGHT = MOUNT_OUTER_WIDTH-(BEARING_HEIGHT*2)-15;
ARM_SHLDR_ELBW_HEIGHT = 175;
//global constants
_sideRes = 300;

main();

module main(){
    //import("E:/Programerinos/userSave/RoboArm/drawings/rb_LID+GEAR_MOUNT.stl");
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
                    translate([(MOUNT_PANEL_RADIUS/2)+1, 0, 0]) {
                        cube(size=[MOUNT_PANEL_RADIUS, MOUNT_PANEL_RADIUS*2.5, MOUNT_PANEL_RADIUS*2.5], center=true);
                    }
                    cylinder(r=MOUNT_PANEL_RADIUS+2, h=MOUNT_OUTER_WIDTH-MOUNT_WALL_THICKNESS, center=true, $fn=_sideRes);
                }
            }

            platformFlange();

            mirror([1, 0, 0]) {
                platformFlange();
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

module platformFlange(){
    translate([(MOUNT_OUTER_WIDTH/2)-(FLANGE_LENGTH/1), (-LID_RAD/1.5)-6, -FLANGE_HEIGHT/2]) {
        union(){
            cube([FLANGE_LENGTH,FLANGE_WIDTH,FLANGE_HEIGHT]);
        
            translate([FLANGE_LENGTH, FLANGE_WIDTH/6, FLANGE_HEIGHT/2]){
                 lowerArmStopPeg();
            }

            translate([FLANGE_LENGTH, FLANGE_WIDTH-20, FLANGE_HEIGHT/2]){
                 lowerArmStopPeg();
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
        translate([MOUNT_OUTER_WIDTH-BEARING_OD-(BEARING_HEIGHT)+1, 0, MOUNT_PANEL_RADIUS+BEARING_ID/1.1]) {
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

module bearingCapLimitExtentsion(){
  
}

module mainLowerArm(){
    innerArmSupport();
    outerArmSupport();
}

module innerArmSupport(){
    union(){
         translate([6, 0, MOUNT_PANEL_RADIUS+LID_HEIGHT+5]) {
            rotate([0, 90, 0]) {
                   cylinder(r=AXLE_RAD+2, h=ARM_MOUNT_HEIGHT, center=true, $fn=_sideRes);
            }
        }

        //center axis
        translate([0, 0, MOTOR_HEIGHT+ARM_SHLDR_ELBW_HEIGHT/1.5]) {
            union(){
                  translate([0, 0, 26]) {
                      difference(){
                           union(){
                            difference(){
                                cylinder(r=AXLE_RAD+2, h=ARM_SHLDR_ELBW_HEIGHT+55, center=true, $fn=_sideRes);
                                cylinder(r=AXLE_RAD, h=ARM_SHLDR_ELBW_HEIGHT+85, center=true, $fn=_sideRes);
                            }
                        }
                            translate([0, 0, -26]){
                                centralAxleStabilizer();
                            }
                            

                            translate([0, 0, ARM_MOUNT_HEIGHT-26]){
                                centralAxleStabilizer();
                            }

                            translate([0, 0, (ARM_MOUNT_HEIGHT*2)-26]){
                                centralAxleStabilizer();
                            }
                        }
                     }
                
                difference(){
                     //central brace
                    union(){
                        translate([0, 0, -ARM_SHLDR_ELBW_HEIGHT/4]) {
                            cube(size=[MOUNT_OUTER_WIDTH+BEARING_HEIGHT+6.2, BEARING_OD/1.5, 8], center=true);
                        }

                        translate([40.6,0,-50]){
                            rotate([90, -40, 0]){
                                cylinder(r=BEARING_OD/4, h=20.13, center=true, $fn=3);
                            } 
                            
                        }

                        mirror([1,0,0]){
                             translate([40.6,0,-50]){
                                rotate([90, -40, 0]){
                                    cylinder(r=BEARING_OD/4, h=20.13, center=true, $fn=3);
                                } 
                                
                            }
                        }

                         
                          innerArmXBrace();
                       

                         translate([0, 0, ARM_MOUNT_HEIGHT]){
                           innerArmXBrace();
                        }

                         translate([0, 0, ARM_MOUNT_HEIGHT*2]){
                           innerArmXBrace();
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
                  outerArmShell();
            }
        }

        // //outer shell attachment
        translate([0, 0, 111]) {
            difference(){
                cylinder(r1=BEARING_OD+2, r2=BEARING_OD+8.5, h=15, center = true, $fn=_sideRes);
               
                cylinder(r=AXLE_RAD, h=ARM_SHLDR_ELBW_HEIGHT+85, center=true, $fn=_sideRes);
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
                    cube([5.8,22,2.8], center=true);
                
                }
            
            }
        }
}

module innerArmXBrace(){
    difference(){
         union(){
            rotate([0, 0, 45]) {
                cube(size=[MOUNT_OUTER_WIDTH-36, BEARING_OD/3, 65], center=true);
            }

            rotate([0, 0, -45]) {
                cube(size=[MOUNT_OUTER_WIDTH-36, BEARING_OD/3, 65], center=true);
            }
        }

        translate([0, 0, -52]) {
                union(){
                    difference(){
                        cylinder(r1=BEARING_OD+8,r2=(MOUNT_OUTER_WIDTH-35)/2,h=20, $fn=_sideRes);
                        translate([0,0,-2]){
                            cylinder(r1=BEARING_OD+6, r2=(MOUNT_OUTER_WIDTH-33)/2,h=20, $fn=_sideRes);
                        }
                        translate([0,0,16]){
                            cylinder(r=(MOUNT_OUTER_WIDTH-38)/2,h=20, $fn=_sideRes);
                        } 
                    }

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
            bearingCap();
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


