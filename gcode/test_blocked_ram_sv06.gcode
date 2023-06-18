G91 ;Relative positioning
G1 E-2 F2700 ;Retract a bit
G1 Z1 F400 ;Retract and raise Z
G90 ;Absolute positioning
M104 S0 T0 ; Turn off extruder heat without waiting

G0 Y220 F800 ; Back up to avoid parts
G0 X122 Z1 F 800 ; Wind up in center
@pause
G28 Y R0 ; Home Y
M300 S440 P200 ; Beep!