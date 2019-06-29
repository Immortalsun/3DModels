//Constants
CUBE_HEIGHT = 25;//mm
CUBE_WIDTH = 25;//mm

TUBE_DIAM = 2;//mm
SPHERE_DIAM = 2.5;//mm
LAYERS = 2; //number of cubes beyond the solid inner cube
TUBE_HEIGHT = 12;//mm

HOLLOW = true;
EXTENSION_ANGLE = 90;
_extFactor = 7.0;
INTERNAL_EXT_HEIGHT = TUBE_HEIGHT-_extFactor;


difference(){
    mainCube();
    crossSection();
}

module mainCube(){
    union(){
        
        //    scale([1.5,1.5,1.5]) //1.5X
        //             matrixCube();
        
        // translate([CUBE_WIDTH/8,CUBE_WIDTH/8,CUBE_HEIGHT/8]){
        //      matrixMain(4);
        // }

         translate([CUBE_WIDTH/4.5,CUBE_WIDTH/4.5,CUBE_HEIGHT/4.5]){
             scale([.6,.6,.6]){
                  matrixMain(5);
             }

            // difference(){
            //     cube(CUBE_HEIGHT*.3);
            //     translate([3.8,3.8,2.6]){
            //         union(){
            //             cylinder(r1=(CUBE_HEIGHT*.2)/1.4, r2=0,h=4,$fn=4);
            //             translate([0,0,3])
            //                 cylinder(r=.5, h=3, $fn=140);
            //         }
                    
            //     }
            // }
         

        }
    }
    
}

module matrixMain(extLength = 3){
    union(){
        matrixCube();

        translate([0,0,TUBE_HEIGHT]){
          matrixExtension(extLength);
        }

        translate([0,TUBE_HEIGHT,TUBE_HEIGHT]){
            rotate([0,0,-EXTENSION_ANGLE]){
                 matrixExtension(extLength);
            }
        }

        translate([TUBE_HEIGHT,0,TUBE_HEIGHT]){
            rotate([0,0,EXTENSION_ANGLE]){
                 matrixExtension(extLength);
            }
        }

         translate([TUBE_HEIGHT,TUBE_HEIGHT,TUBE_HEIGHT]){
            rotate([0,0,-(EXTENSION_ANGLE*2)]){
                 matrixExtension(extLength);
            }
        }

        mirror([0,0,1]){
            matrixExtension(INTERNAL_EXT_HEIGHT);

            translate([0,TUBE_HEIGHT,0]){
                rotate([0,0,-EXTENSION_ANGLE]){
                     matrixExtension(INTERNAL_EXT_HEIGHT);
                }
            }

            translate([TUBE_HEIGHT,0,0]){
                rotate([0,0,EXTENSION_ANGLE]){
                    matrixExtension(INTERNAL_EXT_HEIGHT);
                }
            }   

            translate([TUBE_HEIGHT,TUBE_HEIGHT,0]){
                rotate([0,0,-(EXTENSION_ANGLE*2)]){
                    matrixExtension(INTERNAL_EXT_HEIGHT);
                }
            }
        }
    }
}

module matrixExtension(height = TUBE_HEIGHT, addEndcap = false){
    rotate([35,-35,0]){
        matrixCylinder(height);
        if(addEndcap){
            translate([0,0,height-.1]){
                matrixSphere();
            }
        }
    }
}

module matrixCube(){
    union(){
         matrixSquare();
        rotate([-90,0,0]){
            matrixSquare();
        }
        rotate([0,0,90]){
            matrixSquare();
        }

        translate([0,0,TUBE_HEIGHT]){
            rotate([-90,0,0]){
                matrixSquare();
            }
        }

        translate([TUBE_HEIGHT,TUBE_HEIGHT,0]){
            rotate([0,-90,0]){
                matrixBar();
            }
            
        }
    }
}

module matrixSquare(hollow = HOLLOW){
    union(){

        matrixBar(hollow);
        rotate([0,-90,90]){
            matrixBar(hollow);
        }

        translate([0,0,TUBE_HEIGHT]){
            matrixBar(hollow);
        }

        translate([TUBE_HEIGHT,0,0]){
            rotate([0,-90,90]){
                matrixBar(hollow);
            }
        }
    }
}

module matrixBar(hollow = HOLLOW){

    rotate([0,90,0]){
         matrixCylinder(TUBE_HEIGHT, hollow);
    }
    if(hollow){
        difference(){
            matrixSphere(hollow);
             translate([-1,0,0]){
                 rotate([0,90,0])
                    cylinder(r=(TUBE_DIAM/2)-.4, h = TUBE_HEIGHT, $fn = 120);
             }
        }

        difference(){
             translate([TUBE_HEIGHT,0,0]){
                matrixSphere(hollow);
            }

            translate([1,0,0]){
                 rotate([0,90,0])
                    cylinder(r=(TUBE_DIAM/2)-.4, h = TUBE_HEIGHT, $fn = 120);
             }
        }
    }
    else{
        matrixSphere(hollow);
         translate([TUBE_HEIGHT,0,0]){
             matrixSphere(hollow);
        }
    }
    

   
}

module matrixCylinder(height = TUBE_HEIGHT, hollow = HOLLOW){
    
    if(hollow){
        difference(){
             cylinder(r=TUBE_DIAM/2, 
                h = height, $fn = 120);
            
            translate([0,0,-.25]){
                cylinder(r=(TUBE_DIAM/2)-.4, 
                h = height+.5, $fn = 120);
            }
        }
    }
    else{
        cylinder(r=TUBE_DIAM/2, 
            h = height, $fn = 120);
    }
    
}

module matrixSphere(hollow = HOLLOW){
    if(hollow){
        difference(){
            sphere(r=TUBE_DIAM/2, $fn = 120);

            sphere(r=(TUBE_DIAM/2)-.4, $fn=120);
        }
    }
    else{
        sphere(r=TUBE_DIAM/2, $fn = 120);
    }
   
}

module crossSection(){
    translate([CUBE_WIDTH/4,-2,-.2]){
         cube([21,CUBE_HEIGHT+.3,CUBE_HEIGHT+.3]);
    }
   
}