//part constants
//import lid platform to build off of
//main base dimensions
BASE_RAD = 69;//mm
BASE_HEIGHT = 75;//mm
BASE_THICKNESS = 5;//mm

//LID PARAMS
//Lid Dimensions
LID_RAD = 69;
LID_HEIGHT= 4;

//shoulder mount flange dimensions
FLANGE_HEIGHT = 30;//mm
FLANGE_WIDTH = LID_RAD*1.5;
FLANGE_LENGTH = 10;//mm

//Motor Dimensions
MOTOR_WIDTH = 42.3;//mm
MOTOR_HEIGHT = 34;//mm //smaller NEMA motor, other height is 38.5
MOTOR_SHAFT_THRU_RADIUS = 11;//mm
MOTOR_SHAFT_RADIUS = 2.5;//mm

//motor screwhole dimensions
MTR_SCREW_RAD = 1.55;//mm
MTR_SCREW_HEIGHT = 5.3;//mm
MTR_SCREW_COUNTERSINK_HEIGHT = 2;//mm
MTR_SCREW_COUNTERSINK_RAD = 2.7;//mm

//bearing dimensions
BEARING_ID = 10.2;//mm
BEARING_OD = 30.2;//mm
BEARING_HEIGHT = 9.2;//mm

//SHOULDER MOUNT PARAMS
MOUNT_OUTER_WIDTH = 90;//mm
MOUNT_OUTER_LENGTH = 100;//mm
MOUNT_OUTER_HEIGHT = MOTOR_WIDTH + 15;
MOUNT_WALL_THICKNESS = 8;

//Lower Arm
LOWER_ARM_OUTER_LENGTH = 75;//mm
LOWER_ARM_BRACE_WIDTH = 8;//mm
LOWER_ARM_BRACE_THIC = 23;//mm
LOWER_ARM_BRACE_HT = 20;//mm
LOWER_ARM_BRACE_WALL = 6;

LOWER_ARM_BRIDGE_LENGTH = 8;
LOWER_ARM_BRIDGE_WIDTH = (((LID_RAD/2)-3)*2)-LOWER_ARM_BRACE_WIDTH;
LOWER_ARM_BRIDGE_HEIGHT = LOWER_ARM_BRACE_THIC;

//elbow servo mount
ELBOW_ARM_OUTER_LENGTH = 85;//mm
ELBOW_ARM_BRACE_WIDTH = 8;//mm
ELBOW_ARM_BRACE_THIC = 23;//mm
ELBOW_ARM_BRACE_HT = 20;//mm
ELBOW_ARM_BRACE_WALL = 6;

ELBOW_ARM_BRIDGE_LENGTH = 8;
ELBOW_ARM_BRIDGE_WIDTH = (((LID_RAD/2)-3)*2)-LOWER_ARM_BRACE_WIDTH+(ELBOW_ARM_BRACE_WIDTH*2);
ELBOW_ARM_BRIDGE_HEIGHT = LOWER_ARM_BRACE_THIC;
//elbow bracket constants
mountBracketLength = LOWER_ARM_OUTER_LENGTH/3;
mountBracketWidth = 5;
mountBracketHeight = LOWER_ARM_BRACE_HT + 10;
bracketFlangeWidth = 20;//mm 
bracketFlangeHeight = 3;//mm
//translation constants
_yOffset = .6;
main();

module main(){
    union(){
        importLowerArm();
        supportRailMain();
    }
}

module importLowerArm(){
    import("E:/Programerinos/userSave/RoboArm/drawings/rb_elbow_Mountv9.stl");
}

module supportRailMain(){
    union(){
        translate([LOWER_ARM_OUTER_LENGTH/2.2,((ELBOW_ARM_BRIDGE_WIDTH/2)+mountBracketWidth*2)+_yOffset, 0]) {
            supportRailMountBracket();
        }
    }
}

module supportRailMountBracket(){
    
    union(){
        //main bracket
        cube([mountBracketLength, mountBracketWidth, mountBracketHeight], center=true);
        //top flange
        translate([0, -bracketFlangeWidth/2, (mountBracketHeight/2)-(bracketFlangeHeight/2)]){
             supportBracketFlange();
        }
        //bottom flange
        translate([0, -bracketFlangeWidth/2, -(mountBracketHeight/2)+(bracketFlangeHeight/2)]){
            supportBracketFlange();
        }

    }
}

module supportBracketFlange(){
    union(){
        cube([mountBracketLength, bracketFlangeWidth, bracketFlangeHeight],center=true);
        translate([0, -bracketFlangeWidth+2.8, 0]){
            rotate([0, 0, 30]){
                cylinder(r=(mountBracketLength/2)+1.95, h=bracketFlangeHeight, center=true, $fn=3);
            } 
        } 
    }
}
