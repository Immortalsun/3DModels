//Constants
PANEL_WIDTH = 98;//mm
PANEL_THICKNESS = 6;//mm
PANEL_HEIGHT = 46;//mm
MAGNET_DIAM = 5.1;//mm
MAGNET_HEIGHT = 3.4;//mm
SCREW_DIAM = 4.8;//mm


_diameterTolerance = 1.5;//mm
_toggleDiam = 11.6;//mm
_pushDiam = 6.7;//mm
_potenScrew = 3.2;//mm
_cylinderRes = 140;

mainPanel();

module mainPanel(){
    difference(){
        cube([PANEL_WIDTH, PANEL_HEIGHT, PANEL_THICKNESS]);

        translate([10,8,0]){
            potentiometerPlate();
        }

        translate([80,33.5, 0]){
            controlCluster();
        }
      
        translate([38,33.5, 0]){
            controlCluster();
        }

        //y axis facing magnets
        translate([95.3,10,0]){
            magnet();
        }

        translate([95.3,35,0]){
            magnet();
        }

        translate([-.3,10,0]){
            magnet();
        }

        translate([-.3,35,0]){
            magnet();
        }

        //x axis facing magnets
        translate([78,42.9,0]){
            rotate([0,0,90]){
                magnet();
            }
        }

        translate([18,42.9,0]){
            rotate([0,0,90]){
                magnet();
            }
        }

         translate([78,-.4,0]){
            rotate([0,0,90]){
                magnet();
            }
        }

        translate([18,-.4,0]){
            rotate([0,0,90]){
                magnet();
            }
        }
    }
}

module controlRoundHole(diam){
    translate([0,0,-1]){
        cylinder(r=(diam/2), h= PANEL_THICKNESS+2, 
            $fn = _cylinderRes);
    }
}

module controlBlockHole(length, width){
    translate([0,0,-1]){
        cube([length,width, PANEL_THICKNESS+2]);
    }
}

module controlCluster(){
    controlRoundHole(_toggleDiam+_diameterTolerance);

    translate([-20,0,0]){
         controlRoundHole(_pushDiam+ _diameterTolerance);
         translate([0,0,-4]){
             controlRoundHole(_pushDiam+_diameterTolerance+2);
         }
         
    }
}

module potentiometerPlate(){
    controlBlockHole(76.2,10);
    
     translate([-2.5,1,0]){
        controlRoundHole(_potenScrew);
    }

     translate([-2.5,16,0]){
        controlRoundHole(_potenScrew);
    }

    translate([79.5,0,0]){
        mirror([1,0,0]){
            translate([-2.5,1,0]){
                controlRoundHole(_potenScrew);
            }

            translate([-2.5,16,0]){
                controlRoundHole(_potenScrew);
            }
        }
    }
}

module magnet(){
    translate([0,0,(MAGNET_DIAM/2)+.5]){
        rotate([0,90,0]){
            cylinder(r=MAGNET_DIAM/2, h = MAGNET_HEIGHT, $fn=_cylinderRes);
        }
    }
}

