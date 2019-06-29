CAP_HEIGHT = 28;//mm
CAP_DIAM = 13;//mm

MAGNET_DIAM = 5.1;//mm

MAGNET_HEIGHT = 3.1;//mm
MAG_OD = 13;
MAG_ID = 5.9;

_cylinderRes = 140;

difference(){
    magMount();

    topCapRad = ((CAP_DIAM+2)/2)+3;
    cubeOffset = 67;

translate([0,0,0]){
    difference(){
    cylinder(r1=topCapRad, r2 = topCapRad-4, h=8, $fn=_cylinderRes);
        translate([0,0,-2]){
                cube([topCapRad+cubeOffset, topCapRad+cubeOffset, 4.5],center=true);
        }
        sphere(r=topCapRad-2.6, h=5, $fn=_cylinderRes);
    } 
}
}






module magMount(){
    difference(){
        union(){
            capTopNub();

            clipPlacement();

            rotate([0,0,90]){
                clipPlacement();
            }

            rotate([0,0,180]){
                clipPlacement();
            }

            rotate([0,0,270]){
                clipPlacement();
            }
        }
        magnet();
    }
      
   
}

module clipPlacement(){
    translate([6,-3,-9]){
        rotate([0,0,-10]){
            capClip();
        }
    }
}

module capTopNub(){
    sphereRad = ((MAG_OD+2)/2);
    cubeOffset = 8.3;
    difference(){
        sphere(r=sphereRad, $fn=_cylinderRes);
        translate([0,0,-3.9]){
                cube([sphereRad+cubeOffset, sphereRad+cubeOffset, 8],center=true);
        }
        magnet();
    }
}

module capClip(){
    difference(){
        cube([1.1,2.6,12]);
        translate([-.2,-.1,2]){
            //cube([2.1,4,2.8]);
        }
    }
}

module capBody(){
     difference(){
        cylinder(d=CAP_DIAM+2, h = CAP_HEIGHT-2, $fn=_cylinderRes);

        translate([0,0,-1]){
             cylinder(r=(CAP_DIAM/2)-.2, h = CAP_HEIGHT, $fn=_cylinderRes);
        }
    }
}

module magnet(){
    difference(){
         cylinder(r=MAG_OD/2, h = MAGNET_HEIGHT , $fn = _cylinderRes);
         translate([0,0,-1]){
             cylinder(r=MAG_ID/2, h = MAGNET_HEIGHT+3, $fn=_cylinderRes);
         }
    }
}