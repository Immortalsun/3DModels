//main base dimensions
BASE_RAD = 69;//mm
BASE_HEIGHT = 75;//mm
BASE_THICKNESS = 5;//mm

//base foot dimensions
FOOT_LENGTH = 35;//mm
FOOT_WIDTH = 25;//mm
FOOT_HEIGHT = 22;//mm
FOOT_SCREWHOLE_RAD = 1.375;//mm
SCREWHOLE_COUNTERSINK_HEIGHT = 2.75;//mm
SCREWHOLE_COUNTERSINK_RAD = 3.2;//mm

//Lid Dimensions
LID_RAD = 69;
LID_HEIGHT= 4;

//Motor Dimensions
MOTOR_WIDTH = 42.3;//mm
MOTOR_HEIGHT = 38.5;//mm
MOTOR_SHAFT_THRU_RADIUS = 11;//mm

//motor screwhole dimensions
MTR_SCREW_RAD = 1.45;//mm
MTR_SCREW_HEIGHT = 5.3;//mm
MTR_SCREW_COUNTERSINK_HEIGHT = 2;//mm
MTR_SCREW_COUNTERSINK_RAD = 2.7;//mm

//bearing dimensions
BEARING_ID = 10.2;//mm
BEARING_OD = 30.2;//mm
BEARING_HEIGHT = 9.2;//mm

//global constants
_sideRes = 300;
_hollowLengthOffset = 5;//mm
//global variables
_crossectionThiccness = 150;//mm
_footSinkDepth = 4.8;//mm

main();

module main(){
    difference(){
        panelMount();
        //crossSection(_crossectionThiccness);
        //SoppositeCrossSection(_crossectionThiccness);S
    }
    
}

module gearPlatformInsert(){
    import("E:/Programerinos/userSave/RoboArm/drawings/M1-T60-Gear.stl");
}

module Lid(){
    union(){
        //   difference(){
        //     translate([0, 0, 4]) {  
        //         cylinder(r=LID_RAD, h=LID_HEIGHT, $fn=_sideRes);
        //     }
        //     translate([0, 0, -4]){
        //         cylinder(r=18.2, h=15, $fn=_sideRes);
        //     } 
            
        // }
       lidGear();
    }
}

module lidGear(){
    difference(){
         union(){
            difference(){
                rotate([0, -90, 0]) {
                    gearPlatformInsert();
                }
                translate([0, 0, -5.2]) {
                    union(){
                        cylinder(r=(BEARING_OD/2)+.4, h=BEARING_HEIGHT+1.5, $fn=_sideRes);
                        translate([0, 0, 15]) {
                            cylinder(r=17.7, h=20, $fn=_sideRes);
                        }
                    }
                }

                translate([0, 0, -7.7]) {
                     cylinder(r=35, h=6, center=true, $fn=_sideRes);
                }
               
            }  
            translate([0, 0, 5]) {
                cylinder(r=17.6, h=4.8, $fn=_sideRes);
            }

        }

        cylinder(r=2, h=15, $fn=_sideRes);

        translate([0,24.5,0]){
            cylinder(r=1.85, h=15, center=true, $fn=_sideRes);
        }

         translate([0,-24.5,0]){
            cylinder(r=1.85, h=15, center=true, $fn=_sideRes);
        }
        
                    
    }
}

module panelMount(){
    union(){
        // difference(){
        //     cylinder(r=BASE_RAD,h=BASE_HEIGHT, $fn=_sideRes);
        //     translate([0, 0, _hollowLengthOffset]) {
        //         cylinder(r=BASE_RAD-BASE_THICKNESS, h=BASE_HEIGHT+_hollowLengthOffset, $fn=_sideRes);
        //     }
        //     motorMountPeg();
        //     footPeg();
        //     rotate([0, 0, 90]) {
        //         footPeg();
        //     }
        //     rotate([0, 0, 180]) {
        //         footPeg();
        //     }
        //     rotate([0, 0, 270]) {
        //         footPeg();
        //     }
        // }

        

        // radial symmetry foots
        // foot();
        // rotate([0, 0, 90]) {
        //     foot();
        // }
        // rotate([0, 0, 180]) {
        //     foot();
        // }
        //  rotate([0, 0, 270]) {
        //     foot();
        // }

