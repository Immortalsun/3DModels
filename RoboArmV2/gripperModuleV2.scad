//part constants
KEY_HEIGHT = 3;//mm
KEY_RAD = 26;//mm
KEY_EXTENSION_X = 68;//mm
KEY_EXTENSION_Y = 9.8;//mm

GRPR_BASE_HEIGHT = 5;//mm
GRPR_BASE_RAD = 23.5;//mm

//servo dimensions
SERVO_LENGTH = 40.2;//mm
SERVO_WIDTH = 20.25;//mm
SERVO_HEIGHT = 40.75;//mm
SERVO_FLANGE_DIST = 25;//mm
SERVO_FLANGE_HEIGHT = 5;//mm
SERVO_FLANGE_LENGTH = 54.75;//mm
SERVO_FLANGE_SCREWHOLE_DIST = 9.25;//mm
SERVO_HORN_RAD = 3;
FLANGE_HEIGHT = 30;//mm
//servo horn params
servoHornLength = 35;//mm
servoHornHeight = 6.6;//mm
servoHornWidth = 6;//mm
servoHornBaseRadius = 7.4;//mm
servoHornZTransBuffer = .5;//mm
servoHornXTransBuffer = .5;//mm

//part translations
gripperXTrans = 0;
gripperYTrans = 0;
gripperZTrans = KEY_HEIGHT/2;

//global constants
_sideRes = 300;

main();

module main(){
    //wrist key for attachment to arm
    wristKey();

    //begin gripper structure
    translate([gripperXTrans,gripperYTrans,gripperZTrans]){
        gripperMain();
    }
}

module gripperMain(){
    union(){
        gripperBase();
        gripperServoMount();
        gripperFinger();
    }
}

//mounts to wrist key
module gripperBase(){
    translate([0,0,(GRPR_BASE_HEIGHT/2)]){
        union(){
            difference(){
                cylinder(r=GRPR_BASE_RAD, h=GRPR_BASE_HEIGHT, center=true, $fn=_sideRes);
                keyInteriorScrewMounts();
                //nut channels
                cube([5.8,GRPR_BASE_RAD*2.5,2.8], center=true);
                cube([GRPR_BASE_RAD*2.5,5.8,2.8], center=true);
            }
        }
    }
}

//mounts to base
module gripperServoMount(){
    translate([0,0,0]){
        union(){
            
            translate([0,0,SERVO_WIDTH+GRPR_BASE_HEIGHT+(SERVO_FLANGE_LENGTH-SERVO_LENGTH)/2]){
                rotate([0,-90,0]){
                    servoStandIn();
                }
            }
        }
    }
}

module gripperFinger(){

}




module wristKey(){
    difference(){

        union(){
            cylinder(r=KEY_RAD, h = KEY_HEIGHT, center=true, $fn=_sideRes);
            translate([0, 0, 0]) {
                cube(size=[KEY_EXTENSION_X, KEY_EXTENSION_Y, KEY_HEIGHT], center=true);
                cube(size=[KEY_EXTENSION_Y, KEY_EXTENSION_X, KEY_HEIGHT], center=true);
            }
        }

        //key rounding
        translate([0, 0, 1]) {
             difference(){
                cylinder(r=35, h=8, center=true, $fn=_sideRes);
                translate([0, 0, -4]) {
                    cylinder(r=33.2, h=12, center=true, $fn=_sideRes);
                }
            }
        }
       
        keyInteriorScrewMounts();
        keyExteriorScrewMounts();
    }
}

module keyInteriorScrewMounts(){
     translate([15, 0, 0]){
        cylinder(r=2, h=20, center=true, $fn=_sideRes);
    } 

    rotate([0, 0, 90]){
        translate([15, 0, 0]){
            cylinder(r=2, h=20, center=true, $fn=_sideRes);
        } 
    }  

    rotate([0, 0, 180]){
        translate([15, 0, 0]){
            cylinder(r=2, h=20, center=true, $fn=_sideRes);
        } 
    }  
    
    rotate([0, 0, 270]){
        translate([15, 0, 0]){
            cylinder(r=2, h=20, center=true, $fn=_sideRes);
        } 
    }
}

module keyExteriorScrewMounts(){
    
       translate([30, 0, 0]){
            cylinder(r=2, h=20, center=true, $fn=_sideRes);
        } 

        rotate([0, 0, 90]){
            translate([30, 0, 0]){
                cylinder(r=2, h=20, center=true, $fn=_sideRes);
            } 
        }  

