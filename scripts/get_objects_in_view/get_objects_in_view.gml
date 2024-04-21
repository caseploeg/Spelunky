/// @description Return a list of objects within the current viewport
/// @param obj_type The type of object to check for

function get_objects_in_view(obj_type) {
	var player = oGame.players[0];
	
    var view_x = player.x;
	var view_y = player.y;
    var _view_y = view_yview[0];
	
    var view_w = 200;
    var view_h = 200;
	

    var list = ds_list_create();  // Create a list to store objects that are in view

    // Loop through all instances of the object type
    var inst = instance_find(obj_type, 0);
    var count = instance_number(obj_type);
	
    for (var i = 0; i < count; i++) {
        if (inst.x >= view_x - view_w/2 && inst.x <= view_x + view_w/2 && inst.y >= view_y - view_h/2 && inst.y <= view_y + view_h/2) {
            ds_list_add(list, inst.id);
			inst.image_blend = c_red;// Add the instance ID to the list if it's within the viewport
        } else {
			inst.image_blend = c_white;
		}
        inst = instance_find(obj_type, i+1);  // Find the next instance
    }

    return list;  // Return the list of instances in view
}



function get_all_objects_in_view() {
	if (!instance_exists(oGame)) {
		show_debug_message("oGame does not exist");
		var _list = ds_list_create(); 
		return _list;
	}
    var player = oGame.players[0];
	var _list = ds_list_create();  // Create a new list to store instance IDs

    with (all)  // 'all' targets all instances of all objects
    {
		var r1 = player.x - 384/2;
		var r3 = player.x + 384/2;
		if r1 < 0 {
		r3 -= r1;	
		}
		
		
		if player.x < 384/2 {
			r1 = 0;
			r3 = 384;
		} else if player.x + 384/2  > 656 {
			r1 = 656 - 384;
			r3 = 656;
		}
		
		show_debug_message(string(r1) + " " + string(r3));
		//show_debug_message(string(r1) + " " + string(r2) + string(player.x) + string(player.y));
        // Check if the instance's position is within the view's boundaries
        if (point_in_rectangle(x, y, r1, player.y-128, r3, player.y+128))
        {
			image_blend = c_red;
            ds_list_add(_list, id);  // Add the instance ID to the list
        } else {
			image_blend = c_white;
		}
    }

    return _list;  // Return the list of instances within the view
}
