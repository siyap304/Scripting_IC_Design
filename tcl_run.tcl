# creates project and returns the current working directory
open_project [pwd]/Automation/Project_2.xpr 

# Disables source management mode (useful when managing source files manually).
set_property source_mgmt_mode None [current_project]

# Ensures the correct compilation order of all the source files in sources_1
update_compile_order -fileset sources_1 
##open the created vivado project
 

##looping over all the top modules and running the synthesis and implementation

# lindex $argv 0 → Fetches the first argument (assumed to be the filename, e.g., top_module.v).
# string trimright ... ".v" → Removes the .v extension, extracting only the module name.
# set_property top ... [current_fileset] → Sets this as the top module for synthesis.
set_property top [string trimright [lindex $argv 0] ".v"] [current_fileset] 

# to set a specific file on top
# set_property top comparator.v [current_fileset]


# same thing done above
set_property source_mgmt_mode None [current_project]
update_compile_order -fileset sources_1

# reset and launch the synthesis and implementation. THe process waits till next command is executed

# resets the synthesis runs (clears any previous results)
reset_run synth_1  
launch_runs synth_1 -jobs 20
# wait_on_run synth_1
wait_on_run synth_1

    

reset_run impl_1
launch_runs impl_1 -jobs 20
wait_on_run impl_1


open_run impl_1
report_power > Results/[string trimright [lindex $argv 0] ".v"]/power.txt
report_timing > Results/[string trimright [lindex $argv 0] ".v"]/timing.txt
report_utilization > Results/[string trimright [lindex $argv 0] ".v"]/utilization.txt
update_compile_order -fileset sources_1

close_project
