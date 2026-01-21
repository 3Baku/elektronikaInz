database -open sim_model -event -shm -into sim_model -default
probe -all -memories -functions -tasks -depth all -database sim_model -create
run
exit
