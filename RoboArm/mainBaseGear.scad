//import("E:/Programerinos/userSave/RoboArm/drawings/M1-T60-Internal Gear.stl"); //60 teeth, radius of 45mm



//   difference(){
        // rotate([0, 90, 0]) {
        //      import("E:/Programerinos/userSave/RoboArm/drawings/M1-T12 Gear.stl"); //12 teeth, inner bore 5mm
        // }
//         translate([0, 0, -15]) {
//             cylinder(r=2.6,h=20,$fn=100);
//         }
//     }
    difference(){
        rotate([0, 90, 0]) {
               import("E:/Programerinos/userSave/RoboArm/drawings/M1-T24 Gear.stl"); //24 teeth, inner bore 8mm
        }
        translate([0, 0, -18]) {
            cylinder(r=5.1,h=25,$fn=100);
        }
    }
        

pitch=3.14;//mm
radius = 40;
