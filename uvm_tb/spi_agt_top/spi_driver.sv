/********************************************************************************************
Filename    :	   spi_driver.sv   

Description :      SPI Driver class

Author Name :      Sriker

Version     :      1.2
*********************************************************************************************/
class spi_driver extends uvm_driver #( spi_xtn );

	`uvm_component_utils( spi_driver )
	
	virtual spi_intf.SPI_DRV_MP  spi_drv_if;
	
	spi_config  spi_cfg;

	bit [7:0] ctrl;
	
	bit cpol;
	
	bit cphase;
	
	bit lsbfe;
	
	extern function new( string name = "spi_driver", uvm_component parent );
	
	extern function void build_phase( uvm_phase phase );
	
	extern function void connect_phase( uvm_phase phase );
	
	extern task run_phase( uvm_phase phase );
	
	extern task send_to_dut( spi_xtn xtn );
	
endclass : spi_driver


function spi_driver :: new( string name = "spi_driver", uvm_component parent );

	super.new( name,parent );
	
endfunction: new


function void spi_driver :: build_phase( uvm_phase phase );

	super.build_phase( phase );
	
	if( !uvm_config_db #( spi_config ) :: get( this, "", "spi_config", spi_cfg ) )
	begin
		`uvm_fatal( get_type_name(), "error while getting the spi_config" );
	end	

	if( !uvm_config_db #( bit[7:0] ) :: get( this,"","bit",ctrl ) )
	begin
		`uvm_fatal( get_type_name(), "error while getting ctrl bit" );
	end	
	
endfunction : build_phase


function void spi_driver :: connect_phase( uvm_phase phase );

	super.connect_phase( phase );
	
	spi_drv_if = spi_cfg.spi_if;

	cpol = ctrl[3];
	
	cphase = ctrl[2];
	
	lsbfe = ctrl[0];

endfunction : connect_phase


task spi_driver :: run_phase( uvm_phase phase );

	super.run_phase( phase );
	
	forever 
	begin
		seq_item_port.get_next_item( req );
		
		send_to_dut( req );
		
		`uvm_info( get_type_name(), "PRINTING From SPI DRIVER", UVM_LOW )
		
		req.print;
		
		seq_item_port.item_done(  );
	end
	
endtask : run_phase


task spi_driver :: send_to_dut( spi_xtn xtn );
	
	$display( "spi driver ss = %0d",spi_drv_if.spi_drv_cb.ss );
	
	wait( !spi_drv_if.spi_drv_cb.ss )
	
	//if CPHASE=0 drive first bit immediatley
	if( !cphase )
	begin
	        spi_drv_if.spi_drv_cb.miso <= xtn.miso[ lsbfe ? 0 : 7 ];
	end
	
	//Drive 8 bits
	for( int i = cphase ? 0 : 1; i < 8; i++ )
	begin
	        if( cpol ^ cphase )
	        begin
	                @( posedge spi_drv_if.spi_drv_cb.sclk );
	        end
	        
	        else
	        begin
	                @( negedge spi_drv_if.spi_drv_cb.sclk );
	        end
	        
	        spi_drv_if.spi_drv_cb.miso <= xtn.miso[ lsbfe ? i : 7 - i ];
	
	end

endtask : send_to_dut


/*
if( lsbfe ) 
	begin
		if( ( !cpol )&&( !cphase ) ) 
		begin
			//spi_drv_if.spi_drv_cb.miso <= xtn.miso[0];
			for( int i =0;i<8;i++ ) begin
				spi_drv_if.spi_drv_cb.miso <= xtn.miso[i];
				@( negedge spi_drv_if.spi_drv_cb.sclk );
			end
		end
		
		else if( ( !cpol )&&( cphase ) ) 
		begin
		//	@( posedge spi_drv_if.spi_drv_cb )
		//	spi_drv_if.spi_drv_cb.miso <= xtn.miso[0];
			for( int i =0;i<8;i++ ) begin
				@( posedge spi_drv_if.spi_drv_cb.sclk )
				spi_drv_if.spi_drv_cb.miso <= xtn.miso[i];
			end
		end
		
		else if( ( cpol )&&( !cphase ) ) 
		begin

		//	spi_drv_if.spi_drv_cb.miso <= xtn.miso[0];
			for( int i =0;i<8;i++ ) begin
				spi_drv_if.spi_drv_cb.miso <= xtn.miso[i];

				@( posedge spi_drv_if.spi_drv_cb.sclk );

			end
		end
		
		else if( ( cpol )&&( cphase ) ) 
		begin
		//	@( negedge spi_drv_if.spi_drv_cb );
		//	spi_drv_if.spi_drv_cb.miso <= xtn.miso[0];
			for( int i =0;i<8;i++ ) begin
				@( negedge spi_drv_if.spi_drv_cb.sclk )
				spi_drv_if.spi_drv_cb.miso <= xtn.miso[i];
			end
		end
	end

	else 
	begin
		if( ( !cpol )&&( !cphase ) ) 
		begin
			//spi_drv_if.spi_drv_cb.miso <= xtn.miso[7];
			for( int i =7;i>=0;i-- ) begin
				spi_drv_if.spi_drv_cb.miso <= xtn.miso[i];
				@( negedge spi_drv_if.spi_drv_cb.sclk );
			end
		end
		
		else if( ( !cpol )&&( cphase ) ) 
		begin
		//	@( posedge spi_drv_if.spi_drv_cb );
		//	spi_drv_if.spi_drv_cb.miso <= xtn.miso[7];
			for( int i =7;i>=0;i-- ) begin
				@( posedge spi_drv_if.spi_drv_cb.sclk )
				spi_drv_if.spi_drv_cb.miso <= xtn.miso[i];
			end
		end
		
		else if( ( cpol )&&( !cphase ) ) 
		begin
		//	spi_drv_if.spi_drv_cb.miso <= xtn.miso[7];
			for( int i =7;i>=0;i-- ) begin
				spi_drv_if.spi_drv_cb.miso <= xtn.miso[i];
				@( posedge spi_drv_if.spi_drv_cb.sclk );
			end
		end
		
		else if( ( cpol )&&( cphase ) ) 
		begin
		//	@( negedge spi_drv_if.spi_drv_cb )
		//	spi_drv_if.spi_drv_cb.miso <= xtn.miso[7];
			for( int i =7;i>=0;i-- ) begin
				@( negedge spi_drv_if.spi_drv_cb.sclk )
				spi_drv_if.spi_drv_cb.miso <= xtn.miso[i];
			end
		end
	end
*/




	

