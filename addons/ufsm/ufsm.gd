tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("UFSM", "Node", preload("fsm.gd"), preload("StateMachine.png"))
	pass


func _exit_tree():
	remove_custom_type("UFSM")
	pass
