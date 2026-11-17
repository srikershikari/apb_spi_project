/********************************************************************************************
Filename    :	   spi_sequencer.sv   

Description :      SPI Sequncer class

Author Name :      Sriker

Version     :      1.4
*********************************************************************************************/
class spi_sequencer extends uvm_sequencer #( spi_xtn );

	`uvm_component_utils( spi_sequencer )
	
	function new( string name = "spi_sequencer", uvm_component parent );
	
		super.new( name,parent );
		
	endfunction
	
endclass : spi_sequencer
