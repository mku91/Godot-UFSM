# Godot-UFSM
Godot FSM Plugin

Ultimate Finite State Machine(v1.0) for Godot(3.4.2)

# Use

1. Add UFSM node
2. Add custom states


```
# in node code...

onready var FSM = $UFSM

var default_state = State.new(self, {
  "enter": "enter_func",
# "exit": "exit_func",
# "update": "update_func",
})

func _ready():
  FSM.switch(default_state)
  # FSM.push(default_state)
  # FSM.pop()
  # FSM.insert(default_state, 1)

func enter_func():
  print_debug("Hello")
```
