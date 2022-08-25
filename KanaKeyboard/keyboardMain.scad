//measurements in millimeters
_screenHeight = 2;
_screenWidth = 19;
_screenLength = 24;

//constants
_numScreenKeys = 25;
_numBasicKeys = 5;

//formulas


main();

module main(){
    screenModel();
}

module screenModel(){
    cube([_screenWidth, _screenLength, _screenHeight], true);
}