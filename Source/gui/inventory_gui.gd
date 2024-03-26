extends Control

signal opended
signal closed

var isOpen: bool= false

func open():
	visible = true
	isOpen = true
	opended.emit()

func close():
	visible = false
	isOpen = false
	closed.emit()
