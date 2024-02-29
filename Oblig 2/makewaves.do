vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab2/decoder/tb_decoder.vhd
vsim -voptargs=+acc work.tb_decoder
add wave -position insertpoint  \
sim:/tb_decoder/tb_input \
sim:/tb_decoder/tb_count
run 500ns