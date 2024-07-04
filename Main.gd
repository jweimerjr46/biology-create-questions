extends Control

@onready var question_text = $MarginContainer/HBoxContainer/VBoxContainer2/TextEdit
@onready var option_1 = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Option1
@onready var option_2 = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/Option2
@onready var option_3 = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/Option3
@onready var option_4 = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer4/Option4
@onready var option_1_checkbox = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Option1CheckBox
@onready var option_2_checkbox = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/Option2CheckBox
@onready var option_3_checkbox = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/Option3CheckBox
@onready var option_4_checkbox = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer4/Option4CheckBox
@onready var xp_text = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer6/XPEdit
@onready var level_text = $MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer6/LevelEdit
@onready var preview_text = $MarginContainer/HBoxContainer/VBoxContainer/PreviewEdit
@onready var get_image = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/FileDialog
@onready var image_preview_label = $MarginContainer/HBoxContainer/VBoxContainer/ImagePreviewLabel
var image_file_name = ""
@onready var get_json = $MarginContainer2/MainMenu/FileDialogJSON
var questions_json = ""

var json
var question_dict = {}

@onready var stats_info = $MarginContainer/HBoxContainer/VBoxContainer2/InfoLabel


func _ready():
	pass	


'''
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
'''

func _on_create_question_button_pressed():
	if option_1_checkbox.is_pressed() or option_2_checkbox.is_pressed() or option_3_checkbox.is_pressed() or option_4_checkbox.is_pressed():
		var correct_answer = ""
		if option_1_checkbox.is_pressed():
			correct_answer = option_1.text
		elif option_2_checkbox.is_pressed():
			correct_answer = option_2.text
		elif option_3_checkbox.is_pressed():
			correct_answer = option_3.text
		elif option_4_checkbox.is_pressed():
			correct_answer = option_4.text
		else:
			print("You have not selected anything")
		question_dict = { "question":question_text.text,
		 "options":[option_1.text, option_2.text, option_3.text, option_4.text],
		"correct": correct_answer, "xp": xp_text.text, "level": level_text.text, "image": image_file_name}
		var json_string = JSON.stringify(question_dict, "\t")
		#print(json_string)
		preview_text.text = json_string
	else:
		print("You have not checked an answer")


func _on_select_image_button_pressed():
	get_image.visible = true


func _on_file_dialog_file_selected(path):
	image_file_name = get_image.current_file
	image_preview_label.text = "[center][img]"+path+"[/img][/center]"	
	#print(get_image.current_file)


func _on_file_dialog_json_file_selected(path):
	questions_json = path
	calc_stats()


func calc_stats():
	var file = FileAccess.open(questions_json, FileAccess.READ)
	var json_data = file.get_as_text()
	file.close()
	var parsed_data = JSON.new()
	parsed_data.parse(json_data)
	var questions_array = parsed_data.get_data()
	var level_0 = 0
	var level_0_xp = 0
	var level_0_avg = 0
	var level_1 = 0
	var level_1_xp = 0
	var level_1_avg = 0
	var level_2 = 0
	var level_2_xp = 0
	var level_2_avg = 0
	var level_3 = 0
	var level_3_xp = 0
	var level_3_avg = 0
	var level_4 = 0
	var level_4_xp = 0
	var level_4_avg = 0
	var level_5 = 0
	var level_5_xp = 0
	var level_5_avg = 0
	for item in questions_array:
		match item['level']:
			"0":
				level_0 += 1
				level_0_xp += int(item["xp"])
			"1":
				level_1 += 1
				level_1_xp += int(item["xp"])
			"2":
				level_2 += 1
				level_2_xp += int(item["xp"])
			"3":
				level_3 += 1
				level_3_xp += int(item["xp"])
			"4":
				level_4 += 1
				level_4_xp += int(item["xp"])
			"5":
				level_5 += 1
				level_5_xp += int(item["xp"])
				
	if level_0 > 0:
		level_0_avg = 1.0*level_0_xp/level_0
	if level_1 > 0:
		level_1_avg = 1.0*level_1_xp/level_1
	if level_2 > 0:
		level_2_avg = 1.0*level_2_xp/level_2
	if level_3 > 0:
		level_3_avg = 1.0*level_3_xp/level_3
	if level_4 > 0:
		level_4_avg = 1.0*level_4_xp/level_4
	if level_5 > 0:
		level_5_avg = 1.0*level_5_xp/level_5
	stats_info.text = "Level 0: %s-%s-%.1f  Level 3: %s-%s-%.1f
	Level 1: %s-%s-%.1f   Level 4: %s-%s-%.1f
	Level 2: %s-%s-%.1f   Level 5: %s-%s-%.1f" % [level_0, level_0_xp, level_0_avg,
	 level_3, level_3_xp, level_3_avg,
	 level_1, level_1_xp, level_1_avg,
	 level_4, level_4_xp, level_4_avg,
	 level_2, level_2_xp, level_2_avg,
	 level_5, level_5_xp, level_5_avg] 
	

func _on_file_id_pressed(id):
	#print(id)
	if id == 0:
		get_json.visible = true
		

func add_question_to_json(question):
	#print(questions_json)
	var file = FileAccess.open(questions_json, FileAccess.READ)
	#print(file)
	var json_data = file.get_as_text()
	file.close()
	var parsed_data = JSON.new()
	parsed_data.parse(json_data)
	var questions_array = parsed_data.data
	#print(questions_array)
	questions_array.append(question)
	var json_string = JSON.stringify(questions_array, "\t")
	file = FileAccess.open(questions_json, FileAccess.WRITE)
	file.store_string(json_string)
	file.close()
	calc_stats()


func _on_save_question_pressed():
	add_question_to_json(question_dict)
