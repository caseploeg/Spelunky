// Create Event of the obj_NetworkController
persistent = true;
show_debug_message("create");


var server_ip = "localhost";  // Server IP Address
var server_port = 5002;  // Server Port

global.socket = network_create_socket(network_socket_tcp);
show_debug_message("Socket ID: " + string(global.socket));

if (network_connect_raw(global.socket, server_ip, server_port) < 0) {
    show_debug_message("Failed to connect to server.");
    game_end();  // Ends game if cannot connect
} else {
    show_debug_message("Connected to server!");
}
