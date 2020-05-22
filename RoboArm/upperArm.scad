
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

//global constants
_sideRes = 300;

main();

module main(){
    //import elbow
    union(){
         union(){
            // translate([0, -OUTER_SHELL_RAD+1, -ARM_MOUNT_HEIGHT*1.2]) {
            //     importElbowJoint();
            // }
            
            difference(){
                 upperArmInternal();
                
                 axle();
            }

            translate([PLTFRM_PANEL_HT-9.5,PLTFRM_PANEL_WTH-5, 5]){
                rotate([90,0,-90]){
                     //motorStandIn();
                }
               
            } 
           
        }

        //axle();
    }
   
}

module importElbowJoint(){
    translate([0, 0, -ARM_SHLDR_ELBW_HEIGHT-32]) {
         import("E:/Programerinos/userSave/RoboArm/drawings/rb_Elbow_Mountv5.stl");
    }
}

module upperArmInternal(){
    difference(){
        union(){
            wristZTrans = ARM_SHLDR_ELBW_HEIGHT*1.25;

            //outer caps axle mounts
            translate([0, 0, 0]) {
                   bearingCap();
                mirror([1,0,0]){
                    //bearingCap();
                }
            }
         

            //main brace
            //upperArmMainBrace();

            //wrist mount
            translate([0, 0, wristZTrans]) {
                //upperArmWristMount();
                //wristKey();
            }
            
            translate([0,0,MOUNT_OUTER_WIDTH/1.5]){
               //upperArmSleeve();
            }
        
        }
        translate([0, 0, 0]) {
             axle();
        }
        
    }
    
}

module upperArmPlate(){
    difference(){
        union(){
            cylinder(r1=25, r2=35, h=11, center=true, $fn=_sideRes);
            translate([0, 0, (-ARM_SHLDR_ELBW_HEIGHT/6)+4]){
                difference(){
                    innerArmXBrace();
                    cylinder(r=AXLE_RAD, h=ARM_SHLDR_ELBW_HEIGHT, center=true, $fn=_sideRes);
                    translate([0, 0, -5.8]) {
                        cube([40,40,55], center=true);
                    }
                }
            } 
        }

        translate([35, 0, 8]) {
            cylinder(r=3, h=12, center=true, $fn=_sideRes);
        }

            translate([-35, 0, 8]) {
            cylinder(r=3, h=12, center=true, $fn=_sideRes);
        }
    }  
}

