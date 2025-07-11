# Tcl script to create MIPS processor project in Vivado
# Usage: vivado -mode tcl -source create_project.tcl

# Set project name and location
set project_name "MIPS_Processor"
set project_dir "."

# Create project
create_project $project_name $project_dir -part xc7a35tcpg236-1

# Set project properties
set_property target_language VHDL [current_project]
set_property simulator_language VHDL [current_project]

# Add source files
add_files -norecurse [glob ../src/*.vhd]

# Add testbench files
add_files -fileset sim_1 -norecurse [glob ../tb/*.vhd]

# Add block design files
if {[file exists "../bd"]} {
    add_files -norecurse [glob ../bd/*]
}

# Add constraint files
if {[file exists "../xdc"]} {
    add_files -fileset constrs_1 -norecurse [glob ../xdc/*.xdc]
}

# Set top module (adjust as needed)
# set_property top your_top_module_name [current_fileset]

# Update compile order
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Project created successfully!"
puts "Project location: [get_property DIRECTORY [current_project]]"
