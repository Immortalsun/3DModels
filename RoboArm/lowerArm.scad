
//LID PARAMS
//Lid Dimensions
LID_RAD = 69;
LID_HEIGHT= 4;

//shoulder mount flange dimensions
FLANGE_HEIGHT = 20;//mm
FLANGE_WIDTH = LID_RAD*1.5;
FLANGE_LENGTH = 10;//mm

//Motor Dimensions
MOTOR_WIDTH = 42.2;//mm
MOTOR_HEIGHT = 34;//mm //smaller NEMA motor, other height is 38.5
MOTOR_SHAFT_THRU_RADIUS = 11;//mm
MOTOR_SHAFT_RADIUS = 2.5;//mm

//motor screwhole dimensions
MTR_SCREW_RAD = 1.65;//mm
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
            translate([0, 0, ARM_SHLDR_ELBW_HEIGHT+PLATFORM_HEIGHT+29.5]) {
                // elbowPlatform();
                // elbowMountHousingMain();

               motorBracket();
                
               //motorStandIn();
            }
        }
        translate([0,0,206.5]){
            rotate([0, 0, 90]) {
                mirror([0,0,1]){
                    footMountingScrewHole();

                    mirror([1, 0, 0]) {
                        footMountingScrewHole();
                    }
                }
            }
        }
        // translate([0, 0, 8]) {
        //     cylinder(r=AXLE_RAD+.1, h=450, center=true, $fn=_sideRes);
        // }
     }
    translate([0, 0, 38.5]){ 
        rotate([0, 0, 90]) {
            //outerArmShell();
        }
    }

   
}


module internalArmFrame(){
  import("E:/Programerinos/userSave/RoboArm/drawings/rb_lower_arm_supportv5.stl");
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

            translate([0, 0, 20]){
                cylinder(r=2.5, h=19, $fn=_sideRes);
            } 

            // //nut slot
            // translate([-1.3, 0, 19]) {
            //     cube([9,5.8,2.8], center=true);
            // }
        }
}


module elbowPlatform(){
    union(){
        difference(){
            cylinder(r=OUTER_SHELL_RAD+SHELL_THICKNESS+2, h=PLATFORM_HEIGHT,center = true ,$fn=_sideRes);
            cylinder(r=AXLE_RAD+.2, h=PLATFORM_HEIGHT+5,center=true,$fn=_sideRes);

             translate([0, 0, (-ARM_SHLDR_ELBW_HEIGHT/6)-2.6]){
                innerArmXBrace();
            }     
        }

