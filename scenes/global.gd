extends Node

var level_index: int = 0
var mod_pack_id: String = ""
var level_pack_id: String = ""
var level_data: Dictionary = {}
var save_data_path = "user://save.json"

func init_save_data(force_clean: bool = false):
	print("Initialize save file, force_clean: " + str(force_clean))
	# Should check file exist before open file
	# When .open() executed, will automatically create file(and clean file) if not exist
	var is_file_exist = FileAccess.file_exists(save_data_path)

	if is_file_exist == false:
		var save_data = FileAccess.open(save_data_path, FileAccess.WRITE)
		save_data.store_string("{}")
		save_data.close()
	elif is_file_exist == true and force_clean == true:
		var save_data = FileAccess.open(save_data_path, FileAccess.WRITE)
		save_data.store_string("{}")
		save_data.close()


func save_best_record(step: int):
	print("Update best record")

	if FileAccess.file_exists(save_data_path) == false:
		print("[Save] Save file not exist!")
		init_save_data()

	var save_data = FileAccess.open(save_data_path, FileAccess.READ_WRITE)
	var text = FileAccess.get_file_as_string(save_data_path)
	var json = JSON.new()
	var result = json.parse(text)

	if result == OK:
		var user_data = json.data
		if mod_pack_id not in user_data:
			user_data[mod_pack_id] = {}
		if level_pack_id not in user_data[mod_pack_id]:
			user_data[mod_pack_id][level_pack_id] = {}
		if str(level_index) not in user_data[mod_pack_id][level_pack_id]:
			user_data[mod_pack_id][level_pack_id][str(level_index)] = 0
		var previous_step = user_data[mod_pack_id][level_pack_id][str(level_index)]
		if previous_step <= 0 or step < previous_step:
			user_data[mod_pack_id][level_pack_id][str(level_index)] = step
		save_data.store_string(JSON.stringify(user_data))
		save_data.close()
	else:
		print("Load JSON meets exception!")


func get_best_record() -> int:
	var save_data = FileAccess.open(save_data_path, FileAccess.READ_WRITE)
	var text = FileAccess.get_file_as_string(save_data_path)
	var json = JSON.new()
	var result = json.parse(text)
	var step = 0

	if result == OK:
		var user_data = json.data
		if mod_pack_id not in user_data:
			step = 0
		elif level_pack_id not in user_data[mod_pack_id]:
			step = 0
		elif str(level_index) not in user_data[mod_pack_id][level_pack_id]:
			step = 0
		else:
			step = user_data[mod_pack_id][level_pack_id][str(level_index)]
			if step < 0:
				step = 0
	return step
