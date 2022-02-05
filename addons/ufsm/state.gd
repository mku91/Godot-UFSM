extends Reference

class_name State, "res://addons/ufsm/State.png"

signal enter
signal exit
signal update
signal phy_update

func _init(parent, config: Dictionary):
	if config.has("enter"):
		connect("enter", parent, config.enter)
	if config.has("exit"):
		connect("exit", parent, config.exit)
	if config.has("update"):
		connect("update", parent, config.update)
	if config.has("phy_update"):
		connect("phy_update", parent, config.phy_update)

func enter():
	emit_signal("enter")
	pass
	
func exit():
	emit_signal("exit")
	pass

func update(delta):
	emit_signal("update", delta)
	pass

func physics_update(delta):
	emit_signal("phy_update", delta)
	pass
