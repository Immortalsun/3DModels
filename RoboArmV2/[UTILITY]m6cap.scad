capX = 10;
capY = 10;
capZ = 10;
scaleFactor = .08;


capMain(); 
//cube([1, 5.35,1],center=true);

module capMain(){
    union(){
        difference(){
            translate([0, 0, capZ/2]) {
                cylinder(r=capX/2, h=capZ, center=true, $fn=6);
            }
            importM6Screw();
        }       
    }
}

module importM6Screw(){
     scale([1+scaleFactor, 1+scaleFactor, 1+scaleFactor]){
        import("E:/Programerinos/userSave/[UTILITY]M6-1,0Screw.stl");
     }
}