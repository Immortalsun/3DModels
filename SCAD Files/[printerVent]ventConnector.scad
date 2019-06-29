PANEL_X = 55.5;//mm
PANEL_Y = 55.5;//mm
PANEL_Z = 4;
MAG_OD = 13;
MAG_ID = 5.9;

HOSE_ID = 44.5;//mm

SCREW_HEAD = 5.5;//mm

MAGNET_DIAM = 5.1;//mm
MAGNET_HEIGHT = 3.4;//mm
_rectangleHoleDividend = 1;
_magnetInset = 2;
_screwHole_padding = 10;
_cylinderRes = 140;
_hoseAttachmentHeight = 6;


union(){
    translate([0,0,PANEL_Z+_hoseAttachmentHeight/4])
        mainVent();
    // translate([(PANEL_X/2),(PANEL_Y/2)+3,-_hoseAttachmentHeight+14])
    //         cube([PANEL_X/_rectangleHoleDividend+2, (PANEL_Y/_rectangleHoleDividend)+10, PANEL_Z+16], center = true);
    

    //  translate([(PANEL_X/2),(PANEL_Y/2)+3,-_hoseAttachmentHeight+4]) {
    //     scale([1,1.59,1]){
    //         rotate([0,180,45]){
    //             difference(){
                    
    //                 translate([0,0,-.1])
    //                     cylinder(r1=(PANEL_X/2)-.5, r2=1, h = 15, $fn=4);
    //             }
    //         }    
    //     }
    // }
    // translate([-.1,-.1,-45])
    //     cube([PANEL_X, PANEL_Y/2, 90]);
}


  

module mainVent(){
    union(){
        centerPanelX =(PANEL_X/2)+3+_screwHole_padding/2;
        centerPanelY = (PANEL_Y/2)+3+_screwHole_padding/2;
        difference(){
            magnetizedPanel();
            translate([centerPanelX,centerPanelY,-_hoseAttachmentHeight/4])
                cube([(PANEL_X/_rectangleHoleDividend), PANEL_Y/_rectangleHoleDividend, PANEL_Z+10+2], center = true);
        }

         translate([centerPanelX,centerPanelY,-_hoseAttachmentHeight+5.5])
            rectangularExtension();

        translate([centerPanelX,centerPanelY,-_hoseAttachmentHeight+2.4])
                difference(){
                     ringConnector();
                      translate([0,(HOSE_ID/2)+3,.5])
                            cube([HOSE_ID*.9,HOSE_ID,3.8],center = true);
                }
               

       translate([centerPanelX,centerPanelY,-_hoseAttachmentHeight+2.45])
            ventConduit();

     }

}

module ringConnector(){
    translate([0,0,PANEL_Z-_hoseAttachmentHeight+.05]){
         difference(){
              cylinder(r=(HOSE_ID/2)+2.3, h=_hoseAttachmentHeight, $fn=_cylinderRes);
              translate([0, 0, .5]) {
                  cylinder(r=(HOSE_ID/2), h=_hoseAttachmentHeight+3, $fn=_cylinderRes);
              }
         }
    }
}

module ventConduit(){

    union(){
        capModifier = 3.3;
        conduitLengthModifier = 60;
         translate([0,0,PANEL_Z-_hoseAttachmentHeight]){
             union(){
                    difference(){
                         translate([-HOSE_ID/2,0,0]){
                            cube([HOSE_ID,HOSE_ID+conduitLengthModifier,_hoseAttachmentHeight-1]);
                        }
                        
                        translate([0,(HOSE_ID/2)+3,2.5])
                            cube([HOSE_ID*.9,HOSE_ID+conduitLengthModifier*2,_hoseAttachmentHeight-2.8],center = true);
                        translate([0,0,.4])
                            cylinder(r=(HOSE_ID/2), h=_hoseAttachmentHeight, $fn=_cylinderRes);
                    }
                    
             }
            
         }
             

    }
     
}

module rectangularExtension(){
    zAddition = 10;
    difference(){
         cube([PANEL_X/_rectangleHoleDividend+2, PANEL_Y/_rectangleHoleDividend+2, PANEL_Z-2], center = true);
         translate([0,0,-_hoseAttachmentHeight-3])
              cylinder(r=(HOSE_ID/2), h=_hoseAttachmentHeight+12, $fn=_cylinderRes);
    }
}



module magnetizedPanel(){
    difference(){
        panelBase();
        magnetMount();

        translate([PANEL_X+MAGNET_DIAM+_magnetInset,0,0])
            magnetMount();

        translate([0,PANEL_Y+MAGNET_DIAM+_magnetInset,0])
            magnetMount();

        translate([PANEL_X+MAGNET_DIAM+(_magnetInset),PANEL_Y+MAGNET_DIAM+_magnetInset,0])
            magnetMount();
    }
}

module magnetMount(){
    translate([_magnetInset+MAGNET_DIAM/2,MAGNET_DIAM,2.5]){
        magnet();
    }
}


module panelBase(){
    cube([PANEL_X+(MAG_OD/2)+_screwHole_padding,PANEL_Y+(MAG_OD/2)+_screwHole_padding,,PANEL_Z]);

    // translate([4,4,10]){
    //     cylinder(r=SCREW_HEAD/2,h=MAGNET_HEIGHT,$fn=_cylinderRes);
    // }
}

module magnet(){
    cylinder(r=MAGNET_DIAM/2, h = MAGNET_HEIGHT , $fn = _cylinderRes);
}