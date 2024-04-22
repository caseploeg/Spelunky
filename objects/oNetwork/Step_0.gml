// Step Event of obj_NetworkController

if (global.socket > -1) {

	//var reward = calculate_reward(); // Implement this based on your game logic
	//var game_state = get_game_state(); // Get the game state, convert to a string or suitable format
	//var data = "('" + string(game_state) + "', " + string(reward) + ", false, {})";
	
	
	var l = get_all_objects_in_view();
	
	//show_debug_message(string(ds_list_size(l)));
	var data = "";
	var enemies = "Enemies on Screen: ";
    for (var i = 0; i < ds_list_size(l); i++)
    {
        var obj_id = ds_list_find_value(l, i);  // Get the instance id at index i
        if (instance_exists(obj_id))
        {
            var obj_x = obj_id.x;  // Get the x-coordinate of the instance
            var obj_y = obj_id.y;  // Get the y-coordinate of the instance
           
			var obj_type = object_get_name(obj_id.object_index); 
			data += (string(obj_type) + ", " + string(obj_x) + ", " + string(obj_y) + "\n");
        
			if object_is_ancestor(obj_id.object_index, oEnemy) {
				enemies += string(obj_type) + ", ";	
			}
			
		
		}
    }
	
	var state = "State: ";
	state += "Hearts: " + string(global.plife) + ", ";
	state += "Bombs: " + string(global.bombs) + ", ";
	state += "Ropes: " + string(global.rope) + ", ";
	state += "Money: " + string(global.money) + ", ";
	state += "Time: " + string (global.time) + ", ";
	state += enemies;

	// player object specific stats
	if instance_exists(oPlayer1) and instance_exists(oGame) {
		var player = oGame.players[0];
		if player and player.holdItem {
			state += "Held Item: " + string(player.holdItem.type) + ", ";
		}
		state += "PlayerX: " + string(player.x)  + "  PlayerY: " + string(player.y) + ", ";
	}
	
	if global.messageTimer > 0 {
		state += "Popup Text: " + global.message + " " + string(global.message2) + ", ";	
	}
	
	
	// current level?
	state += "Level: " + string(global.currLevel) + ", ";
	

	var action = "Action: ";
	if checkAttackPressed() {
		action += "AttackPressed, ";
	}
	if checkBombPressed() {
		action += "BombPressed, ";
	}
	if checkRopePressed() {
	    action += "RopePressed, ";
	}
	if checkJumpPressed() {
		action += "JumpPressed, ";
	}
	if checkDownPressed() {
		action += "DownPressed, ";
	}
	if checkDown() {
		action += "Down, ";	
	}
	if checkUpPressed() {
		action += "UpPressed, ";
	}
	if checkUp() {
		action += "Up, ";
	}
	if checkRightPressed() {
		action += "RightPressed, ";
	}
	if checkRight() {
		action += "Right, ";
	}
	if checkRightReleased() {
		action += "RightReleased, ";
	}
	if checkLeftPressed() {
		action += "LeftPressed, ";
	}
	if checkLeft() {
		action += "Left, ";
	}
	if checkLeftReleased() {
		action += "LeftReleased, ";
	}
	if checkRun() {
	    action += "Running, ";
	}

	data = action +  "<break>" + data + "<break>" + state;
	checkDownPressed()
	checkJumpPressed()
	checkUpPressed()
	checkRightPressed()
	checkLeftPressed()
	checkRopePressed()
	checkRun()
	ds_list_destroy(l);
	
	if data != "" {
		buffer_size = 10000;
		buffer = buffer_create(buffer_size, buffer_grow, 1);
		buffer_seek(buffer, buffer_seek_start, 0);  // Reset buffer position
	    buffer_write(buffer, buffer_string, data);  // Write the string "hi" into the buffer

		network_send_raw(global.socket, buffer, buffer_tell(buffer));
	
		buffer_delete(buffer);  // Clean up the buffer aft
	}
	
}


