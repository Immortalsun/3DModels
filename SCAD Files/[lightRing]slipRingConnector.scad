//Constants
SLIPRNG_DIAM = 13.8;//mm
SLIPRNG_HEIGHT = 13.5;//mm
MAGNET_DIAM = 5.1;//mm
MAGNET_HEIGHT = 3.1;//mm

MAG_OD = 13;
MAG_ID = 5.9;
//enbable/diable cross section
CROSS_SECTION = false;

BEARING_OPENING_DIAM = 10;//mm
MOUNT_DIAM = 17.8;//mm
SCREW_DIAM = 4.8;//mm
//variables
_mountHeightOffset = 39;//mm
_slipRngHeightOffset = 10;//mm
_magnetSinkOffset = .5;//mm
_cylinderRes = 140;

//run main module
difference(){
    union(){
        mountMain();
        mountBase();
    }

   crossSection();
}



module mountMain(){
    difference(){
        //main mount shape
        cylinder(r=MOUNT_DIAM/2, h = SLIPRNG_HEIGHT
        + MAGNET_HEIGHT + _mountHeightOffset, $fn=_cylinderRes);
        //center hole for slipring
        translate([0,0,SLIPRNG_HEIGHT-18]){
            cylinder(r=SLIPRNG_DIAM/2, h = SLIPRNG_HEIGHT+32
                + _slipRngHeightOffset, $fn = _cylinderRes);
        }

        translate([0,0,SLIPRNG_HEIGHT+_slipRngHeightOffset+26]){
                 cylinder(r=3,h=7,$fn=_cylinderRes);
        } 

        translate([0,0,SLIPRNG_HEIGHT+_mountHeightOffset+.1]){
            magnet();
        }
        
        translate([-12,0,10]){
            rotate([0,90,0]){
                cylinder(r=2, h=25, $fn=140);
            }
        }
        translate([0,12,10]){
             rotate([90,0,0]){
                cylinder(r=2, h=25, $fn=140);
            }
        }
            
    }
}

module mountBase(){
    difference(){
        union(){
            translate([-20,(-(MOUNT_DIAM+3.5)/2),0]){
                cube([40,MOUNT_DIAM+3.5,3]);
            }


            translate([-10,(-(MOUNT_DIAM+2)),0]){
                cube([MOUNT_DIAM+3.5,40,3]);
            }
        }
            

            //main Shaft
            translate([0,0,-1]){
                 cylinder(r=SLIPRNG_DIAM/2, h = SLIPRNG_HEIGHT 
                + _slipRngHeightOffset, $fn = _cylinderRes);
            }
           
            
            //screw holes
            translate([16.5,0,-1]){
                cylinder(r=SCREW_DIAM/2, h = 10, $fn=_cylinderRes);
            }

            translate([-16.5,0,-1]){
                cylinder(r=SCREW_DIAM/2, h = 10, $fn=_cylinderRes);
            }

              translate([0,16.5,-1]){
                cylinder(r=SCREW_DIAM/2, h = 10, $fn=_cylinderRes);
                }

            translate([0,-16.5,-1]){
                cylinder(r=SCREW_DIAM/2, h = 10, $fn=_cylinderRes);
            }

            bevelRadius = 18;
            // bevelAngle = -55;
            // bevelDepth = -14.1;
            // //bevels
            // translate([20,bevelDepth,-1]){
            //         rotate([0,0,bevelAngle]){
            //             cylinder(r=bevelRadius, h = 10, $fn = 3);
            //     }
            // }

            // mirror([1,0,0]){
            //         translate([20,bevelDepth,-1]){
            //             rotate([0,0,bevelAngle]){
            //             cylinder(r=bevelRadius, h = 10, $fn = 3);
            //         }
            //     }
            // }

            //  mirror([0,1,0]){
            //         translate([20,bevelDepth,-1]){
            //             rotate([0,0,bevelAngle]){
            //             cylinder(r=bevelRadius, h = 10, $fn = 3);
            //         }
            //     }
            // }

            // mirror([1,0,0]){
            //     mirror([0,1,0]){
            //         translate([20,bevelDepth,-1]){
            //                 rotate([0,0,bevelAngle]){
            //                 cylinder(r=bevelRadius, h = 10, $fn = 3);
            //             }
            //         }
            //     }
            // }
            
    }
}

module magnet(){
    difference(){
         cylinder(r=MAG_OD/2, h = MAGNET_HEIGHT , $fn = _cylinderRes);
         translate([0,0,-1]){
             cylinder(r=MAG_ID/2, h = MAGNET_HEIGHT+2, $fn=_cylinderRes);
         }
    }
}

module crossSection(){
    if(CROSS_SECTION){
         translate([0, -(MOUNT_DIAM/2)-5 ,-1]){
        cube([22,32,59]);
        }
    }
    
}

