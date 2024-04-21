/// @description quitGame
function quitGame() {
	show_debug_message("quitgame!");
	file_text_close(global.logfile);
	if (!global.html5Build) {
	    game_end();
	} else {
	    if (global.electronBuild) {
	        electronQuit();
	    }
	}



}
