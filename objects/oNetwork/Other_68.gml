// Asynchronous Networking Event

var type = async_load[? "type"];
switch (type) {
    case network_type_connect:
        if (async_load[? "socket"] == global.socket) {
            show_debug_message("Connected successfully to the server.");
        }
        break;

    case network_type_disconnect:
        if (async_load[? "socket"] == global.socket) {
            show_debug_message("Disconnected from server.");
            global.socket = -1;
        }
        break;

    case network_type_data:
        
        var buffer = async_load[? "buffer"];
        buffer_seek(buffer, buffer_seek_start, 0);
        var receivedData = buffer_read(buffer, buffer_string);
        show_debug_message("Received data: " + receivedData);
	
		if receivedData == "left" {
			global.hackleft = true;
			global.hackright = false;
		}
		if receivedData == "right" {
			global.hackright = true;
			global.hackleft = false;
		}
        buffer_delete(buffer);
		
        break;

    case network_type_non_blocking_connect:
        var status = async_load[? "status"];
        if (async_load[? "socket"] == global.socket) {
            if (status == network_connect_status_connected) {
                show_debug_message("Successfully connected (non-blocking).");
            } else {
                show_debug_message("Failed to connect (non-blocking). Connection status: " + string(status));
                global.socket = -1;
            }
        }
        break;
}
