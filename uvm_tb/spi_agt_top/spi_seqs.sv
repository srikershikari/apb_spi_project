/********************************************************************************************
Filename    :	   spi_seqs.sv   

Description :      SPI Sequnce class

Author Name :      Sriker

Version     :      1.5
*********************************************************************************************/
class spi_seqs extends uvm_sequence #( spi_xtn );

	`uvm_object_utils( spi_seqs )

	env_config m_cfg;
	
//	spi_reg_block spi_reg_blk;

	function new( string name = "spi_seqs" );
	
		super.new( name );
		
	endfunction : new

	task body(  );
	
		if( !uvm_config_db #( env_config ) :: get( null, get_full_name(  ), "env_config", m_cfg ) )
		begin	
			`uvm_fatal( get_type_name(), "error occured while getting m_cfg" )
		end
			
	//	spi_reg_blk = m_cfg.spi_reg_blk;
	//	req = spi_xtn :: type_id :: create( "req" );
	//	start_item( req );
	//	req.randomize(  );
	//	finish_item( req );
	
	endtask
	
endclass : spi_seqs


class spi_seq1 extends spi_seqs;

	`uvm_object_utils( spi_seq1 )
	
	function new( string name = "spi_seq1" );
	
		super.new( name );
		
	endfunction : new

	task body();
	
		super.body();			
		
		repeat( 1 ) 
		begin
			req = spi_xtn :: type_id :: create( "req" );
			
			start_item( req );
			
			assert( req.randomize() );
			
			$display( "sequence from spi seq class \n" );
			req.print();
			
			finish_item( req );
		end
		
	endtask
	
endclass : spi_seq1













	
