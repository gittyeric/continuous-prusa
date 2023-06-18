G91 ;Relative positioning
G1 E-2 F2700 ;Retract a bit
G1 Z1 F400 ;Retract and raise Z
G90 ;Absolute positioning

; Begin cooling
M104 S0 T0 ; Turn off extruder heat without waiting
M190 S0 ; Allow bed chill without waiting for it
ENC O1 S99 ; Start the build plate cooling fan

; Turn off
M18 ; Disable motors
M106 P0 S0 ; Ensure fan 0 is off
M107 P0 ; Turn off fan 0
M106 P1 S0 ; Ensure fan 1 is off
M107 P1 ; Turn off fan 1
M106 P2 S0 ; Ensure fan 2 is off
M107 P2 ; Turn off fan 2
M104 S0 ;Turn-off hotend
M140 S0 ;Turn-off bed
M81 ; Officially power off in FW

@pause ; Pause at the end to make sure any continuous print queueing is stalled!
