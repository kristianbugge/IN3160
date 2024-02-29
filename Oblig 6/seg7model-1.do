vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab6/seg7model_beh.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab6/seg7model_ent.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab6/bin2ssd.vhd
vcom -work work -2008 -explicit -vopt -stats=none /uio/hume/student-u50/kribug/Documents/IN3160/lab6/tb_seg7model.vhd
vsim -voptargs=+acc work.tb_seg7model
add wave -position insertpoint  \
sim:/tb_seg7model/tb_input \
sim:/tb_seg7model/tb_output \
sim:/tb_seg7model/tb_c \
sim:/tb_seg7model/tb_abcdefg \
sim:/tb_seg7model/tb_disp1 \
sim:/tb_seg7model/tb_disp0
run 500 ns