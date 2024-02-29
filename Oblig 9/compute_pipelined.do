vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab9/src/tb_compute_pipelined.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab9/src/compute_pipelined.vhd
vsim -voptargs=+acc work.tb_compute_pipelined
run
run
run
run