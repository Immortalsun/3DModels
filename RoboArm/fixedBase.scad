//main base dimensions
BASE_RAD = 69;//mm
BASE_HEIGHT = 84.5;//mm
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

AXLE_RAD = 5.1;//mm

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
        // /oppositeCrossSection(_crossectionThiccness);
    }
    
}


module Lid(){
    screwRad = 2;
    screwCapRad = 2.6;
    screwCapZTrans = 2.6;
    union(){
        //   difference(){
        //     translate([0, 0, 0]) {  
        //         cylinder(r=LID_RAD, h=LID_HEIGHT, $fn=_sideRes);
        //     }
        //     translate([0, 0, -1]){
        //        cube([36.5,36.5,15], center=true);
        //     }

        //     translate([25, 0, 0]){
        //         cylinder(r=screwRad, h=30, center=true, $fn=_sideRes);
        //     }

        //     translate([-25, 0, 0]){
        //         cylinder(r=screwRad, h=30, center=true, $fn=_sideRes);
        //     }

        //      translate([0, 25, 0]){
        //         cylinder(r=screwRad, h=30, center=true, $fn=_sideRes);
        //     }

        //     translate([0, -25, 0]){
        //         cylinder(r=screwRad, h=30, center=true, $fn=_sideRes);
        //     }

        //     translate([25, 0, screwCapZTrans]){
        //         cylinder(r=screwCapRad, h=3, center=true, $fn=_sideRes);
        //     }

        //     translate([-25, 0, screwCapZTrans]){
        //         cylinder(r=screwCapRad, h=3, center=true, $fn=_sideRes);
        //     }

        //      translate([0, 25, screwCapZTrans]){
        //         cylinder(r=screwCapRad, h=3, center=true, $fn=_sideRes);
        //     }

        //     translate([0, -25, screwCapZTrans]){
        //         cylinder(r=screwCapRad, h=3, center=true, $fn=_sideRes);
        //     }                     
        // }

        

        translate([0, 0, -3]) {
           //keyedLidBracket();
        }

        translate([0, 0, -10]){
            rotate([0, 90, 0]){
                axleFlangeMount();
            } 
        } 

    }
}

