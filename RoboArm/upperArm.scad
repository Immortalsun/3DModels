
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
    //import elbow
    union(){
         union(){
            importElbowJoint();
            difference(){
                 rotate(a=90, v=[0, 0, 0]) {
                      upperArmInternal();
                 }
                
                 axle();
            }

            translate([PLTFRM_PANEL_HT-9.5,PLTFRM_PANEL_WTH-5, 5]){
                rotate([90,0,-90]){
                     motorStandIn();
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
        //outer caps axle mounts
        bearingCap();
        mirror([1,0,0]){
            bearingCap();
        }

        //main
        translate([0, PLTFRM_PANEL_WTH+10.87, (PLATFORM_HEIGHT*5)+ARM_MOUNT_HEIGHT+BEARING_HEIGHT*2.5]) {
            cube([PLTFRM_PANEL_HT*2.4,BEARING_OD/1.5,PLTFRM_PANEL_HT/3],center=true);
        }

    }
}

module axle(){
     translate([0, MOUNT_PANEL_RADIUS-14, MOUNT_PANEL_RADIUS+LID_HEIGHT+2]) {
        rotate([0, 90, 0]) {
            cylinder(r=AXLE_RAD, h=AXLE_HEIGHT, center=true, $fn=_sideRes);
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