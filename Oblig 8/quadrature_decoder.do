vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab8/tb_quadrature_decoder.vhd
add wave -position insertpoint  \
sim:/tb_quadrature_decoder/mclk \
sim:/tb_quadrature_decoder/reset \
sim:/tb_quadrature_decoder/sa \
sim:/tb_quadrature_decoder/sb \
sim:/tb_quadrature_decoder/pos_inc \
sim:/tb_quadrature_decoder/pos_dec \
sim:/tb_quadrature_decoder/HALF_PERIOD \
sim:/tb_quadrature_decoder/PERIOD
run 5000 ns