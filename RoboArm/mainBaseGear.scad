//import("E:/Programerinos/userSave/RoboArm/drawings/M1-T60-Internal Gear.stl"); //60 teeth, radius of 45mm



//   difference(){
//         rotate([0, 90, 0]) {
//             union(){
//                  import("E:/Programerinos/userSave/RoboArm/drawings/M1-T12 Gear.stl"); //12 teeth, inner bore 5mm
//                    // //nut slot
//                     translate([7, 0, 5]) {
//                         cube([7,7,5], center=true);
//                     }
//             }
            
//         }
//         translate([0, 0, -15]) {
//             cylinder(r=2.85,h=20,$fn=100);
//         }
        
//         translate([0, 0, 7.68]) {
//             cube(size=[20, 20, 10], center=true);
//         }

//         //captive nut and bolt
//         translate([3,0,-7]){
//             rotate([0, 90, 0]) {
//                  cylinder(r=1.65, h=6, center=true, $fn=200);
//                 translate([0, 0, 4]){
//                      cylinder(r=2.5, h=2.3, center=true, $fn=200);
//                 }

//                 translate([0, 0, 2]) {
//                     cube([5.8,8.8,2.8], center=true);
//                 } 
//             }
           
//         }
//     }

    // difference(){
    //     rotate([0, 90, 0]) {
    //            import("E:/Programerinos/userSave/RoboArm/drawings/M1-T24 Gear.stl"); //24 teeth, inner bore 8mm
    //     }
    //     translate([0, 0, -18]) {
    //         cylinder(r=5.1,h=25,$fn=100);
    //     }
    // }
        

pitch=3.14;//mm
radius = 40;
