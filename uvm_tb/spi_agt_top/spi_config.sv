/********************************************************************************************
Filename    :	   spi_config.sv   

Description :      SPI Configuration class

Author Name :      Sriker

Version     :      1.8
*********************************************************************************************/
class spi_config extends uvm_object;

	`uvm_object_utils( spi_config )

	virtual spi_intf  spi_if;

	uvm_active_passive_enum  is_active;
	
	extern function new( string name ="spi_config" );
	
endclass : spi_config


function spi_config :: new( string name ="spi_config" );

	super.new( name );
	
endfunction : new
 
