// Create Event of obj_NetworkController

var buffer_size = 1024;
buffer = buffer_create(buffer_size, buffer_grow, 1); // Buffer for incoming data
server_ip = "localhost"; // Change to your server IP if different
server_port = 5000; // Change to your server port if different

socket = network_create_socket(network_socket_tcp);
if (network_connect_raw(socket, server_ip, server_port) < 0) {
    show_debug_message("Failed to connect to server.");
    game_end(); // Ends game if cannot connect
}