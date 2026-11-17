class vseqs extends uvm_sequence #( uvm_sequence_item );

	`uvm_object_utils( vseqs )
	
	vseqr vseqrh;
	
	apb_sequencer  apb_seqrh;
	
	spi_sequencer  spi_seqrh;

	apb_reset_seqs  apb_rst_seqsh;
	
	apb_cpol0_cpha0_lsb0  cpol0_cpha0_lsb0_h;
	
        apb_cpol0_cpha0_lsb1  cpol0_cpha0_lsb1_h;
        
        
        apb_cpol0_cpha1_lsb0  cpol0_cpha1_lsb0_h;
        
        apb_cpol0_cpha1_lsb1  cpol0_cpha1_lsb1_h;
        
	
	apb_cpol1_cpha0_lsb0  cpol1_cpha0_lsb0_h;
	
	apb_cpol1_cpha0_lsb1  cpol1_cpha0_lsb1_h;
	
	
	apb_cpol1_cpha1_lsb0  cpol1_cpha1_lsb0_h;
	
	apb_cpol1_cpha1_lsb1  cpol1_cpha1_lsb1_h;
	
	
	low_power_mode_seq  low_power_mode_seq_h;
        
        apb_read  apb_read_h;

	spi_seq1  spi_seq1_h;
	
	extern function new( string name = "vseqs" );
	
	extern task body(  );

endclass : vseqs


function vseqs :: new( string name ="vseqs" );

	super.new( name );
	
endfunction : new


task vseqs :: body();
        
        $display( "i am in vseqs parent body" );
        
	if( !$cast( vseqrh, m_sequencer ) )
	begin
		`uvm_error( get_full_name(  ),"error while casting m_sequencer with vseqrh" );
	end	

	apb_seqrh = vseqrh.apb_seqrh;
	
	spi_seqrh = vseqrh.spi_seqrh;

endtask : body


class reset_vseqs extends vseqs;

	`uvm_object_utils( reset_vseqs )

	function new( string name = "reset_vseqs" );
	
		super.new( name );
		
	endfunction

	task body();
	
                $display( "i am in vseqs body" );
                
                super.body();
                
                $display( "i am in vseqs after super dot body" );
                
                apb_rst_seqsh = apb_reset_seqs :: type_id :: create( "apb_rst_seqsh" );
                
                apb_read_h = apb_read :: type_id ::create( "apb_read_h" );

                apb_rst_seqsh.start( apb_seqrh );
                
                #200;
                
                apb_read_h.start( apb_seqrh );
                
	endtask
	
endclass : reset_vseqs


//cpol=0, cphase=0, lsbfe=0;
class cpol0_cpha0_lsb0_vseq extends vseqs;

	`uvm_object_utils( cpol0_cpha0_lsb0_vseq )
	
	function new( string name ="cpol0_cpha0_lsb0_vseq" );
	
		super.new( name );
		
	endfunction : new

	task body();
			
		super.body(  );
		
		cpol0_cpha0_lsb0_h = apb_cpol0_cpha0_lsb0 :: type_id :: create( "cpol0_cpha0_lsb0_h" );
		
		spi_seq1_h = spi_seq1 :: type_id :: create( "spi_seq1_h" );
		
		apb_read_h = apb_read :: type_id ::create( "apb_read_h" );
                
                //sequence_handle.start( sequencer )
		cpol0_cpha0_lsb0_h.start( apb_seqrh );
		
		spi_seq1_h.start( spi_seqrh );
		
		#200;
		
		apb_read_h.start( apb_seqrh );
		
	endtask : body
	
endclass : cpol0_cpha0_lsb0_vseq


//cpol=0, cphase=0, lsbfe=1;
class cpol0_cpha0_lsb1_vseq extends vseqs;

	`uvm_object_utils( cpol0_cpha0_lsb1_vseq )
	
	function new( string name = "cpol0_cpha0_lsb1_vseq" );
	
		super.new( name );
		
	endfunction : new

	task body();
			
		super.body(  );
		
		cpol0_cpha0_lsb1_h = apb_cpol0_cpha0_lsb1 :: type_id :: create( "cpol0_cpha0_lsb1_h" );
		
		spi_seq1_h = spi_seq1 :: type_id :: create( "spi_seq1_h" );
		
		apb_read_h = apb_read :: type_id ::create( "apb_read_h" );

		cpol0_cpha0_lsb1_h.start( apb_seqrh );
		
		spi_seq1_h.start( spi_seqrh );
		
		#200;
		
		apb_read_h.start( apb_seqrh );
		
	endtask : body
	
endclass : cpol0_cpha0_lsb1_vseq


//cpol=0, cphase=1, lsbfe=0;
class cpol0_cpha1_lsb0_vseq extends vseqs;

	`uvm_object_utils( cpol0_cpha1_lsb0_vseq )
	
	function new( string name = "cpol0_cpha1_lsb0_vseq" );
	
		super.new( name );
		
	endfunction : new

	task body();
			
		super.body();
		
		cpol0_cpha1_lsb0_h = apb_cpol0_cpha1_lsb0 :: type_id :: create( "cpol0_cpha1_lsb0_h" );
		
		spi_seq1_h = spi_seq1 :: type_id :: create( "spi_seq1_h" );
		
		apb_read_h = apb_read :: type_id ::create( "apb_read_h" );

		cpol0_cpha1_lsb0_h.start( apb_seqrh );
		
		spi_seq1_h.start( spi_seqrh );
		
		#200;
		
		apb_read_h.start( apb_seqrh );
		
	endtask : body
	
endclass : cpol0_cpha1_lsb0_vseq


