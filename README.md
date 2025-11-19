 基于Xilinx 7020的FPGA流水灯工程

## 1、引脚约束

### LED灯的约束

PIN N22—>led[0]

PIN P22—>led[1]

PIN R18—>led[2]

PIN T18—>led[3]

PIN P20—>led[4]

PIN P21—>led[5]

PIN R20—>led[6]

PIN R21—>led[7]

### 复位按键约束

P17—>sys_rst_n

## 2、功能描述

从LED0逐个闪烁，至LED7后折返，由LED7回到LED0，以上为一个周期。

按下复位按键则从头开始。