        //base support ring
        supportRingHeight = 8.75;
        supportRingThickness = 10;
        translate([0, 0, (-supportRingHeight/2)-2.6]) {
            difference(){
                cylinder(r=OUTER_SHELL_RAD, h=supportRingHeight, center=true, $fn=_sideRes);
                translate([0, 0, -.1]){
                    cylinder(r=OUTER_SHELL_RAD-supportRingThickness, h=supportRingHeight+5, center=true, $fn=_sideRes);
                } 
            }
        }
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
                        cube([13.5,20,30],center=true);
                    }            
                }
                
            }
           
            


            mirror([0, 1, 0]) {
                difference(){
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
                            translate([MOTOR_WIDTH-16.7, -MOTOR_WIDTH+15,20.5]) {
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
                                translate([MOTOR_WIDTH-16.7, -MOTOR_WIDTH+15, 20.5]) {
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

                     translate([-17, -22, 29]) {
                         union(){
                             rotate([45, 0, 0]) {
                                cube([16.8,PLTFRM_PANEL_THICKNESS+2.5,8], center=true);
                            }
                         }                        
                    }
                }
            }
        }

        //motor bracket mount
        translate([12.5, -2.3, (MOTOR_WIDTH/2)+2.5]) {
                translate([-MOTOR_HEIGHT-10, (MOTOR_WIDTH/2)-5, (-MOTOR_WIDTH/2)+5]) {
                    rotate([0, 90, 0]) {
                        cylinder(r=MTR_SCREW_RAD, h=15, center=true, $fn=_sideRes);
                    }
                }

                 translate([-MOTOR_HEIGHT-10, -(MOTOR_WIDTH/2)+5, (-MOTOR_WIDTH/2)+5]) {
                   rotate([0, 90, 0]) {
                        cylinder(r=MTR_SCREW_RAD, h=15, center=true, $fn=_sideRes);
                    }
                }

                 translate([-MOTOR_HEIGHT-10, (MOTOR_WIDTH/2)-5, (-MOTOR_WIDTH/2)+35]) {
                    rotate([0, 90, 0]) {
                        cylinder(r=MTR_SCREW_RAD, h=15, center=true, $fn=_sideRes);
                    }
                }

                 translate([-MOTOR_HEIGHT-10, -(MOTOR_WIDTH/2)+5, (-MOTOR_WIDTH/2)+35]) {
                   rotate([0, 90, 0]) {
                        cylinder(r=MTR_SCREW_RAD, h=15, center=true, $fn=_sideRes);
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
    translate([MOTOR_WIDTH-PLTFRM_PANEL_WTH/2.45, -1, 22]) {
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
        cube([MOTOR_WIDTH, MOTOR_WIDTH, MOTOR_HEIGHT], center=true);

        translate([0, 0, MOTOR_HEIGHT/2]) {
            cylinder(r=MOTOR_SHAFT_THRU_RADIUS, h=18, center = true, $fn=_sideRes);
            translate([0, 0, 12]) {
                cylinder(r=8.2,h=29, center=true,$fn=_sideRes);
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
                cylinder(r=MTR_SCREW_RAD+.2, h=32, center=true, $fn=_sideRes);
            }
        }

        rotate([0,0,270]){
            translate([(MOTOR_WIDTH/2)-5.5,(MOTOR_WIDTH/2)-5,MOTOR_HEIGHT/2]){
                cylinder(r=MTR_SCREW_RAD+.2, h=32, center=true, $fn=_sideRes);
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

module innerArmXBrace(snapRadius = 3.25){
    difference(){
         union(){
            rotate([0, 0, 45]) {
                cube(size=[MOUNT_OUTER_WIDTH-36, BEARING_OD/3, ARM_SHLDR_ELBW_HEIGHT/3], center=true);
            }

            rotate([0, 0, -45]) {
                cube(size=[MOUNT_OUTER_WIDTH-36, BEARING_OD/3, ARM_SHLDR_ELBW_HEIGHT/3], center=true);
            }

            translate([10, 10, 3]) {
                cylinder(r=3.2, h=(ARM_SHLDR_ELBW_HEIGHT/3)+5, center=true, $fn=_sideRes);
            }

             translate([-10, 10, 3]) {
                cylinder(r=3.2, h=(ARM_SHLDR_ELBW_HEIGHT/3)+5, center=true, $fn=_sideRes);
            }

             translate([-10, -10, 3]) {
                cylinder(r=3.2, h=(ARM_SHLDR_ELBW_HEIGHT/3)+5, center=true, $fn=_sideRes);
            }

             translate([10, -10, 3]) {
                cylinder(r=3.2, h=(ARM_SHLDR_ELBW_HEIGHT/3)+5, center=true, $fn=_sideRes);
            }
        }

          translate([10, 10, -27.75]) {
                cylinder(r=snapRadius, h=3, center=true, $fn=_sideRes);
            }

             translate([-10, 10, -27.75]) {
                cylinder(r=snapRadius, h=3, center=true, $fn=_sideRes);
            }

             translate([-10, -10, -27.75]) {
                cylinder(r=snapRadius, h=3, center=true, $fn=_sideRes);
            }

             translate([10, -10, -27.75]) {
                cylinder(r=snapRadius, h=3, center=true, $fn=_sideRes);
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

module motorBracket(){
    mountX = 24.85;
    mountY = 45;
    mountZ = MOTOR_WIDTH;
    union(){
         translate([12.5, -2.3, (MOTOR_WIDTH/2)+2.5]) {

             difference(){
                 union(){
                    difference(){
                        translate([-MOTOR_HEIGHT+4.5, 1, 0]){
                            cube(size=[mountX, mountY, mountZ], center=true);
                        } 

                        translate([-MOTOR_HEIGHT+4.5, 1, 2]) {
                            cube([mountX-8, mountY+2, mountZ], center=true);
                        }

                        translate([-MOTOR_HEIGHT-7, 2, 39.5]) {
                           cube([8, mountY+4, mountZ], center=true);
                        }
                    }

                    translate([-19, (mountY/2)+1, -20]) {
                         rotate([0, -90, 90]) {
                            triangle(mountY/2, mountX/2, mountY);
                        }
                    }  
                }

                //countersink cutouts for motor mount
                translate([-MOTOR_HEIGHT+5.08, (MOTOR_WIDTH/2)-5, (-MOTOR_WIDTH/2)+5.4]) {
                    rotate([0, 90, 0]) {
                        cylinder(r=MTR_SCREW_COUNTERSINK_RAD+2, h=18, center=true, $fn=_sideRes);
                    }
                }

                 translate([-MOTOR_HEIGHT+5.08, -(MOTOR_WIDTH/2)+5, (-MOTOR_WIDTH/2)+5.4]) {
                   rotate([0, 90, 0]) {
                        cylinder(r=MTR_SCREW_COUNTERSINK_RAD+2, h=18, center=true, $fn=_sideRes);
                    }
                }
                //end countersinks

                //motor bracket mount to elbow joint screws
                translate([-MOTOR_HEIGHT-10, (MOTOR_WIDTH/2)-5, (-MOTOR_WIDTH/2)+5]) {
                    rotate([0, 90, 0]) {
                        cylinder(r=MTR_SCREW_RAD, h=15, center=true, $fn=_sideRes);
                    }
                }

                 translate([-MOTOR_HEIGHT-10, -(MOTOR_WIDTH/2)+5, (-MOTOR_WIDTH/2)+5]) {
                   rotate([0, 90, 0]) {
                        cylinder(r=MTR_SCREW_RAD, h=15, center=true, $fn=_sideRes);
                    }
                }

                 translate([-MOTOR_HEIGHT-10, (MOTOR_WIDTH/2)-5, (-MOTOR_WIDTH/2)+35]) {
                    rotate([0, 90, 0]) {
                        cylinder(r=MTR_SCREW_RAD, h=15, center=true, $fn=_sideRes);
                    }
                }

                 translate([-MOTOR_HEIGHT-10, -(MOTOR_WIDTH/2)+5, (-MOTOR_WIDTH/2)+35]) {
                   rotate([0, 90, 0]) {
                        cylinder(r=MTR_SCREW_RAD, h=15, center=true, $fn=_sideRes);
                    }
                }
                //end motor bracket mount to elbow joint screws

                rotate([90, 0, -90]) {
                    motorStandIn();
                }

             }
        }
    }
}

module wireRouteHole(){
    cube([ROUTE_DEPTH,ROUTE_HT,ROUTE_WTH], center=true);    
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
