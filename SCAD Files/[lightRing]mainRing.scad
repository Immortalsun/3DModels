//Constants
MAX_RING_RADIUS = 50;//mm
DEFAULT_RING_THICKNESS = 10;//mm
MAIN_DRIVE_RADIUS = 13.76;//mm
RING_DRIVE_RADIUS = 6;//mm
BASE_HEIGHT = 60;//mm
BASE_WIDTH = 80;//mm
BEARING_INNER_RADIUS = 4;//mm
BEARING_TOTAL_RADIUS = 11;//mm
BEARING_THICKNESS = 7;//mm
GROOVE_DEPTH = 4;//mm
MOTOR_RADIUS_TOLERANCE = .2;

ring(MAX_RING_RADIUS,DEFAULT_RING_THICKNESS);

module ring(radius,thickness,mountPosition="NS"){
	union(){
		difference(){
			rotate([0,90,0]){
				difference(){
					cylinder(r=radius,h=thickness);
					//build punch out cylinder
					innerRadius = radius/1.3;
					innerThickness = thickness+4;
					translate([0,0,-(innerThickness/5)]){
						cylinder(r=innerRadius,h=innerThickness);
					}
					wireGroove(radius, GROOVE_DEPTH, thickness);
				}//ring diference end

				
			}//rotate end
			motorCutout(ringRadius = MAX_RING_RADIUS);
		}//main difference end

		difference(){
			bearingMount(BEARING_INNER_RADIUS,BEARING_THICKNESS);
			rotate([0,90,0]){
				wireGroove(MAX_RING_RADIUS-.4, GROOVE_DEPTH, DEFAULT_RING_THICKNESS);
			}
		}

		mirror([0,1,0]){
			difference(){
				bearingMount(BEARING_INNER_RADIUS,BEARING_THICKNESS);
				rotate([0,90,0]){
					wireGroove(MAX_RING_RADIUS-.4, GROOVE_DEPTH, DEFAULT_RING_THICKNESS);
				}
		}
		}

	}
}//module end

module motorCutout(motorRadius = 4, motorHeight = 17, ringRadius){
	//build stand-in motor
	translate([DEFAULT_RING_THICKNESS/2,0,ringRadius/1.64]){
		cylinder(r=motorRadius, h=motorHeight);
	}
	
}

module bearingMount(bearingInnerRadius, bearingThickness){
	
	bearingExtension = 7.5;
	bearingPegReduction = .2;
	translate([DEFAULT_RING_THICKNESS/2,(-MAX_RING_RADIUS+(bearingThickness/1.3)),0]){
		rotate([90,0,0]){
			cylinder(r=bearingInnerRadius-bearingPegReduction,h=bearingThickness+bearingExtension);
		}
	}
}

module wireGroove(ringRadius, depth, thickness){
	translate([0,0,thickness/3]){
		difference(){
			cylinder(r=ringRadius+.1,h=thickness/3);
			translate([0,0,-.1]){
				cylinder(r=ringRadius-depth,h=(thickness/3)+.3);
			}
		}
	}
}