PROJECTOR_RADIUS = 34.25;//mm
PROJECTOR_HEIGHT = 121;//mm

OUTPUT_RADIUS = 30/2;//mm

FOCUS_WIDTH = 21;//mm

PORT_WIDTH = 42;//mm
PORT_HEIGHT = 12;//mm

RING_MAGNET_HEIGHT = 3.1;//mm

MAG_OD = 13;
MAG_ID = 5.9;

PEG_MAGNET_DIAM = 5.1;//mm
PEG_MAGNET_HEIGHT = 6.9;//mm
HOOK_OD = 40;//mm
HOOK_ID = 24;//mm


BACK_HOOK_OD = 20;//mm
BACK_HOOK_ID = 12;//mm

SENSOR_RADIUS = 6;//mm
PI = 3.1415926;

_bisectorDirection = 40;
_capHeightOffest = 8.4;
_addProjectorTestPiece = false;
_case_thickness = 7.9;//mm ACTUALLY 6.9 BUT OFFSET LeL XD NhHHnHHgH
_outputWindowXShift = 20;
_ouputWindowZShift = 91.5; 
_cylinderRes = 140;

union(){
    translate([0,0,-PROJECTOR_HEIGHT+10])
        magnetizedRing();
    backHook();
}




module magnetizedRing(){
    difference(){
        translate([0,0,PROJECTOR_HEIGHT-10])
            mainBody();

            ringMagnet();

            mirror([0,1,0])
                ringMagnet();

            
            rotate([0,0,90])
                ringMagnet();
    }
}
 

//import("G:/Programerinos/userSave/[projectorCase]sleeve1.1.stl");

module mainBody(){
    difference(){
        cylinder(r=PROJECTOR_RADIUS+_case_thickness*2, h=15, $fn = _cylinderRes);
        translate([0, 0, -.1]) {
            cylinder(r=PROJECTOR_RADIUS+_case_thickness+.5, h=PROJECTOR_HEIGHT+_case_thickness*2, $fn = _cylinderRes);
        }
    }

     scale([1, 1, .2]) {
        hook();
    }

    mirror([0,1,0]){
        scale([1, 1, .2]) {
            hook();
        }
    }

}


module ringMagnet(){
    translate([0,45.4,_ouputWindowZShift+26.5]){
        rotate([90,0,0])
            difference(){
                cylinder(r=MAG_OD/2, h = RING_MAGNET_HEIGHT+.2 , $fn = _cylinderRes);
                translate([0,0,-1]){
                    cylinder(r=MAG_ID/2, h = RING_MAGNET_HEIGHT+2, $fn=_cylinderRes);
                }
        }
    }
}

module hook(){
    translate([0,48.5,88])
        rotate([90,0,0])
            difference(){
                    cylinder(r=HOOK_OD/2, h=6, $fn=_cylinderRes);
                        translate([0,0,-.5])
                            cylinder(r=HOOK_ID/2, h=9, $fn=_cylinderRes);
                }
      
}

module backHook(){
    translate([55,0,0])
     difference(){
        cylinder(r=BACK_HOOK_OD/2, h=7, $fn=_cylinderRes);
            translate([0,0,-.5])
                cylinder(r=BACK_HOOK_ID/2, h=12, $fn=_cylinderRes);
    }
}

