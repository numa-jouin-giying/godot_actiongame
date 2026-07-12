@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("InputHandler" , "Node" , preload("res://Scripts/Addons/InputHandler.gd") , null )
	add_custom_type("ChracterMovement3D" , "CharacterBody3D" , preload("res://Scripts/Addons/CharacterMovement3D.gd") , null)
	pass 

func _exit_tree() -> void:
	remove_custom_type("InputHandler")
	remove_custom_type("CharacterMovement3D")
	pass
