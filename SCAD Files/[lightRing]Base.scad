//Constants
MOTOR_LENGTH = 52;//mm
MOTOR_DIAM = 20;//mm
MOTOR_TOLERANCE = -2;//mm
TOTAL_RING_DIAM = 119;//mm
RING_CLEARANCE = 11;//mm
ARM_THICKNESS = 16.5;//mm



fullArm();


//modules
module fullArm(){
	difference(){
		buildStructure();
		//cross section cube
		// translate([(ARM_THICKNESS/2),-.1,-.1]){
		// 	cube([ARM_THICKNESS+86.49,140,140]);
		// }
		//end cross section
		translate([2,0,0]){
			internalPipe(2.60);
		}

		translate([ARM_THICKNESS/2,69.5,24.3]){
			rotate([-14.9,0,0]){
				cylinder(r=6, h =3);
				translate([0,3,-4]){
					rotate([35,0,0]){
						cylinder(r=2,h=13, $fn=70);
					}
					
				}
				
			}
		}
	
		translate([ARM_THICKNESS/2,39.7,41.5]){
			rotate([-46,0,0]){
				cylinder(r=6, h =3);
				translate([0,3.5,-4.3]){
					rotate([37,0,0]){
						cylinder(r=2,h=14, $fn=70);
					}
				}
			}
		}

		translate([ARM_THICKNESS/2,24.7,68]){
			rotate([-74,0,0]){
				cylinder(r=6, h =3);
				translate([0,12,,-8]){
					rotate([55,0,0]){
						cylinder(r=2,h=17, $fn=70);
					}
				}
			}
		}
	}
}

module buildStructure(){
	union(){
		mainStructure();
		translate([8.2,0,TOTAL_RING_DIAM/1.3]){
			rotate([0,90,90]){
				difference(){
					motorMount(30,25);
					translate([0,0,-10]){
						motorMount(25,20,40);
					}
				}
				
			}
		}

		translate([0,6.4,44.6]){
			rotate([0,90,0]){
				roundedEdge(3.27,145);
			}
		}

		translate([ARM_THICKNESS/2,TOTAL_RING_DIAM/1.391,0]){
			difference(){
				joinBase(20, 7.5);
				translate([-20,0,-1]){
					cube([40,20,40]);
				}
				translate([0,0,-1]){
					cylinder(r=11.2, h = 7.1);
				}
				
			}
		}
	}
}

module mainStructure(){
	maxArmWidth = TOTAL_RING_DIAM+MOTOR_LENGTH;
	maxArmHeight = maxArmWidth/2;
	difference(){
		cube([ARM_THICKNESS,maxArmWidth,maxArmHeight]);
		rotate([0,90,0]){
			translate([-maxArmHeight,maxArmWidth/2,-5.]){
				translate([-.1,0,0]){
					cube([(TOTAL_RING_DIAM),190,36]);
				}
				
				cylinder(r=(TOTAL_RING_DIAM/2)+1.5, h = 25, $fn=360);

				translate([0,0,ARM_THICKNESS/1.55]){
					cylinder(r=(TOTAL_RING_DIAM/2)+4, h = 5, $fn=360);
				}
				
			}
		}

		translate([8.2,0,TOTAL_RING_DIAM/1.3]){
			rotate([0,90,90]){
				translate([0,0,-10]){
					motorMount(25,20,40);
				}
			}
		}

		translate([-.5,-.5,-.5]){
			cube([ARM_THICKNESS+9,4.1,maxArmHeight-2]);
		}

		translate([ARM_THICKNESS/2,TOTAL_RING_DIAM/1.391,0]){
			translate([0,0,-1]){
					cylinder(r=11.2, h = 7.1);
				}
		}

		//cut slant from curved edge to near center
		translate([-.5,-.5,-.5]){
			cube([ARM_THICKNESS+9,8.1,(maxArmHeight/2)-2]);
		}

		rotate([0,0,270]){
			translate([7.8,ARM_THICKNESS/2,-.1]){
				cylinder(maxArmHeight/1.74,(maxArmWidth)+15,0,$fn=3);
			}
		}
	}//main difference end
}

module motorMount(motorLength, motorDiam, lengthMod = 0){
	difference(){
		motorRadius = motorDiam/2;
		motorHalfLength = motorLength/2;
		cylinder(r= motorRadius, h = motorLength+lengthMod,$fn=140);
		translate([0,0,motorHalfLength+.1]){
			difference(){
				cube([motorHalfLength,motorHalfLength+10,motorLength+3+lengthMod*2],true);
				translate([0,0,-.1]){
					cube([motorHalfLength+1,motorHalfLength+5,motorLength+3+lengthMod*2],true);
				}
			}
		}
	}
	
}

module internalPipe(pipeRadius){
	//build internal pipe structure
	sphereRadius = pipeRadius + .40;
	translate([(ARM_THICKNESS/2)-(ARM_THICKNESS/8),9.5,70]){
		rotate([65,0,0]){
			cylinder(r=pipeRadius, h = 7.8, $fn=100);
		}
	}

	translate([(ARM_THICKNESS/2)-(ARM_THICKNESS/8),10.6,69.8]){
		sphere(r=sphereRadius, $fn=40);
	}

	translate([(ARM_THICKNESS/2)-(ARM_THICKNESS/8),24.4,46.4]){
		rotate([30,0,0]){
			cylinder(r=pipeRadius, h = 26, $fn=100);
		}
	}

	translate([(ARM_THICKNESS/2)-(ARM_THICKNESS/8),44.8,29.1]){
		rotate([50,0,0]){
			cylinder(r=pipeRadius, h = 26, $fn=100);
		}
	}

	translate([(ARM_THICKNESS/2)-(ARM_THICKNESS/8),24.6,46]){
		sphere(r=sphereRadius, $fn=40);
	}

	translate([(ARM_THICKNESS/2)-(ARM_THICKNESS/8),69.8,18.7]){
		rotate([68,0,0]){
			cylinder(r=pipeRadius, h = 26, $fn=100);
		}
	}

	translate([(ARM_THICKNESS/2)-(ARM_THICKNESS/8),44.6,28.9]){
		sphere(r=sphereRadius, $fn=40);
	}

	translate([(ARM_THICKNESS/2)-(ARM_THICKNESS/8),85.6,18.5]){
		rotate([90,0,0]){
			cylinder(r=pipeRadius, h = 15, $fn=100);
		}
	}

	translate([(ARM_THICKNESS/2)-(ARM_THICKNESS/8),70,18.3]){
		sphere(r=sphereRadius, $fn=40);
	}

	translate([(ARM_THICKNESS/2)-(ARM_THICKNESS/8),85.6,5.6]){
		cylinder(r=3.4, h = 19, $fn=100);
	}


}

module roundedEdge(edgeRadius, resolution){
	cylinder(r=edgeRadius, h=ARM_THICKNESS, $fn=resolution);
}

module joinBase(radius, thickness){
	cylinder(r=radius, h =thickness, $fn=142);
}