module keyedLidBracket(){
    difference(){
        union(){
             cube([60,60,6],center=true);
             translate([0, 0,3]) {
                cube([36,36,8], center=true);
             }
        }
        
         translate([0, 0, -2]){
              cube([36,36,8], center=true);
         }

         translate([25, 0, 0]){
             cylinder(r=2, h=30, center=true, $fn=_sideRes);

              cube(size=[18, 5.8, 2.8], center=true);
         }

         translate([-25, 0, 0]){
             cylinder(r=2, h=30, center=true, $fn=_sideRes);
               cube(size=[18, 5.8, 2.8], center=true);
         }

         translate([0, 25, 0]){
             cylinder(r=2, h=30, center=true, $fn=_sideRes);
               cube(size=[5.8, 18, 2.8], center=true);
         }

         translate([0, -25, 0]){
             cylinder(r=2, h=30, center=true, $fn=_sideRes);
             cube(size=[5.8, 18, 2.8], center=true);
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
        //     rotate([0, 0, 315]) {
        //         computerBoxWireHole();
        //     }
           
        // }

        // //underside clearance ring
        //  translate([0, 0, -5]) {
        //          difference(){
        //             cylinder(r=BASE_RAD,h=5, $fn=_sideRes);
        //             translate([0, 0, _hollowLengthOffset-6]) {
        //                 cylinder(r=BASE_RAD-BASE_THICKNESS, h=BASE_HEIGHT+_hollowLengthOffset, $fn=_sideRes);
        //             }
        //         }
        //     }

        

        // radial symmetry foots
        foot();
        // rotate([0, 0, 90]) {
        //     foot();
        // }
        // rotate([0, 0, 180]) {
        //     foot();
        // }
        //  rotate([0, 0, 270]) {
        //     foot();
        // }

        //motorMount();
        
        //bearingMount();

        translate([0,0,3]) {
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

module computerBoxWireHole(){
    translate([-BASE_RAD, 0, 15]) {
         cube([25,MOTOR_WIDTH,15], center=true);
    }
   
}

module computerBox(){

}


module motorBracket(){
    extensionOffset = 0;
    union(){
        difference(){
            translate([-6, 0, 0]) {
                difference(){
                    cube([MOTOR_WIDTH+4,MOTOR_WIDTH+4,MOTOR_HEIGHT+1]);
                    translate([0, (MOTOR_WIDTH+4)/2, 4.8]) {
                        cube(size=[15, 10, 10], center=true);
                    }
                }
            }
            translate([0, 2, -4.5]) {
                cube([MOTOR_WIDTH+1,MOTOR_WIDTH+4,MOTOR_HEIGHT+4]);
            }

            translate([(MOTOR_WIDTH)/2, ((MOTOR_WIDTH+6)/2)+extensionOffset, MOTOR_HEIGHT-5]) {
                cylinder(r=11.35,h=25,$fn=_sideRes);
            }

            translate([MOTOR_WIDTH-5.8, 9+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }


            translate([6, 9+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }

            translate([6, (MOTOR_WIDTH-3)+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }

            translate([MOTOR_WIDTH-5.8, (MOTOR_WIDTH-3)+extensionOffset, MOTOR_HEIGHT-2]) {
                cylinder(r=MTR_SCREW_RAD, h=MTR_SCREW_HEIGHT, $fn=_sideRes);
            }

             translate([MOTOR_WIDTH+17, (MOTOR_WIDTH)+3+(-MOTOR_WIDTH/2), -3]) {
                    difference(){
                        cylinder(r=BASE_RAD+5,h=BASE_HEIGHT, $fn=_sideRes);
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
                    translate([-2, 0, 0]) {
                        cube([MOTOR_WIDTH,(MOTOR_WIDTH/2),5]);
                    }
                    // translate([MOTOR_WIDTH/2, 4, 11.575]){
                    //     rotate([90, 30, 0]) {
                    //         cylinder(r=(MOTOR_WIDTH/2)+2, h=8, center=true, $fn=3);
                    //     }
                    // } 
                   
                }
                

                translate([MOTOR_WIDTH/1.35, MOTOR_WIDTH/4, -5]) {
                    cylinder(r=1.65,h=10,$fn=_sideRes);
                    translate([0, 0, 9]) {
                        cylinder(r=2.5, h=2, $fn = _sideRes);
                    }
                }

                translate([MOTOR_WIDTH/3, MOTOR_WIDTH/4, -5]) {
                    cylinder(r=1.65,h=10,$fn=_sideRes);
                    translate([0, 0, 9]) {
                        cylinder(r=2.5, h=2, $fn = _sideRes);
                    }
                }

            
                if(extensionOffset == 0){
                    translate([MOTOR_WIDTH+17, (MOTOR_WIDTH)+3, -3]) {
                        difference(){
                            cylinder(r=BASE_RAD+10,h=BASE_HEIGHT, $fn=_sideRes);
                            translate([0, 0, _hollowLengthOffset-3]) {
                                cylinder(r=BASE_RAD-(BASE_THICKNESS), h=BASE_HEIGHT+_hollowLengthOffset, $fn=_sideRes);
                            }
                        }
                    }
                }
                
                 
            }
        }

        if(extensionOffset != 0){
            translate([0,0,extensionOffset+2]){
                cube([MOTOR_WIDTH,extensionOffset+2,(MOTOR_HEIGHT-extensionOffset)-2]);
            }
                        
        }
    }
}

module motorBracketPeg(){
    union(){
    translate([MOTOR_WIDTH/1.35, MOTOR_WIDTH/5+(-MOTOR_WIDTH/2)+2, -5]) {
            cylinder(r=1.65,h=10,$fn=_sideRes);
            translate([0, 0, 9]) {
                cylinder(r=2.5, h=2, $fn = _sideRes);
            }
        }

        translate([MOTOR_WIDTH/3, MOTOR_WIDTH/5+(-MOTOR_WIDTH/2)+2, -5]) {
            cylinder(r=1.65,h=10,$fn=_sideRes);
            translate([0, 0, 9]) {
                cylinder(r=2.5, h=2, $fn = _sideRes);
            }
        }
    }
}

module bearingMount(){
    translate([0, 0, 5]) {
        // difference(){
        //     union(){
        //         cylinder(r=(BEARING_OD/2)+1.2,h=BEARING_HEIGHT, $fn=_sideRes);
        //         cylinder(r1=(BEARING_OD),r2=0.1,h=BASE_HEIGHT/2, $fn=3);
        //         cylinder(r=(BEARING_OD/2)+1.2, h=MOTOR_HEIGHT-10, $fn=_sideRes);

        //         translate([0, 0, MOTOR_HEIGHT-10]) {
        //            rotate([180,0,0]){
        //                 cylinder(r1=(BEARING_OD),r2=0.1,h=BASE_HEIGHT/4, $fn=3);
        //            }
        //         }

        //         translate([BEARING_OD/1.6, 0, BEARING_HEIGHT*2]) {
        //             cylinder(r=5, h=BEARING_HEIGHT*2.2, center=true, $fn=_sideRes);
        //         }

        //          translate([-BEARING_OD/3.2, BEARING_OD/1.8, BEARING_HEIGHT*1.8]) {
        //            cylinder(r=5, h=BEARING_HEIGHT*2.2, center=true, $fn=_sideRes);
        //         }

        //          translate([-BEARING_OD/3.2, -BEARING_OD/1.8, BEARING_HEIGHT*1.8]) {
        //            cylinder(r=5, h=BEARING_HEIGHT*2.2, center=true, $fn=_sideRes);
        //         }

        //     }

        //     translate([0, 0, .1]) {
        //          cylinder(r=(BEARING_OD/2),h=BEARING_HEIGHT+35, $fn=_sideRes);
        //     }
           

        //     translate([BEARING_OD/1.6, 0, BEARING_HEIGHT*1.8]) {
        //          boltAndCaptiveNut();
        //     }

        //    translate([-BEARING_OD/3.2, BEARING_OD/1.8, BEARING_HEIGHT*1.8]) {
        //         rotate([0, 0, -60]) {
        //                 boltAndCaptiveNut();
        //         }
        //     }

        //      translate([-BEARING_OD/3.2, -BEARING_OD/1.8, BEARING_HEIGHT*1.8]) {
        //         rotate([0, 0, 60]) {
        //                 boltAndCaptiveNut();
        //         }
        //     }
        // }

        // translate([0, 0, 75]) {
             baseBearingBracket();
        // }
    }
}

module baseBearingBracket(){
    union(){
         difference(){
            union(){
                rotate([180,0,0]){
                    cylinder(r1=(BEARING_OD),r2=0.1,h=BASE_HEIGHT/2, $fn=3);
                }

                translate([0, 0, -24.2]){
                    difference(){
                        cylinder(r=(BEARING_OD/2)+1.2,h=BEARING_HEIGHT+15, $fn=_sideRes);
                        translate([0, 0, 5]) {
                            cylinder(r=(BEARING_OD/2),h=BEARING_HEIGHT+15, $fn=_sideRes);
                        }
                        
                    }
                } 
            }
            translate([0, 0, -30]) {
                cylinder(r=(BEARING_OD/2),h=BEARING_HEIGHT+35, $fn=_sideRes);
            }
        
            translate([0,0,-28]){
                cube([60,60,35], center=true);
            }

             translate([BEARING_OD/1.6, 0, BEARING_HEIGHT-10]) {
                 boltAndCaptiveNut();
                }

            translate([-BEARING_OD/3.2, BEARING_OD/1.8, BEARING_HEIGHT-10]) {
                    rotate([0, 0, -60]) {
                            boltAndCaptiveNut();
                    }
                }

                translate([-BEARING_OD/3.2, -BEARING_OD/1.8, BEARING_HEIGHT-10]) {
                    rotate([0, 0, 60]) {
                            boltAndCaptiveNut();
                    }
                }
        }

        translate([0, 0, -BEARING_HEIGHT-.16]) {
            difference(){
                cylinder(r=(BEARING_OD/2)+1.2,h=2.3, center=true, $fn=_sideRes);
                translate([0, 0, -2]) {
                    cylinder(r=AXLE_RAD,h=16, center=true, $fn=_sideRes);

                }
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


module axleFlangeMount(){
     difference(){
        union(){
            translate([-2.9, 0, 0]) {
                 rotate([0, 90, 0]) {
                    difference(){
                        cylinder(r=17.5, h=3, center=true, $fn=_sideRes);
                        translate([0, 0, 1]) {
                            cylinder(r=16.2, h=BEARING_HEIGHT, center=true, $fn=_sideRes);
                        }
                    }
                }
            }
          
            translate([-6.5, 0, 0]) {
                cube([4.5,35,35], center=true);
            }
        }

         

           translate([-14, 12, 0]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(38,5,30);
               }
           }

            translate([-14, -12, 0]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(38,5,30);
               }
           }     

           
            translate([-14, 0, 12]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(38,5,30);
               }
           }    

           
            translate([-14, 0, -12]){
               rotate([0, 90, 0]) {
                     boltAndCaptiveNut(38,5,30);
               }
           }       
           

       
        rotate([0, 90, 0]) {
             cylinder(r=AXLE_RAD+.2, h=35, center=true, $fn=_sideRes);
        }
    }
}

module footExtension(){
    union(){
        foot();
        translate([0, 0, 0]){

        } 
    }
}

module foot(){
    difference(){
         translate([BASE_RAD-_footSinkDepth, -FOOT_WIDTH/2, 0]) {
             union(){
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

                //extension for modified height
                translate([0, 0, -6]) {
                    difference(){
                        cube(size=[FOOT_LENGTH, FOOT_WIDTH, 6]);
                         translate([FOOT_LENGTH-5, FOOT_WIDTH/2, -FOOT_HEIGHT+_hollowLengthOffset]) {
                            cylinder(r=FOOT_SCREWHOLE_RAD, h=FOOT_HEIGHT+_hollowLengthOffset, $fn=_sideRes);
                        }
                    }
                     
                }
               
             }
        }

        translate([0,0,-9]){
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