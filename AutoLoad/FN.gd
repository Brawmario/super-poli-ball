extends Node

func seconds_to_mm_ss_mmm(sec: float) -> String:
	var mmm := String(sec - floor(sec)).pad_decimals(3)
	# Erase extra zero
	mmm.erase(0, 1)
	var ss := String(int(sec) % 60).pad_zeros(2)
	var mm := String(int(sec) / 60).pad_zeros(2)
	return mm + ":" + ss + mmm
