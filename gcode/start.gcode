M913 X0 Y0 Z0 E0 ; Disable stealthchop, prefer accuracy+speed over silence
ENC O1 S0 ; Ensure the build plate cooling fan is off

G91 ;Relative positioning
G1 Z2.5 F1500 ; Ensure Z is well above plate just in case
G90 ; Abs positioning

M190 S{first_layer_bed_temperature[0] * 0.6}; Wait for bed to warm up just a bit
M104 S{first_layer_temperature[0] * 0.6}; Allow nozzle temp to increase while waiting for bed temp
M190 S{first_layer_bed_temperature[0] * 0.75}; Wait for bed to reach at LEAST this before homing
M140 S{first_layer_bed_temperature[0]}; Alow bed temp to increase while homing
M104 S{first_layer_temperature[0]}; Alow nozzle temp to increase while homing

G28 O ;Home

G92 E0 ;Reset Extruder
G1 X{print_bed_max[0]/2 - 90} Y0 F5000.0 ;Move to start position

M190 S{first_layer_bed_temperature[0] * 0.9}; Wait for bed temp to hit % heat
M140 S{first_layer_bed_temperature[0]}; Allow bed temp to reach target
M109 S{first_layer_temperature[0]} ; Wait for extruder to hit 100%

G1 X{print_bed_max[0]/2 - 10} Z0.15 F1500.0 E13 ;Draw the first line, ending with Z touching
G1 X{print_bed_max[0]/2 + 70} F1500.0 E20 ;Draw 2nd half of first line
G1 Z0.05 F1500.0 E20 ;Draw 2nd half of first line
G1 X{print_bed_max[0]/2 + 80} Z0.05 F2000.0 ; Wipe excess
G1 X{print_bed_max[0]} Z0.05 F2000.0 ; Wipe excess
G1 Y5 F5000.0 ; Jerk up to detach from purge line

G0 Z1 F5000.0 ; Raise slightly and backoff to disconnect from purge line
G92 E0 ;Reset Extruder
