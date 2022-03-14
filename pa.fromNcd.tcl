
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name CPTR380_Hess -dir "/home/archie/WWU/W22/CPTR380/Project/CPTR380_Hess/planAhead_run_1" -part xc6slx16ftg256-3
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "/home/archie/WWU/W22/CPTR380/Project/CPTR380_Hess/instruction_set.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/archie/WWU/W22/CPTR380/Project/CPTR380_Hess} }
set_property target_constrs_file "wwu_fpga3_s6sdram_vector.ucf" [current_fileset -constrset]
add_files [list {wwu_fpga3_s6sdram_vector.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "/home/archie/WWU/W22/CPTR380/Project/CPTR380_Hess/instruction_set.ncd"
if {[catch {read_twx -name results_1 -file "/home/archie/WWU/W22/CPTR380/Project/CPTR380_Hess/instruction_set.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"/home/archie/WWU/W22/CPTR380/Project/CPTR380_Hess/instruction_set.twx\": $eInfo"
}
