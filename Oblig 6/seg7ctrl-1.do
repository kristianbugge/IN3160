vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab6/seg7model_beh.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab6/seg7model_ent.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab6/bin2ssd.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab6/tb_seg7model.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab6/seg7ctrl.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab6/tb_seg7ctrl.vhd

vsim -voptargs=+acc work.tb_seg7ctrl

add wave -position insertpoint  \
sim:/tb_seg7ctrl/tb_c \
sim:/tb_seg7ctrl/tb_abcdefg \
sim:/tb_seg7ctrl/tb_disp1 \
sim:/tb_seg7ctrl/tb_disp0 \
sim:/tb_seg7ctrl/tb_mclk \
sim:/tb_seg7ctrl/tb_reset \
sim:/tb_seg7ctrl/tb_d0 \
sim:/tb_seg7ctrl/tb_d1 \
sim:/tb_seg7ctrl/HALF_PERIOD

run 5000 us