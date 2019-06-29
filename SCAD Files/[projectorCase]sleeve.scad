PROJECTOR_RADIUS = 34.25;//mm
PROJECTOR_HEIGHT = 121;//mm

OUTPUT_RADIUS = 14.5;//mm

FOCUS_WIDTH = 21;//mm

PORT_WIDTH = 42;//mm
PORT_HEIGHT = 12;//mm

RING_MAGNET_HEIGHT = 4;//mm

MAG_OD = 13;
MAG_ID = 5.9;

PEG_MAGNET_DIAM = 5.1;//mm
PEG_MAGNET_HEIGHT = 6.9;//mm


SENSOR_RADIUS = 6;//mm
PI = 3.1415926;

_bisectorDirection = 40;
_capHeightOffest = 8.4;
_addProjectorTestPiece = false;
_case_thickness = 7.9;//mm ACTUALLY 6.9 BUT OFFSET LeL XD NhHHnHHgH
_outputWindowXShift = 20;
_ouputWindowZShift = 91.5; 
_cylinderRes = 240;


difference(){
        cappedCase();
        ringMagnet();

        mirror([0,1,0])
            ringMagnet();

        
        rotate([0,0,-90])
            ringMagnet();

        translate([_bisectorDirection,0,0])
            rotate([0,0,420])
                cube([PROJECTOR_RADIUS*4, 69, PROJECTOR_HEIGHT*4], center=true);

        pegMagnetBottomLeft();

        pegMagnetTopLeft();

        pegMagnetBottomRight();

        pegMagnetTopRight();
    }
  
//   translate([0,0,112.5])
//     import("G:/Programerinos/userSave/[projectorCase]hookRingv1.1.stl");
       



module cappedCase(){
    union(){
        mainCase();
        endCap();
    }
}

module mainCase(){
    difference(){
        mainBody();
        translate([0,0,_capHeightOffest]){
            outputWindow();
            scale([1.6,1,1])
                focusWindow();
            iRSensorWindow();
            portHoleWindow();
             vent();
        }
    }
}

module mainBody(){
    difference(){
        cylinder(r=PROJECTOR_RADIUS+_case_thickness, h=PROJECTOR_HEIGHT+_capHeightOffest, $fn = _cylinderRes);
        translate([0, 0, -.1]) {
            cylinder(r=PROJECTOR_RADIUS+1, h=PROJECTOR_HEIGHT+_case_thickness*2, $fn = _cylinderRes);
        }
    }
    if(_addProjectorTestPiece){
        translate([0,0,_capHeightOffest/2])
         cylinder(r=PROJECTOR_RADIUS, h=PROJECTOR_HEIGHT, $fn = _cylinderRes);
    }
}

module outputWindow(){
    translate([_outputWindowXShift,10,_ouputWindowZShift])
        rotate([0,90,0])
            cylinder(r=OUTPUT_RADIUS, h=_case_thickness+19);
}

module focusWindow(){
    translate([0,30,80])
        rotate([0,90,90]){
           // cube([FOCUS_WIDTH,FOCUS_WIDTH, FOCUS_WIDTH*.65], center = true);
            cylinder(r=FOCUS_WIDTH/2, h=FOCUS_WIDTH, $fn=_cylinderRes);
        }
            
}

module iRSensorWindow(){
    translate([-60,0,80])
        rotate([0,90,0])
            cylinder(r=SENSOR_RADIUS, h = _case_thickness+24, $f= _cylinderRes);
}

module portHoleWindow(){
    translate([-24,0,9.2])
        rotate([0,0,0])
            cube([PORT_WIDTH,PORT_WIDTH,PORT_HEIGHT], center = true);
}

module endCap(addHooks = false){
    cylinder(r=PROJECTOR_RADIUS+_case_thickness, h=4.2, $f= _cylinderRes);
}

function zAngleRotation(arcLength)  = (180 * arcLength)/((PROJECTOR_RADIUS+_case_thickness) * PI);


module ringMagnet(){
    translate([0,42.420,_ouputWindowZShift+28]){
        rotate([90,0,0])
            difference(){
                cylinder(r=MAG_OD/2, h = RING_MAGNET_HEIGHT , $fn = _cylinderRes);
                translate([0,0,-1]){
                    cylinder(r=MAG_ID/2, h = RING_MAGNET_HEIGHT+2, $fn=_cylinderRes);
                }
        }
    }
}

module vent(){
    translate([-42, 0, 104]) {
        cube([40,52,12], center=true);
    }
}

module pegMagnetBottomLeft(){
      translate([20,33,12])
        rotate([90,0,420])
            pegMagnet();
}

module pegMagnetTopLeft(){
    translate([20,33,112])
        rotate([90,0,420])
            pegMagnet();
}

module pegMagnetBottomRight(){
     translate([-19,-34,12])
        rotate([90,0,420])
            pegMagnet();
}

module pegMagnetTopRight(){
   translate([-19,-34,112])
        rotate([90,0,420])
            pegMagnet();
}

module pegMagnet(){
    cylinder(r=PEG_MAGNET_DIAM/2, h = PEG_MAGNET_HEIGHT , $fn = _cylinderRes, center = true);
}

