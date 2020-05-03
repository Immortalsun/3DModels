
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
UPPER_ARM_BRACE_WIDTH = 135;//mm
UPPER_ARM_BRACE_THIC = 20.13;//mm
UPPER_ARM_BRACE_HT = 20;//mm

//Wire route hole
ROUTE_HT = 4.4;//mm
ROUTE_DEPTH=10;//mm
ROUTE_WTH = 28;//mm

//Servo Dimensions
SERVO_HT = 41;//mm
SERVO_WTH = 20.5;//mm
SERVO_LTH = 40.5;//mm
SERVO_GEAR_HT = 4;//mm
SERVO_FLANGE_HT = 2.6;//mm
SERVO_FLANGE_WTH = 7.5;//mm
SERVO_FLANGE_HOLE_DIST =  10;//mm
SERVO_CONNECTOR_HT = 4;//mm
SERVO_CONNECTOR_WTH = 7;//mm
SERVO_CONNECTOR_BASE_Z_TRANS = 4.2;//mm


//Axle hub dimensions
AXL_HUB_IRad = 5.1;//mm
AXL_HUB_DISC_HT = 3;//mm
AXL_HUB_ORad = 13.5;//mm
AXLE_HUB_SHAFT_HT = 10;//mm
AXLE_HUB_SHAFT_THICKNESS = 3;//mm

//global constants
_sideRes = 300;



main();

module main(){
    union(){

        wristKey();

        translate([0, 0, MOTOR_HEIGHT]) {
            motorStandIn();
        }

        translate([0, 0, -15]) {
             upperArmWristMount();
        }
    }
}


module keyAttachmentMount(){
    
}



//hand modules will have to mount on the wrist key
//this item will be made out of metal
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
       

       translate([30, 0, 0]){
            cylinder(r=2, h=40, center=true, $fn=_sideRes);
        } 

        rotate([0, 0, 90]){
            translate([30, 0, 0]){
                cylinder(r=2, h=40, center=true, $fn=_sideRes);
            } 
        }  

        rotate([0, 0, 180]){
            translate([30, 0, 0]){
                cylinder(r=2, h=40, center=true, $fn=_sideRes);
            } 
        }  
        
        rotate([0, 0, 270]){
            translate([30, 0, 0]){
                cylinder(r=2, h=40, center=true, $fn=_sideRes);
            } 
        }

         translate([15, 0, 0]){
            cylinder(r=2, h=40, center=true, $fn=_sideRes);
        } 

        rotate([0, 0, 90]){
            translate([15, 0, 0]){
                cylinder(r=2, h=40, center=true, $fn=_sideRes);
            } 
        }  

        rotate([0, 0, 180]){
            translate([15, 0, 0]){
                cylinder(r=2, h=40, center=true, $fn=_sideRes);
            } 
        }  
        
        rotate([0, 0, 270]){
            translate([15, 0, 0]){
                cylinder(r=2, h=40, center=true, $fn=_sideRes);
            } 
        }

        cylinder(r=AXLE_RAD+.2, h=40, center=true, $fn=_sideRes);  
    }
}

module upperArmWristMount(){
    snapRadius = 3.25;
    union(){
        difference(){
            //identical plate for elbow crossbrace
            cylinder(r1=28, r2=38, h=8, center=true, $fn=_sideRes);

            translate([0, 0, 2]) {
                cylinder(r=AXLE_RAD, h=15, center=true, $fn=_sideRes);
            }

            // translate([0, 0, -1.8]) {
            //     snapFitMaleArrangement(3.25,5);
            // }

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

module motorStandIn(){
    union(){
        cube([MOTOR_WIDTH, MOTOR_WIDTH, MOTOR_HEIGHT], center=true);
        translate([0, 0, MOTOR_HEIGHT/2]) {
            cylinder(r=MOTOR_SHAFT_THRU_RADIUS, h=3, center = true, $fn=_sideRes);
            translate([0, 0, 12]) {
                cylinder(r=MOTOR_SHAFT_RADIUS,h=21, center=true,$fn=_sideRes);
            }
        }
    } 
}

module servoStandIn(){
    union(){
        cube([SERVO_WTH, SERVO_LTH, SERVO_HT], center=true);
    }
}
