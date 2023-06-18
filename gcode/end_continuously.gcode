G91 ;Relative positioning
G1 E-3 F2700 ;Retract a bit
G1 Z1 F400 ;Raise Z a bit
G90 ;Absolute positioning

; Begin active cooling
M104 S0 T0 ; Turn off extruder heat without waiting
M190 S0 ; Allow bed chill without waiting for it
ENC O1 S99 ; Start the build plate cooling fan
M106 S255 ; Ensure extruder fan is maxed out

; Position extruder out of the way to help release bed heat
G0 Y{print_bed_max[1]} F400 ; Back all the way for max fan cooling
G0 X{print_bed_max[0] / 2 + 12} Z15 F400; Wind up in center and high Z

M109 R50 ; Wait for extruder to cool
M104 S0 ; Turn off extruder heat

; Now that extruder is cool, it's fans can contribute to
; cooling the bed, so lower down
G0 Z0.15 F1000 ; Set Z height as low as safely possible

M190 R35 ; Wait for 35C bed before proceeding
M140 S0 ; Allow bed to chill further without waiting for it

; Wait anywhere from 15 to 60 minutes depending on 1st layer surface area,
; larger prints need longer to cool and detach! A pea takes 15 min & whole bed takes 60 min.
G4 S{(15 * 60) + (45 * 60) * (first_layer_print_size[0] * first_layer_print_size[1] / (print_bed_max[0] * print_bed_max[1]))}

;;;;;; Start setting up for the rams
; Y MUST BE ALL THE WAY BACK TO TRIGGER CUSTOM FIRMWARE COLLISION DETECTION!!!!

; Center Ram
G0 Y{print_bed_max[1]} F800 ; Back up to avoid parts
G0 X{print_bed_max[0] / 2 + 7} ; Wind up in center
G28 Y R0 ; Use a FW-hacked home that'll fail+repeat upon sustained collision!
G0 Z2 ; Lift Z to prevent snagging purge line

; Right side ram
G0 Y{print_bed_max[1]} F4000 ; Back up all the way kinda quick
G0 X{print_bed_max[0] - 25} Z0.15 ; Wind up to the right-center
G28 Y R0 ; Use a FW-hacked home that'll fail+repeat upon sustained collision!
G0 Z2 ; Lift Z to prevent snagging purge line

;;;;; Ram was successful! Begin cleanup + prep for next print between rams
M106 S0 ; Turn off extruder fan now that all is cool
ENC O1 S0 ; Stop plate cooling fan
; Pre-warm for presumed next run, otherwise it'll turn off soon 'nuff
M140 S45; Allow bed preheat for re-leveling

; Right-center ram
G0 Y{print_bed_max[1]} F4000 ; Back up all the way kinda quick
G0 X{((print_bed_max[0] / 2 + 7) + (print_bed_max[0] - 25))/2} Z0.15 ; Wind up to the right-center
G28 Y R0 ; Use a FW-hacked home that'll fail+repeat upon sustained collision!
G0 Z2 ; Lift Z to prevent snagging purge line

; Center ram
G0 Y{print_bed_max[1]} F4000 ; Back up all the way kinda quick
G0 X{print_bed_max[0] / 2 + 7} Z0.15 ; Wind up to the left-center
G28 Y R0 ; Use a FW-hacked home that'll fail+repeat upon sustained collision!
G0 Z2 ; Lift Z to prevent snagging purge line

M140 S0 ;Turn-off bed in case unchecked-till-now left rams fail

; Left-Center ram
G0 Y{print_bed_max[1]} F4000 ; Back up all the way kinda quick
G0 X{((print_bed_max[0] / 2 + 7) + 25)/2} Z0.15 ; Wind up to the left-center
G28 Y R0 ; Use a FW-hacked home that'll fail+repeat upon sustained collision!
G0 Z2 ; Lift Z to prevent snagging purge line

; Left ram
G0 Y{print_bed_max[1]} F4000 ; Back up all the way kinda quick
G0 X25 Z0.15 ; Wind up to the left-center
G28 Y R0 ; Use a FW-hacked home that'll fail+repeat upon sustained collision!

M140 S60; Allow bed preheat for re-leveling
M104 S60; Pre-bake nozzle temp for re-leveling

G28 X; Ensure left edge clear (and re-home X for free!)
G0 Z2 ; Lift Z a bit to prevent pushing the purge line
G0 X{print_bed_max[0]} Y0 F1500; Ensure the entire edge is clear

;;;;; Clean up: Scrape off excess purge lines by cutting Xs toward the edge
G0 X{print_bed_max[0]/2 + 89} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

G0 X{print_bed_max[0]/2 + 70} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 + 70 - 40} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract
G0 Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 + 70} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

G0 X{print_bed_max[0]/2 + 50} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 + 50 - 40} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract
G0 Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 + 50} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

G0 X{print_bed_max[0]/2 + 30} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 + 30 - 40} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract
G0 Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 + 30} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

G0 X{print_bed_max[0]/2 + 10} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 + 10 - 40} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract
G0 Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 + 10} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

G0 X{print_bed_max[0]/2} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 - 40} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract
G0 Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

G0 X{print_bed_max[0]/2 - 10} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 - 10 - 40} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract
G0 Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 - 10} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

G0 X{print_bed_max[0]/2 - 30} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 - 30 - 40} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract
G0 Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 - 30} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

G0 X{print_bed_max[0]/2 - 50} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 - 50 - 40} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract
G0 Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 - 50} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

G0 X{print_bed_max[0]/2 - 70} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 - 70 - 40} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract
G0 Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 X{print_bed_max[0]/2 - 70} Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

G0 X{print_bed_max[0]/2 - 89} Y40 F10000; Move over start of purge line
G0 Z0.05; Move down to plate
G0 Y0 F2200; Scrape down and off the plate
G0 Z1 F1000; Retract

M104 S120; Pre-bake nozzle temp for re-leveling

G1 X5 Y5 F5000.0 ; Move to re-level start position
G29 ; Re-level the bed for good measure
M140 S{first_layer_bed_temperature[0]}; Allow bed to hit max
M104 S{first_layer_temperature[0]}; Pre-bake nozzle temp for next run
G1 X{print_bed_max[0]/2 - 90} Y0 Z3 F3000.0 ; Move back to start position

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
