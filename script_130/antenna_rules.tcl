
 ## IBM130 Antenna Rules ##

define_antenna_rule -mode 1 -diode_mode 6 -metal_ratio 150 -cut_ratio 99999
 # DRC Rule 131 #
define_antenna_layer_rule -mode 1 -layer "M1" -ratio 150 -diode_ratio {0 0 5 0}
define_antenna_layer_rule -mode 1 -layer "M2" -ratio 150 -diode_ratio {0 0 5 0}
define_antenna_layer_rule -mode 1 -layer "M3" -ratio 150 -diode_ratio {0 0 5 0}
define_antenna_layer_rule -mode 1 -layer "MQ" -ratio 150 -diode_ratio {0 0 2 0}
define_antenna_layer_rule -mode 1 -layer "MG" -ratio 150 -diode_ratio {0 0 2 0}
define_antenna_layer_rule -mode 1 -layer "LY" -ratio 150 -diode_ratio {0 0 2 0}
define_antenna_layer_rule -mode 1 -layer "E1" -ratio 150 -diode_ratio {0 0 2 0}
define_antenna_layer_rule -mode 1 -layer "MA" -ratio 150 -diode_ratio {0 0 2 0}
 # DRC Rule 131b #
define_antenna_layer_rule -mode 1 -layer "V1" -ratio 10 -diode_ratio {0 0 7.5 0}
define_antenna_layer_rule -mode 1 -layer "V2" -ratio 10 -diode_ratio {0 0 7.5 0}
define_antenna_layer_rule -mode 1 -layer "VL" -ratio 10 -diode_ratio {0 0 3 0}
define_antenna_layer_rule -mode 1 -layer "VQ" -ratio 10 -diode_ratio {0 0 3 0}
define_antenna_layer_rule -mode 1 -layer "FY" -ratio 10 -diode_ratio {0 0 3 0}
define_antenna_layer_rule -mode 1 -layer "FT" -ratio 10 -diode_ratio {0 0 3 0}
define_antenna_layer_rule -mode 1 -layer "F1" -ratio 10 -diode_ratio {0 0 3 0}