        rotate([0, 0, 180]){
            translate([30, 0, 0]){
                cylinder(r=2, h=20, center=true, $fn=_sideRes);
            } 
        }  
        
        rotate([0, 0, 270]){
            translate([30, 0, 0]){
                cylinder(r=2, h=20, center=true, $fn=_sideRes);
            } 
        }
}

module servoStandIn(){
    union(){
        //main servo structure
        cube([SERVO_LENGTH,SERVO_WIDTH,SERVO_HEIGHT], center=true);
        //servo flange
        translate([0,0,(SERVO_HEIGHT/2)-10]){
            cube([SERVO_FLANGE_LENGTH, SERVO_WIDTH, SERVO_FLANGE_HEIGHT],center=true);
        }

        //servo horn
        translate([(-SERVO_LENGTH/2)+30,0,(SERVO_HEIGHT/2)+2.1]){
            cylinder(r=SERVO_HORN_RAD, h=4.6, $fn=_sideRes, center=true);
        }

        //servo screw mounts
        translate([(SERVO_LENGTH/2)+4,SERVO_FLANGE_SCREWHOLE_DIST/2,-8]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([(SERVO_LENGTH/2)+4,-SERVO_FLANGE_SCREWHOLE_DIST/2,-8]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([-(SERVO_LENGTH/2)-4,SERVO_FLANGE_SCREWHOLE_DIST/2,-8]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([-(SERVO_LENGTH/2)-4,-SERVO_FLANGE_SCREWHOLE_DIST/2,-8]){
            cylinder(r=2.25, h=FLANGE_HEIGHT*2, $fn=_sideRes, center=true);
        }

        translate([servoHornBaseRadius+SERVO_HORN_RAD,0,(SERVO_HEIGHT/2)+(servoHornHeight/2)+servoHornZTransBuffer]){
            //servoHorn();
        }

    }
}

module servoHorn(){
    union(){
        //servoHorn base, attaches to servo gear
        cylinder(r=servoHornBaseRadius+_holeRadiusOffset, h=servoHornHeight, $fn=_sideRes, center=true);
        //servoHorn base screw mount
        union(){
             cylinder(r=MTR_SCREW_RAD+_holeRadiusOffset, h=servoHornHeight+15, $fn=_sideRes, center=true);
             translate([0, 0, 8]) {
                 cylinder(r=MTR_SCREW_COUNTERSINK_RAD, h=5, $fn=_sideRes, center=true);
             }
        }
       
        //servo horn gradient spacers (triangles)
        union(){
            translate([5,2,-servoHornHeight/2]){
                rotate([0, 0, 8]) {
                    triangle((servoHornBaseRadius/2),(servoHornBaseRadius/2)+3,(servoHornHeight));
                }
            }

            mirror([0,1,0]){
                  translate([5,2,-servoHornHeight/2]){
                     rotate([0, 0, 8]) {
                        triangle((servoHornBaseRadius/2),(servoHornBaseRadius/2)+3,(servoHornHeight));
                    }
                }
            }
            
        }
        //servo horn body, attaches to load
        union(){
            translate([servoHornBaseRadius*1.5,0,.3]){
                difference(){
                    cube([servoHornLength, servoHornHeight, servoHornWidth], center=true);
                    //cut out for screw heads
                    translate([(-servoHornBaseRadius/2)+servoHornZTransBuffer,0,-2]){
                            cube([15.3,servoHornHeight+.2,2.12],center=true);
                    }
                }
            }

            //servo horn screw mounts
            translate([(servoHornLength-servoHornBaseRadius-MTR_SCREW_RAD),0,0]){
                union(){
                    cylinder(r=MTR_SCREW_RAD+.2, h=servoHornWidth+22, $fn=_sideRes, center=true);
                    translate([-MTR_SCREW_RAD*2-1.45, 0, 0]) {
                        cylinder(r=MTR_SCREW_RAD+.2, h=servoHornWidth+22, $fn=_sideRes, center=true);
                    }
                    translate([-MTR_SCREW_RAD,0,3]){
                         cube([(MTR_SCREW_RAD)*2,(MTR_SCREW_RAD+.2)*2,MTR_SCREW_RAD*12], center=true);
                    }
                    translate([-MTR_SCREW_RAD*2,0,3]){
                         cube([(MTR_SCREW_RAD)*2,(MTR_SCREW_RAD+.2)*2,MTR_SCREW_RAD*12], center=true);
                    }
                   
                }
            }
        }
    }
}