function checkRightPressed() {
	if (gamepad.rightPressed or
	        gamepad_button_check_pressed(global.joyid, gp_padr) or
	        keyboard_check_pressed(global.keyRightVal) or global.hackright) {
	    return true;
	} else {
	    return false;
	}



}
