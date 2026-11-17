/********************************************************************************************
Filename    :	   spi_agent_top.sv   

Description :      SPI Agent TOP class

Author Name :      Sriker

Version     :      1.7
*********************************************************************************************/
class spi_agent_top extends uvm_env;

	`uvm_component_utils( spi_agent_top )
	
	spi_agent spi_agnth;

	extern function new( string name = "spi_agent_top", uvm_component parent );
	
	extern function void build_phase( uvm_phase phase );
	
	extern function void end_of_elaboration_phase( uvm_phase phase );

endclass : spi_agent_top


function spi_agent_top :: new( string name = "spi_agent_top", uvm_component parent );

	super.new( name,parent );
	
endfunction : new


function void spi_agent_top :: build_phase( uvm_phase phase );

	super.build_phase( phase );
	
	spi_agnth = spi_agent :: type_id :: create( "spi_agnth", this );
	
endfunction : build_phase


function void spi_agent_top :: end_of_elaboration_phase( uvm_phase phase );

        $display( "Printing topology from spi agent top class \n" );
        
	//uvm_top.print_topology;
	
endfunction : end_of_elaboration_phase












