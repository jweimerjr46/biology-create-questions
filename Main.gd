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
		var question = { "question":question_text.text,
		 "options":[option_1.text, option_2.text, option_3.text, option_4.text],
		"correct": correct_answer, "xp": xp_text.text, "level": level_text.text, "image": image_file_name}
		var json_string = JSON.stringify(question, "\t")
		print(json_string)
		var json = JSON.new()
		json.parse(json_string)
		print(json.data)
		preview_text.text = json_string
	else:
		print("You have not checked an answer")



func _on_select_image_button_pressed():
	get_image.visible = true


func _on_file_dialog_file_selected(path):
	image_file_name = get_image.current_file
	image_preview_label.text = "[img]"+path+"[/img]"	
	print(get_image.current_file)
