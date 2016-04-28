//
//
//
//      CONFIDENTIAL  AND  PROPRIETARY SOFTWARE OF ARM Physical IP, INC.
//      
//      Copyright (c) 1993-2007  ARM Physical IP, Inc.  All  Rights Reserved.
//      
//      Use of this Software is subject to the terms and conditions  of the
//      applicable license agreement with ARM Physical IP, Inc.  In addition,
//      this Software is protected by patents, copyright law and international
//      treaties.
//      
//      The copyright notice(s) in this Software does not indicate actual or
//      intended publication of this Software.
//      
//
//      Creation Date:  2007-03-09 22:29:29Z
//      Version: 	
//
//
//      Verilog model generator
//
//      Cell Name:       PBCOC12A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC12A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC12B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC12B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC12C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC12C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC16A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC16A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC16B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC16B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC16C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC16C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC24A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:30Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC24A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC24B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:30Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC24B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC24C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:30Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC24C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC2A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:30Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC2A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC2C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:30Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC2C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC4A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:30Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC4A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC4C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:31Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC4C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC8A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:31Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC8A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC8B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:31Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC8B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOC8C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:31Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOC8C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC12A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:32Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC12A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC12B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:32Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC12B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC12C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:32Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC12C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC16A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:32Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC16A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC16B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:32Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC16B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC16C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:32Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC16C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC24A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:33Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC24A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC24B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:33Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC24B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC24C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:33Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC24C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC2A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:33Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC2A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC2C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:33Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC2C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC4A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:34Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC4A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC4C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:34Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC4C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC8A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:34Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC8A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC8B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:34Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC8B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOC8C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:35Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOC8C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD12A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:35Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD12A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD12B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:35Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD12B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD12C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:35Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD12C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD16A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:35Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD16A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD16B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:36Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD16B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD16C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:36Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD16C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD24A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:36Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD24A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD24B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:36Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD24B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD24C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:36Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD24C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD2A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:37Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD2A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD2C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:37Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD2C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD4A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:37Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD4A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD4C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:37Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD4C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD8A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:37Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD8A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD8B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:37Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD8B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOD8C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:38Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOD8C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD12A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:38Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD12A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD12B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:38Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD12B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD12C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:38Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD12C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD16A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:38Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD16A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD16B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:38Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD16B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD16C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:39Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD16C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD24A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:39Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD24A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD24B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:39Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD24B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD24C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:39Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD24C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD2A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:40Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD2A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD2C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:40Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD2C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD4A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:40Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD4A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD4C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:40Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD4C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD8A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:40Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD8A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD8B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:40Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD8B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOD8C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:41Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOD8C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT12A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:41Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT12A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT12B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:41Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT12B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT12C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:41Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT12C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT16A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:42Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT16A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT16B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:42Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT16B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT16C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:42Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT16C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT24A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:42Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT24A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT24B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:42Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT24B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT24C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:43Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT24C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT2A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:43Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT2A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT2C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:43Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT2C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT4A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:43Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT4A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT4C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:43Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT4C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT8A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:44Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT8A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT8B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:44Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT8B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCT8C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:44Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCT8C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT12A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:44Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT12A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT12B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:44Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT12B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT12C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:45Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT12C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT16A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:45Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT16A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT16B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:45Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT16B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT16C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:45Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT16C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT24A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:45Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT24A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT24B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:45Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT24B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT24C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:46Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT24C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT2A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:46Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT2A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT2C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:46Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT2C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT4A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:46Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT4A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT4C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:46Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT4C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT8A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:47Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT8A (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT8B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:47Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT8B (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCT8C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:47Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCT8C (
   Y,
   A,
   OE,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input IE;
   and (Y, P, IE);
   bufif1 (P, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD12A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:47Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD12A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD12B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:47Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD12B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD12C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:48Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD12C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD16A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:48Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD16A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD16B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:48Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD16B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD16C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:48Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD16C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD24A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:48Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD24A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD24B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:49Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD24B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD24C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:49Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD24C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD2A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:49Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD2A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD2C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:49Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD2C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD4A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:49Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD4A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD4C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:50Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD4C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD8A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:50Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD8A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD8B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:50Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD8B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCODD8C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:50Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCODD8C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD12A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:50Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD12A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD12B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:51Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD12B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD12C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:51Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD12C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD16A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:51Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD16A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD16B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:51Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD16B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD16C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:52Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD16C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD24A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:52Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD24A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD24B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:52Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD24B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD24C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:52Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD24C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD2A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:52Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD2A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD2C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:52Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD2C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD4A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:53Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD4A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD4C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:53Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD4C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD8A
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:53Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD8A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD8B
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:53Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD8B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSODD8C
//      Pad Type:        bidir
//      Output Type:	 pcod
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:53Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSODD8C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   nand (arti_enable, A, OE);
   bufif0 (P_i, 1'b1, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD12A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:54Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD12A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD12B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:54Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD12B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD12C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:54Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD12C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD16A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:54Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD16A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD16B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:54Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD16B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD16C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:55Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD16C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD24A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:55Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD24A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD24B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:55Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD24B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD24C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:55Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD24C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD2A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:56Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD2A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD2C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:56Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD2C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD4A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:56Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD4A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD4C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:56Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD4C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD8A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:56Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD8A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD8B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:57Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD8B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTD8C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:57Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTD8C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD12A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:57Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD12A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD12B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:57Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD12B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD12C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:57Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD12C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD16A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:57Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD16A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD16B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:58Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD16B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD16C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:58Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD16C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD24A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:58Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD24A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD24B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:58Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD24B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD24C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:59Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD24C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD2A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:59Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD2A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD2C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:59Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD2C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD4A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:59Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD4A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD4C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:59Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD4C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD8A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:29:59Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD8A (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD8B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:00Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD8B (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTD8C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:00Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTD8C (
   Y,
   A,
   OE,
   PD,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PD => P)=(200.000, 200.000);
      (OE => P)=(1.000, 200.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU12A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:00Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU12A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU12B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:00Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU12B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU12C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:01Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU12C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU16A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:01Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU16A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU16B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:01Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU16B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU16C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:01Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU16C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU24A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:01Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU24A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU24B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:01Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU24B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU24C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:02Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU24C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU2A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:02Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU2A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU2C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:02Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU2C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU4A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:02Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU4A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU4C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:03Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU4C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU8A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:03Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU8A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU8B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:03Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU8B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCOCU8C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:03Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCOCU8C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU12A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:03Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU12A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU12B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:04Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU12B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU12C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:04Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU12C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU16A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:04Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU16A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU16B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:04Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU16B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU16C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:04Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU16C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU24A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:05Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU24A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU24B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:05Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU24B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU24C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:05Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU24C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU2A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:05Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU2A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU2C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:05Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU2C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU4A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:05Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU4A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU4C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:06Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU4C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU8A
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:06Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU8A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU8B
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:06Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU8B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSOCU8C
//      Pad Type:        bidir
//      Output Type:	 ncod
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:06Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSOCU8C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P_i, 1'b0, arti_enable);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU12A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:07Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU12A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU12B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:07Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU12B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU12C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:07Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU12C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU16A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:07Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU16A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU16B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:07Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU16B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU16C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:07Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU16C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU24A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:08Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU24A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU24B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:08Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU24B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU24C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:08Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU24C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU2A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:08Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU2A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU2C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:09Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU2C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU4A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:09Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU4A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU4C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:09Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU4C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU8A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:09Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU8A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU8B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:09Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU8B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCCTU8C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:10Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCCTU8C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU12A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:10Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU12A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU12B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:10Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU12B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU12C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:10Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU12C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU16A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:10Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU16A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU16B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:11Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU16B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU16C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:11Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU16C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU24A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:11Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU24A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU24B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:11Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU24B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU24C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:11Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU24C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU2A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:11Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU2A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU2C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:12Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU2C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU4A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:12Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU4A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU4C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:12Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU4C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU8A
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:12Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU8A (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU8B
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:12Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU8B (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBCSCTU8C
//      Pad Type:        bidir
//      Output Type:	 tristate
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:13Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBCSCTU8C (
   Y,
   A,
   OE,
   PU,
   IE,
   P
);

   inout P;
   output Y;
   input A;
   input OE;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   bufif1 (P_i, A, OE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
      (A => P)=(1.000, 1.000);
      (PU => P)=(200.000, 200.000);
      (OE => P)=(200.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PIC
//      Pad Type:        input
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:13Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PIC (
   Y,
   P,
   IE
);

   output Y;
   input P;
   input IE;
   and (Y, P, IE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PICS
//      Pad Type:        input
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:13Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PICS (
   Y,
   P,
   IE
);

   output Y;
   input P;
   input IE;
   and (Y, P, IE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PICD
//      Pad Type:        input
//      Output Type:	 na
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:13Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PICD (
   Y,
   P,
   PD,
   IE
);

   output Y;
   input P;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PICSD
//      Pad Type:        input
//      Output Type:	 na
//      Keeper:          pulldown
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:14Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PICSD (
   Y,
   P,
   PD,
   IE
);

   output Y;
   input P;
   input PD;
   input IE;
   tri P;
   tri P_i;
   supply0 su0;
   rnmos (P_i, su0, PD);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PD => Y)=(200.000, 200.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PICSU
//      Pad Type:        input
//      Output Type:	 na
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:14Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PICSU (
   Y,
   P,
   PU,
   IE
);

   output Y;
   input P;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PICU
//      Pad Type:        input
//      Output Type:	 na
//      Keeper:          pullup
//      Simulate Keeper: true
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:14Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PICU (
   Y,
   P,
   PU,
   IE
);

   output Y;
   input P;
   input PU;
   input IE;
   tri P;
   tri P_i;
   supply1 su1;
   not (PU_SIG, PU);
   rpmos (P_i, su1, PU_SIG);
   nmos (P, P_i, 1'b1);
   and (Y, P, IE);
   specify
      (P => Y)=(1.000, 1.000);
      (IE => Y)=(1.000, 1.000);
      (PU => Y)=(200.000, 200.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC12A
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:14Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC12A (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC12B
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:14Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC12B (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC12C
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:15Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC12C (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC16A
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:15Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC16A (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC16B
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:15Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC16B (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC16C
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:15Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC16C (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC24A
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:15Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC24A (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC24B
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:16Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC24B (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC24C
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:16Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC24C (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC2A
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:16Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC2A (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC2C
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:16Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC2C (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC4A
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:16Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC4A (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC4C
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:16Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC4C (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC8A
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:17Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC8A (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC8B
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:17Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC8B (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POC8C
//      Pad Type:        output
//      Output Type:	 direct
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:17Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POC8C (
   P,
   A
);

   output P;
   input A;
   buf (P, A);
   specify
      (A => P)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC12A
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:17Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC12A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC12B
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:18Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC12B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC12C
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:18Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC12C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC16A
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:18Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC16A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC16B
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:18Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC16B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC16C
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:18Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC16C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC24A
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:19Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC24A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC24B
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:19Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC24B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC24C
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:19Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC24C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC2A
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:19Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC2A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC2C
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:19Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC2C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC4A
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:20Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC4A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC4C
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:20Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC4C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC8A
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:20Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC8A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC8B
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:20Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC8B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOC8C
//      Pad Type:        output
//      Output Type:	 ncod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:20Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOC8C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   not (A_wire, A);
   and (arti_enable, A_wire, OE);
   bufif1 (P, 1'b0, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD12A
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:21Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD12A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD12B
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:21Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD12B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD12C
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:21Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD12C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD16A
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:21Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD16A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD16B
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:21Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD16B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD16C
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:22Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD16C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD24A
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:22Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD24A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD24B
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:22Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD24B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD24C
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:22Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD24C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD2A
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:22Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD2A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD2C
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:23Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD2C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD4A
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:23Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD4A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD4C
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:23Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD4C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD8A
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:24Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD8A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD8B
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:24Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD8B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POOD8C
//      Pad Type:        output
//      Output Type:	 pcod
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:24Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POOD8C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   nand (arti_enable, A, OE);
   bufif0 (P, 1'b1, arti_enable);
   specify
      (A => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT12A
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:24Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT12A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT12B
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:24Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT12B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT12C
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:24Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT12C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT16A
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:24Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT16A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT16B
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:24Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT16B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT16C
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:25Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT16C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT24A
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:25Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT24A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT24B
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:25Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT24B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT24C
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:25Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT24C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT2A
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:26Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT2A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT2C
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:26Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT2C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT4A
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:26Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT4A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT4C
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:26Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT4C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT8A
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:26Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT8A (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT8B
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:26Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT8B (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       POCT8C
//      Pad Type:        output
//      Output Type:	 tristate
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:27Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POCT8C (
   P,
   A,
   OE
);

   output P;
   input A;
   input OE;
   bufif1 (P, A, OE);
   specify
      (A => P)=(1.000, 1.000);
      (OE => P)=(1.000, 1.000, 1.000, 1.000, 1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBREAK
//      Pad Type:        break
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:27Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBREAK (
);

   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBREAKBF
//      Pad Type:        break
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:27Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBREAKBF (
);

   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBREAKDVDDR
//      Pad Type:        break
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:27Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBREAKDVDDR (
);

   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBREAKBFDVDDR
//      Pad Type:        break
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:27Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBREAKBFDVDDR (
);

   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PCORNER
//      Pad Type:        corner
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:28Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PCORNER (
);

   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PFILL1
//      Pad Type:        filler
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:28Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PFILL1 (
);

   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PFILLH
//      Pad Type:        filler
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:28Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PFILLH (
);

   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PFILLQ
//      Pad Type:        filler
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:28Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PFILLQ (
);

   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PDVSS
//      Pad Type:        ground
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PDVSS (
   DVSS
);

   inout DVSS;
   supply0 DVSS;
   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PDVDD
//      Pad Type:        power
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PDVDD (
   DVDD
);

   inout DVDD;
   supply1 DVDD;
   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PVSS
//      Pad Type:        ground
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PVSS (
   VSS
);

   inout VSS;
   supply0 VSS;
   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PVDD
//      Pad Type:        power
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PVDD (
   VDD
);

   inout VDD;
   supply1 VDD;
   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PAVDD
//      Pad Type:        power
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PAVDD (
   AVDD
);

   inout AVDD;
   supply1 AVDD;
   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PAVSS
//      Pad Type:        ground
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:29Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PAVSS (
   AVSS
);

   inout AVSS;
   supply0 AVSS;
   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PANALOG
//      Pad Type:        bare_wire
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:30Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PANALOG (
   PADR1,
   P
);

   inout P;
   output PADR1;
   buf (PADR1, P);
   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model generator
//
//      Cell Name:       PBAREWIRE
//      Pad Type:        bare_wire
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:30Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module PBAREWIRE (
   PADR1,
   P
);

   inout P;
   output PADR1;
   buf (PADR1, P);
   specify
   endspecify

endmodule
`endcelldefine
//
//      Verilog model for SAGE-IO generator
//
//      Cell Name:       POSC1
//      Pad Type:        osc
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:30Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POSC1 (
   CK,
   PO,
   PI,
   E0,
   E1
);

   output CK;
   output PO;
   input PI;
   input E0;
   input E1;
   and (CK, E1, PI);
   nand (PO, PI, E0);
   specify
      (PI => CK)=(1.000, 1.000);
      (E1 => CK)=(1.000, 1.000);
      (PI => PO)=(1.000, 1.000);
      (E0 => PO)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model for SAGE-IO generator
//
//      Cell Name:       POSC2
//      Pad Type:        osc
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:30Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POSC2 (
   CK,
   PO,
   PI,
   E0,
   E1
);

   output CK;
   output PO;
   input PI;
   input E0;
   input E1;
   and (CK, E1, PI);
   nand (PO, PI, E0);
   specify
      (PI => CK)=(1.000, 1.000);
      (E1 => CK)=(1.000, 1.000);
      (PI => PO)=(1.000, 1.000);
      (E0 => PO)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model for SAGE-IO generator
//
//      Cell Name:       POSC3
//      Pad Type:        osc
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:31Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POSC3 (
   CK,
   PO,
   PI,
   E0,
   E1
);

   output CK;
   output PO;
   input PI;
   input E0;
   input E1;
   and (CK, E1, PI);
   nand (PO, PI, E0);
   specify
      (PI => CK)=(1.000, 1.000);
      (E1 => CK)=(1.000, 1.000);
      (PI => PO)=(1.000, 1.000);
      (E0 => PO)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
//      Verilog model for SAGE-IO generator
//
//      Cell Name:       POSC4
//      Pad Type:        osc
//      Output Type:	 na
//      Keeper:          none
//      Simulate Keeper: na
//      Pin Name Case:   upper
//
//      Creation Date:  2007-03-09 22:30:31Z
//      Version: 	
//
//      Verified With: Cadence NC-Verilog
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All ports are padded with Verilog   
//          primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module POSC4 (
   CK,
   PO,
   PI,
   E0,
   E1
);

   output CK;
   output PO;
   input PI;
   input E0;
   input E1;
   and (CK, E1, PI);
   nand (PO, PI, E0);
   specify
      (PI => CK)=(1.000, 1.000);
      (E1 => CK)=(1.000, 1.000);
      (PI => PO)=(1.000, 1.000);
      (E0 => PO)=(1.000, 1.000);
   endspecify

endmodule
`endcelldefine
//
// End of Library
//