module upperArmMainBrace(){
    translate([0, 0, ARM_MOUNT_HEIGHT-7]){
         union(){
            //attachment platform
            difference(){
                translate([0, 0, 1.5]) {
                     upperArmPlate();
                }
              

                translate([0, 0, 2]) {
                    cylinder(r=AXLE_RAD, h=5, center=true, $fn=_sideRes);
                }
            

                 translate([15, -25, 2]) {
                    cylinder(r=2, h=35, center=true, $fn=_sideRes);
                }

                translate([15, 25, 2]) {
                    cylinder(r=2, h=35, center=true, $fn=_sideRes);
                }

                 translate([-15, -25, 2]) {
                    cylinder(r=2, h=35, center=true, $fn=_sideRes);
                }

                translate([-15, 25, 2]) {
                    cylinder(r=2, h=35, center=true, $fn=_sideRes);
                }
            }
            
           
            //crossbrace
            union(){
                union(){
                    difference(){
                         cube(size=[UPPER_ARM_BRACE_WIDTH, UPPER_ARM_BRACE_THIC, 8], center=true);

                        translate([0, 0, 2]) {
                            cylinder(r=AXLE_RAD, h=5, center=true, $fn=_sideRes);
                        }

                         translate([(UPPER_ARM_BRACE_WIDTH/2)-16.5,0,-6.2]){
                           boltAndCaptiveNut(0,7,25);
                         }

                         translate([(UPPER_ARM_BRACE_WIDTH/2)-27.5,0,-6]){
                           boltAndCaptiveNut(0,7,25);
                         }

                         mirror([1,0,0]){
                              translate([(UPPER_ARM_BRACE_WIDTH/2)-16.5,0,-6.2]){
                                boltAndCaptiveNut(0,7,25);
                            }

                            translate([(UPPER_ARM_BRACE_WIDTH/2)-27.5,0,-6]){
                                boltAndCaptiveNut(0,7,25);
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

            //inner arm braces for reference
            // difference(){
            //      union(){
            //         translate([0,0,ARM_SHLDR_ELBW_HEIGHT/6]){
            //             innerArmXBrace();
            //         }

            //         translate([0,0,ARM_SHLDR_ELBW_HEIGHT/2]){
            //             innerArmXBrace();
            //         }

            //         translate([0,0,ARM_SHLDR_ELBW_HEIGHT/1.2]){
            //             innerArmXBrace();
            //         }
            //     }

            //     translate([0, 0, 75]) {
            //           cylinder(r=AXLE_RAD+.2, h=250, center=true, $fn=_sideRes);
            //     }
            // }
            //end brace reference
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

module upperArmWristMount(){
    snapRadius = 3.25;
    union(){
        difference(){
            //identical plate for elbow crossbrace
            cylinder(r1=28, r2=38, h=8, center=true, $fn=_sideRes);

            translate([0, 0, 2]) {
                cylinder(r=AXLE_RAD, h=15, center=true, $fn=_sideRes);
            }

            translate([0, 0, -1.8]) {
                snapFitMaleArrangement(3.25,5);
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
                    cylinder(r=36.5, h=8, center=true, $fn=_sideRes);
                    translate([0, 0, 3]) {
                        cylinder(r=26.5, h=12, center=true, $fn=_sideRes);
                    }

                    translate([0, 0, -4]) {
                        cylinder(r=33.5, h=11.75, center=true, $fn=_sideRes);
                    }
                }

                translate([0,0,2]){
                    scale([1.005, 1.005, 1]) {
                         wristKeyTemplate();
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
            }
             
        }

        //wrist key test
        translate([0, 0, 10]) {
            rotate([0,0,0]){
                //wristKey();
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
            cylinder(r=26, h = 5, center=true, $fn=_sideRes);
            translate([0, 0, 0]) {
                cube(size=[68, 9.8, 5], center=true);
                cube(size=[9.8, 68, 5], center=true);
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

module snapFitMaleArrangement(pegRadius = 3, pegHeight = 3){

    translate([10, 10, 0]) {
        cylinder(r=pegRadius, h=pegHeight, center=true, $fn=_sideRes);
    }

    translate([-10, 10, 0]) {
        cylinder(r=pegRadius, h=pegHeight, center=true, $fn=_sideRes);
    }

    translate([-10, -10, 0]) {
        cylinder(r=pegRadius, h=pegHeight, center=true, $fn=_sideRes);
    }

    translate([10, -10, 0]) {
        cylinder(r=pegRadius, h=pegHeight, center=true, $fn=_sideRes);
    }
}

module snapFitFemaleArrangement(holeRadius = 3.25, holeDepth = 3.25){
    translate([10, 10, -27.75]) {
        cylinder(r=holeRadius, h=holeDepth, center=true, $fn=_sideRes);
    }

    translate([-10, 10, -27.75]) {
        cylinder(r=holeRadius, h=holeDepth, center=true, $fn=_sideRes);
    }

    translate([-10, -10, -27.75]) {
        cylinder(r=holeRadius, h=holeDepth, center=true, $fn=_sideRes);
    }

    translate([10, -10, -27.75]) {
        cylinder(r=holeRadius, h=holeDepth, center=true, $fn=_sideRes);
    }
}

module upperArmSleeve(){
    union(){
        //main tube
        difference(){
            cylinder(r=((MOUNT_OUTER_WIDTH-34)/2)+2,h=ARM_SHLDR_ELBW_HEIGHT-20, $fn=_sideRes);
            translate([0, 0, -2]) {
                    cylinder(r=((MOUNT_OUTER_WIDTH-34)/2),h=ARM_SHLDR_ELBW_HEIGHT+5, $fn=_sideRes);
            }
            translate([0,0,-2]){
                cylinder(r=((MOUNT_OUTER_WIDTH-34)/2)+2.1, h=5, $fn=_sideRes);
            }
        }

        //base mount attachment
        translate([0,0,-2]){
            difference(){
                union(){
                    cylinder(r1=35, r2=((MOUNT_OUTER_WIDTH-34)/2), h=15, center=true, $fn=_sideRes);
                     translate([15, -25, 0]) {
                        cylinder(r=4, h=10, center=true, $fn=_sideRes);
                    }

                    translate([15, 25, 0]) {
                        cylinder(r=4, h=10, center=true, $fn=_sideRes);
                    }

                        translate([-15, -25, 0]) {
                        cylinder(r=4, h=10, center=true, $fn=_sideRes);
                    }

                    translate([-15, 25, 0]) {
                        cylinder(r=4, h=10, center=true, $fn=_sideRes);
                    }
                }   
                
                union(){
                     translate([0, 0, -15]) {
                        cylinder(r=((MOUNT_OUTER_WIDTH-34)/2),h=ARM_SHLDR_ELBW_HEIGHT+5, $fn=_sideRes);
                    }
                    cylinder(r1=33, r2=((MOUNT_OUTER_WIDTH-34)/2)-3, h=18, center=true, $fn=_sideRes);
                }
                
                translate([15, -25, 2]) {
                    cylinder(r=2, h=35, center=true, $fn=_sideRes);
                }

                translate([15, 25, 2]) {
                    cylinder(r=2, h=35, center=true, $fn=_sideRes);
                }

                    translate([-15, -25, 2]) {
                    cylinder(r=2, h=35, center=true, $fn=_sideRes);
                }

                translate([-15, 25, 2]) {
                    cylinder(r=2, h=35, center=true, $fn=_sideRes);
                }
            }
        }

        //wrist mount attachment
        translate([0, 0, ARM_SHLDR_ELBW_HEIGHT-15]){
            difference(){
                 union(){
                    cylinder(r1=((MOUNT_OUTER_WIDTH-34)/2)+2, r2=38, h=10, center=true, $fn=_sideRes);
                    translate([0, 0, 6]) {
                         difference(){
                            cylinder(r=38, h=5, center=true, $fn=_sideRes);
                            cylinder(r=35, h=20, center=true, $fn=_sideRes);
                        }
                    }

                    rotate([0, 0, 45]){
                        translate([30, 0, 0]){
                            cylinder(r=4, h=10, center=true, $fn=_sideRes);
                        } 
                    }

                    rotate([0, 0, 135]){
                        translate([30, 0, 0]){
                            cylinder(r=4, h=10, center=true, $fn=_sideRes);
                        } 
                    }  

                    rotate([0, 0, 225]){
                        translate([30, 0, 0]){
                            cylinder(r=4, h=10, center=true, $fn=_sideRes);
                        } 
                    }  
                    
                    rotate([0, 0, 315]){
                        translate([30, 0, 0]){
                            cylinder(r=4, h=10, center=true, $fn=_sideRes);
                        } 
                    }  
                }

                 cylinder(r1=((MOUNT_OUTER_WIDTH-34)/2)-2.5, r2=35, h=15, center=true, $fn=_sideRes);

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


module axle(){
   rotate([0, 90, 0]) {
        cylinder(r=AXLE_RAD, h=AXLE_HEIGHT, center=true, $fn=_sideRes);
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

module bearingCap(){
    union(){
        translate([MOUNT_OUTER_WIDTH-BEARING_OD-(BEARING_HEIGHT)+1, 0, 0]) {
            
            bearingCapLockMount();
            bearingCapOuterArm();
        }
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

module bearingCapOuterArm(){
    translate([BEARING_HEIGHT/2.4, 0, ARM_SHLDR_ELBW_HEIGHT/8]) {
        difference(){
             union(){
                 translate([0, 0, 2.4]) {
                    cube(size=[BEARING_HEIGHT/1.2, BEARING_OD/1.5 , (ARM_SHLDR_ELBW_HEIGHT/10.7)], center=true);
                 }
            
                translate([0,0,12]){
                    rotate([90, 90, 0]){
                        cylinder(r=BEARING_OD/3, h=20.13, center=true, $fn=3);
                    } 
                }

                 translate([3, 0, -2.25]) {
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

            translate([0, 0, -18.34]) {
                rotate([0, 0, 0]) {
                      cylinder(r=16.2, h=BEARING_HEIGHT+16, center=true, $fn=_sideRes);
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

module innerArmXBrace(snapRadius = 3.25){
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