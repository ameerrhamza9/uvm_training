module cuboid_prcr_top   #(parameter
    DATA_WIDTH = 16)
   (uart_if.rx   rxif ,
    uart_if.tx   txif ,
    input logic  clk  ,
    input logic  rstn );


   rx_fsm inst_rx_fsm(
    .clk(clk)                   ,   
    .not_ready(rxif.ready)      ,   
    .reset(rstn)                ,   
    .in_bit(rxif.sig)           ,   
    .data_write(rxif.valid)     ,   
    .out_data(rxif.data)   
); 


  cuboid_prcr cuboid_prcr_inst(
  .clk         (clk                  ),
  .in_data     (rxif.data            ),
  .in_valid    (rxif.valid           ),
  // .in_start    (rxif.in_start        ),
  .out_data    (txif.data            ),
  //.out_start   (txif.in_start        ),
  .out_valid   (txif.valid           )
  );

  // dut of fsm
rtl_tx_fsm dut_rtl_tx_fsm(
  .signal    (txif.data         ),
  // .valid     (txif.start     ),
  .write_en  (txif.valid        ),
  .clk       (clk               ),
  .reset     (reset             ), //todo : add ready out
  .out       (tx_if.sig         )
  );



endmodule