//cpol=0, cphase=1, lsbfe=1;
class cpol0_cpha1_lsb1_vseq extends vseqs;

	`uvm_object_utils( cpol0_cpha1_lsb1_vseq )
	
	function new( string name = "cpol0_cpha1_lsb1_vseq" );
	
		super.new( name );
		
	endfunction : new

	task body();
			
		super.body(  );
		
		cpol0_cpha1_lsb1_h = apb_cpol0_cpha1_lsb1 :: type_id :: create( "cpol0_cpha1_lsb1_h" );
		
		spi_seq1_h = spi_seq1 :: type_id :: create( "spi_seq1_h" );
		
		apb_read_h = apb_read :: type_id ::create( "apb_read_h" );

		cpol0_cpha1_lsb1_h.start( apb_seqrh );
		
		spi_seq1_h.start( spi_seqrh );
		
		#200;
		
		apb_read_h.start( apb_seqrh );
		
	endtask : body
	
endclass : cpol0_cpha1_lsb1_vseq


//cpol=1, cphase=0, lsbfe=0;
class cpol1_cpha0_lsb0_vseq extends vseqs;

	`uvm_object_utils( cpol1_cpha0_lsb0_vseq )
	
	function new( string name = "cpol1_cpha0_lsb0_vseq" );
	
		super.new( name );
		
	endfunction : new

	task body();
			
		super.body(  );
		
		cpol1_cpha0_lsb0_h = apb_cpol1_cpha0_lsb0 :: type_id :: create( "cpol1_cpha0_lsb0_h" );
		
		spi_seq1_h = spi_seq1 :: type_id :: create( "spi_seq1_h" );
		
		apb_read_h = apb_read :: type_id ::create( "apb_read_h" );

		cpol1_cpha0_lsb0_h.start( apb_seqrh );
		
		spi_seq1_h.start( spi_seqrh );
		
		#200;
		
		apb_read_h.start( apb_seqrh );
		
	endtask : body
	
endclass : cpol1_cpha0_lsb0_vseq


//cpol=1, cphase=0, lsbfe=1;
class cpol1_cpha0_lsb1_vseq extends vseqs;

	`uvm_object_utils( cpol1_cpha0_lsb1_vseq )
	
	function new( string name = "cpol1_cpha0_lsb1_vseq" );
	
		super.new( name );
		
	endfunction : new

	task body();
			
		super.body();
		
		cpol1_cpha0_lsb1_h = apb_cpol1_cpha0_lsb1 :: type_id :: create( "cpol1_cpha0_lsb1_h" );
		
		spi_seq1_h = spi_seq1 :: type_id :: create( "spi_seq1_h" );
		
		apb_read_h = apb_read :: type_id ::create( "apb_read_h" );

		cpol1_cpha0_lsb1_h.start( apb_seqrh );
		
		spi_seq1_h.start( spi_seqrh );
		
		#200;
		
		apb_read_h.start( apb_seqrh );
		
	endtask : body
	
endclass : cpol1_cpha0_lsb1_vseq


//cpol = 1, cphase = 1, lsbfe = 0;
class cpol1_cpha1_lsb0_vseq extends vseqs;

	`uvm_object_utils( cpol1_cpha1_lsb0_vseq )
	
	function new( string name = "cpol1_cpha1_lsb0_vseq" );
	
		super.new( name );
		
	endfunction : new

	task body();
			
		super.body();
		
		cpol1_cpha1_lsb0_h = apb_cpol1_cpha1_lsb0 :: type_id :: create( "cpol1_cpha1_lsb0_h" );
		
		spi_seq1_h = spi_seq1 :: type_id :: create( "spi_seq1_h" );
		
		apb_read_h = apb_read :: type_id ::create( "apb_read_h" );

		cpol1_cpha1_lsb0_h.start( apb_seqrh );
		
		spi_seq1_h.start( spi_seqrh );
		
		#200;
		
		apb_read_h.start( apb_seqrh );
		
	endtask : body
	
endclass : cpol1_cpha1_lsb0_vseq


//cpol =1, cphase=1, lsbfe =1;
class cpol1_cpha1_lsb1_vseq extends vseqs;

	`uvm_object_utils( cpol1_cpha1_lsb1_vseq )
	
	function new( string name ="cpol1_cpha1_lsb1_vseq" );
	
		super.new( name );
		
	endfunction : new

	task body();
			
		super.body();
		
		repeat( 1 ) 
		begin
		
		cpol1_cpha1_lsb1_h = apb_cpol1_cpha1_lsb1 :: type_id :: create( "cpol1_cpha1_lsb1_h" );
		
		spi_seq1_h = spi_seq1 :: type_id :: create( "spi_seq1_h" );
		
		apb_read_h = apb_read :: type_id ::create( "apb_read_h" );

		cpol1_cpha1_lsb1_h.start( apb_seqrh );
		
		spi_seq1_h.start( spi_seqrh );
		
		#200;
		
		apb_read_h.start( apb_seqrh );
		
		end
		
	endtask : body
	
endclass : cpol1_cpha1_lsb1_vseq


//low power mode 
class low_power_mode_vseq extends vseqs;

	`uvm_object_utils( low_power_mode_vseq )
	
	function new( string name ="low_power_mode_vseq" );
	
		super.new( name );
		
	endfunction: new

	task body();
			
		super.body();
		
		low_power_mode_seq_h = low_power_mode_seq :: type_id :: create( "low_power_mode_seq_h" );
		
		spi_seq1_h = spi_seq1 :: type_id :: create( "spi_seq1_h" );
		
		apb_read_h = apb_read :: type_id ::create( "apb_read_h" );

		low_power_mode_seq_h.start( apb_seqrh );
		
	//	spi_seq1_h.start( spi_seqrh );
	
		#200;
		
		apb_read_h.start( apb_seqrh );
		
	endtask : body
	
endclass : low_power_mode_vseq























		

