//import("E:/Programerinos/userSave/RoboArm/drawings/M1-T60-Internal Gear.stl"); //60 teeth, radius of 45mm



//   difference(){
//         rotate([0, 90, 0]) {
//             union(){
//                  import("E:/Programerinos/userSave/RoboArm/drawings/M1-T12 Gear.stl"); //12 teeth, inner bore 5mm
//                    // //nut slot
//                     translate([7, 0, 5]) {
//                         cube([7,7,5], center=true);
//                     }
//                 translate([-5, 0, 0]) {
//                      import("E:/Programerinos/userSave/RoboArm/drawings/M1-T12 Gear.stl");
//                 }
//             }
            
//         }
//         translate([0, 0, -15]) {
//             cylinder(r=2.85,h=25,$fn=100);
//         }
        
//         translate([0, 0, 12.68]) {
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


difference(){
    union(){
         import("E:/Programerinos/userSave/RoboArm/drawings/GT2_3mm-24T-Gear.stl");

        translate([0,0,1.75]){
            cylinder(r=12.6, h=3.5, center=true ,$fn=200);
        }
        
            
    }
        

      translate([5,0,2.6]){
        rotate([0, 90, 0]) {
        
            translate([0, 0, 4]){
                  cylinder(r=1.65, h=10, center=true, $fn=200);
            }

            translate([-.25, 0, 2.5]) {
                cube([40,5.9,2.8], center=true);
            } 
        }
    }

     cylinder(r=5.65, h=45, center=true ,$fn=200);
}

    // difference(){
    //     union(){
    //          import("E:/Programerinos/userSave/RoboArm/drawings/GT2_3mm-12T-Gear.stl");
    //          translate([6,0,2.25]){
    //              cube([7,7,4.5], center=true);
    //          }
    //     }
         

    //       translate([1.5,0,2.6]){
    //         rotate([0, 90, 0]) {
            
    //             translate([.5, 0, 4]){
    //                   cylinder(r=1.65, h=10, center=true, $fn=200);
    //             }

    //             translate([1.1, 0, 5.5]) {
    //                 cube([8.8,5.8,2.8], center=true);
    //             } 
    //         }
    //     }

    //     cylinder(r=2.7, h=45, center=true ,$fn=200);
    // }
  


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
