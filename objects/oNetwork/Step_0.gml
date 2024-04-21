// Step Event of obj_NetworkController

if (global.socket > -1) {

	//var reward = calculate_reward(); // Implement this based on your game logic
	//var game_state = get_game_state(); // Get the game state, convert to a string or suitable format
	//var data = "('" + string(game_state) + "', " + string(reward) + ", false, {})";
	
	//var l = get_objects_in_view(oSolid);
	var l = get_all_objects_in_view();
	
	//show_debug_message(string(ds_list_size(l)));
	var data = "";
	    // Loop through the list
    for (var i = 0; i < ds_list_size(l); i++)
    {
        var obj_id = ds_list_find_value(l, i);  // Get the instance id at index i
        if (instance_exists(obj_id))
        {
            var obj_x = obj_id.x;  // Get the x-coordinate of the instance
            var obj_y = obj_id.y;  // Get the y-coordinate of the instance
           
		   var obj_type = object_get_name(obj_id.object_index); 
		   data += (string(obj_type) + ", " + string(obj_x) + ", " + string(obj_y) + "\n");
        }
    }
	var action = "";
	if checkAttackPressed() {
		action += "A";
	}
	if checkBombPressed() {
		action += "B";
	}
	data = action +  "<break>" + data;
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


