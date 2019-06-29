
//import gear model
import("E:/Programerinos/userSave/[lightRing]BaseDriveGear.stl");

//test arm base positioning
// translate([0,0,-10]){
//     translate([-8,-85,20]){
//         import("E:/Programerinos/userSave/[lightRing]Basev1.1.stl");
//     }

//     rotate([0,0,180])
//     translate([-8.5,-85,20]){
//         import("E:/Programerinos/userSave/[lightRing]Basev1.1.stl");
//     }
// }


//Constants
SCREW_DIAMETER = 2.3;//mm
SCREW_DEPTH = 10.0;//mm
CONNECTOR_HEIGHT = 2;//mm

screwConnector();

module screwConnector(){

    //cylinder(r=SCREW_DIAMETER/2, h = SCREW_DEPTH, $fn = 40);

    translate([0,0,9]){
        // difference(){
        //     cylinder(r=16.8, h = CONNECTOR_HEIGHT, $fn=160);
        //     translate([0,0,-1.5]){
        //         cylinder(r=12, h = 10, $fn=160);

        //         translate([14,0,0]){
        //             cylinder(r=SCREW_DIAMETER/2, h = SCREW_DEPTH, $fn=160);
        //         }

        //         rotate([0,0,90]){
        //             translate([14,0,0]){
        //             cylinder(r=SCREW_DIAMETER/2, h = SCREW_DEPTH, $fn=160);
        //             }
        //         }

        //         rotate([0,0,180]){
        //             translate([14,0,0]){
        //             cylinder(r=SCREW_DIAMETER/2, h = SCREW_DEPTH, $fn=160);
        //             }
        //         }

        //         rotate([0,0,270]){
        //             translate([14,0,0]){
        //             cylinder(r=SCREW_DIAMETER/2, h = SCREW_DEPTH, $fn=160);
        //             }
        //         }
        //     }
        // }
           translate([0,0,-11]){
                difference(){
                    cylinder(r=16.8, h = CONNECTOR_HEIGHT, $fn=160);
                    translate([0,0,-1]){
                        cylinder(r=12, h = 8, $fn=160);
                    }
                }
            } 
    }
}