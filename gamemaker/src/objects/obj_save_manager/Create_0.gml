// =============================================================
// obj_save_manager — Create
// Persistent across rooms. Stores last completed level + last
// chosen disciple in a tiny INI file.
// Place ONE instance in rm_title (it's marked persistent so it
// follows the player into every other room).
// =============================================================

persistent = true;

global.last_completed_room        = "none";
global.selected_player_obj_name   = "obj_player_peter";
global.selected_player_obj        = obj_player_peter;

save_save = function() {
    ini_open("disciples_save.ini");
    ini_write_string("progress", "last_room",      global.last_completed_room);
    ini_write_string("progress", "last_disciple",  global.selected_player_obj_name);
    ini_close();
};

save_load = function() {
    ini_open("disciples_save.ini");
    global.last_completed_room      = ini_read_string("progress", "last_room",     "none");
    global.selected_player_obj_name = ini_read_string("progress", "last_disciple", "obj_player_peter");
    ini_close();

    var _n = global.selected_player_obj_name;
    if      (_n == "obj_player_peter")    global.selected_player_obj = obj_player_peter;
    else if (_n == "obj_player_john")     global.selected_player_obj = obj_player_john;
    else if (_n == "obj_player_james")    global.selected_player_obj = obj_player_james;
    else if (_n == "obj_player_matthew")  global.selected_player_obj = obj_player_matthew;
    else                                  global.selected_player_obj = obj_player_peter;
};

// Load existing save on first creation
save_load();