        motorMount();
        
        // bearingMount();

        translate([0,0,0]) {
            //Lid();
        }
     }
}

module motorMount(){
    translate([-MOTOR_WIDTH-18, (-MOTOR_WIDTH/2)-3, 3]) {
            motorBracket();
        }
}

module motorMountPeg(){
    translate([-MOTOR_WIDTH-18, (-MOTOR_WIDTH/2)-3, 3]) {
            motorBracketPeg();
        }
}

module motorBracket(){
    extensionOffset = 0;
    union(){
        difference(){
            translate([-8, 0, 0]) {
                cube([MOTOR_WIDTH+8,MOTOR_WIDTH+2,MOTOR_HEIGHT+1]);
            }
            translate([-9, 2, -4.5]) {
                cube([MOTOR_WIDTH+10,MOTOR_WIDTH+6,MOTOR_HEIGHT+4]);
            }

            translate([(MOTOR_WIDTH)/2, ((MOTOR_WIDTH+6)/2)+extensionOffset, MOTOR_HEIGHT-5]) {
                cylinder(r=11.35,h=25,$fn=_sideRes);
            }

            translate([MOTOR_WIDTH-6, 9+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }


            translate([6, 9+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }

            translate([6, (MOTOR_WIDTH-3)+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }

            translate([MOTOR_WIDTH-6, (MOTOR_WIDTH-3)+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }

             translate([MOTOR_WIDTH+14, (MOTOR_WIDTH)+3+(-MOTOR_WIDTH/2), -4]) {
                    difference(){
                        cylinder(r=BASE_RAD+6,h=BASE_HEIGHT, $fn=_sideRes);
                        translate([0, 0, _hollowLengthOffset-3]) {
                            cylinder(r=BASE_RAD-(BASE_THICKNESS), h=BASE_HEIGHT+_hollowLengthOffset, $fn=_sideRes);
                        }
                    }
                }
        }

        difference(){
                scale([2.5, 1, 1]) {
                translate([MOTOR_WIDTH/5, 0, 25]){
                    rotate([0, 0, 45]){
                        cylinder(r1=MOTOR_WIDTH/4, r2=.1, h=MOTOR_WIDTH, center=true, $fn=4);
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
                    translate([-3, 0, 0]) {
                        cube([MOTOR_WIDTH+3,(MOTOR_WIDTH/2),5]);
                    }
                    // translate([MOTOR_WIDTH/2, 4, 11.575]){
                    //     rotate([90, 30, 0]) {
                    //         cylinder(r=(MOTOR_WIDTH/2)+2, h=8, center=true, $fn=3);
                    //     }
                    // } 
                   
                }
                

                translate([MOTOR_WIDTH/1.35, MOTOR_WIDTH/5, -5]) {
                    cylinder(r=1.65,h=10,$fn=_sideRes);
                    translate([0, 0, 9]) {
                        cylinder(r=2.5, h=2, $fn = _sideRes);
                    }
                }

                translate([MOTOR_WIDTH/3, MOTOR_WIDTH/5, -5]) {
                    cylinder(r=1.65,h=10,$fn=_sideRes);
                    translate([0, 0, 9]) {
                        cylinder(r=2.5, h=2, $fn = _sideRes);
                    }
                }

            
                translate([MOTOR_WIDTH+14, (MOTOR_WIDTH)+3, -4]) {
                    difference(){
                        cylinder(r=BASE_RAD+6,h=BASE_HEIGHT, $fn=_sideRes);
                        translate([0, 0, _hollowLengthOffset-3]) {
                            cylinder(r=BASE_RAD-(BASE_THICKNESS), h=BASE_HEIGHT+_hollowLengthOffset, $fn=_sideRes);
                        }
                    }
                }
                 
            }
        }

        if(extensionOffset != 0){
            translate([0,0,extensionOffset]){
                cube([MOTOR_WIDTH,extensionOffset-.5,MOTOR_HEIGHT-extensionOffset]);
            }
                        
        }
    }
}

module motorBracketPeg(){
    union(){
    translate([MOTOR_WIDTH/1.35, MOTOR_WIDTH/5+(-MOTOR_WIDTH/2), -5]) {
            cylinder(r=1.65,h=10,$fn=_sideRes);
            translate([0, 0, 9]) {
                cylinder(r=2.5, h=2, $fn = _sideRes);
            }
        }

        translate([MOTOR_WIDTH/3, MOTOR_WIDTH/5+(-MOTOR_WIDTH/2), -5]) {
            cylinder(r=1.65,h=10,$fn=_sideRes);
            translate([0, 0, 9]) {
                cylinder(r=2.5, h=2, $fn = _sideRes);
            }
        }
    }
}

module bearingMount(){
    translate([0, 0, 5]) {
        difference(){
            union(){
                cylinder(r=(BEARING_OD/2)+1.2,h=BEARING_HEIGHT, $fn=_sideRes);
                cylinder(r1=(BEARING_OD),r2=0.1,h=BASE_HEIGHT/2, $fn=3);
            }
            translate([0, 0, .2]) {
                union(){
                    cylinder(r=(BEARING_OD/2),h=BEARING_HEIGHT+35, $fn=_sideRes);
                    translate([0, 0, BEARING_HEIGHT-.19]) {
                        cylinder(r=(BEARING_OD/2)+8, h=25, $fn=_sideRes);
                    }
                    
                }
                
            }
        }
    }
   
}

module foot(){
    difference(){
         translate([BASE_RAD-_footSinkDepth, -FOOT_WIDTH/2, 0]) {
            difference(){
                difference(){
                    cube([FOOT_LENGTH,FOOT_WIDTH,FOOT_HEIGHT]);
                    translate([FOOT_LENGTH-7, 8, FOOT_HEIGHT+10]) {
                        rotate([0,-75,0]){
                            cylinder(r1=FOOT_WIDTH*2, r2=.1, h=FOOT_HEIGHT+24,$fn=3);
                        }
                    }
                    translate([21.55, -1, FOOT_HEIGHT-14.15]) {
                        cube([FOOT_LENGTH,FOOT_WIDTH+2,FOOT_HEIGHT]);
                    }
                    
                }
                translate([FOOT_LENGTH-5, FOOT_WIDTH/2, -FOOT_HEIGHT+_hollowLengthOffset]) {
                    cylinder(r=FOOT_SCREWHOLE_RAD, h=FOOT_HEIGHT+_hollowLengthOffset, $fn=_sideRes);
                }
                translate([FOOT_LENGTH-5, FOOT_WIDTH/2, FOOT_HEIGHT-14.29-SCREWHOLE_COUNTERSINK_HEIGHT]) {
                    cylinder(r=SCREWHOLE_COUNTERSINK_RAD, h=SCREWHOLE_COUNTERSINK_HEIGHT+5, $fn=_sideRes);
                }
                footMountingScrewHole();
            }
        }

        translate([0,0,-2]){
             difference(){
                cylinder(r=BASE_RAD,h=BASE_HEIGHT, $fn=_sideRes);
                translate([0, 0, _hollowLengthOffset]) {
                    cylinder(r=BASE_RAD-BASE_THICKNESS, h=BASE_HEIGHT+_hollowLengthOffset, $fn=_sideRes);
                }
            }
        }
       
    }
}

module footPeg(){
    translate([BASE_RAD-_footSinkDepth, -FOOT_WIDTH/2, 0]) {
        footMountingScrewHole();
    }
}

module footMountingScrewHole(){
     translate([-5.5, FOOT_WIDTH/2, FOOT_HEIGHT/2]) {
        rotate([0, 90, 0]) {
            cylinder(r=1.65,h=35,$fn=_sideRes);

            translate([0, 0, 22]){
                cylinder(r=2.5, h=4, $fn=_sideRes);
            } 

            //nut slot

            translate([-1.3, 0, 19]) {
                cube([9,5.8,2.8], center=true);
            }
        }
    }
}


module crossSection(thiccness){
    rotate([0, 0, -90]) {
        translate([-BASE_RAD*2, 0, -1]) {
            cube([BASE_HEIGHT*4,thiccness,BASE_HEIGHT*2]);
        }   
    }
}

module oppositeCrossSection(thiccness){
    rotate([0, 0, 0]) {
        translate([-BASE_RAD*2, 0, -1]) {
            cube([BASE_HEIGHT*4,thiccness,BASE_HEIGHT*2]);
        }   
    }
}