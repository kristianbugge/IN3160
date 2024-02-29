vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab2/decoder/decoder_entity.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab2/decoder/decoder_architecture.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab2/decoder/tb_decoder2.vhd
vsim -voptargs=+acc work.tb_decoder2
add wave -position insertpoint  \
sim:/tb_decoder2/tb_input \
sim:/tb_decoder2/tb_count
run 500ns