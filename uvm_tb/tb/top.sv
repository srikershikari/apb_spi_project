module top;

	import uvm_pkg::*;
	import test_pkg::*;
	
	bit clock;

	always #5 clock = ~clock;

	apb_intf apb_if( clock );
	
	spi_intf spi_if( clock );
	

	spi_top_module  DUT( .PCLK( clock ), 
	
	                        .PRESET_n( apb_if.PRESETn ),
	                         
	                        .PWRITE_i( apb_if.PWRITE ), 
	                        
	                        .PSEL_i( apb_if.PSEL ), 
	                        
	                        .PENABLE_i( apb_if.PENABLE ),
	                        
	                        .PADDR_i( apb_if.PADDR ),
	                        
		                .PWDATA_i( apb_if.PWDATA ),
		                
		                .PREADY_o( apb_if.PREADY ), 
		                
		                .PSLAVERR_o( apb_if.PSLVERR ), 
		                
		                .PRDATA_O( apb_if.PRDATA ), 
		                 
		                .ss_o( spi_if.ss ),
		                
		                .sclk_o( spi_if.sclk ),
		                
		                .spi_interrupt_request_o( spi_if.spi_inpt_req ),
		                
		                .mosi_o( spi_if.mosi ),
		                
		                .miso_i( spi_if.miso )
		            );

	initial 
	begin
	
		uvm_config_db #( virtual apb_intf ) :: set( null, "*", "apb_intf", apb_if );
		
		uvm_config_db #( virtual spi_intf ) :: set( null, "*", "spi_intf", spi_if );
	
		run_test();
	end
	
endmodule : top
