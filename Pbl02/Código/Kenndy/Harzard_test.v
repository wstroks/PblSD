module harzard_test();
  
  reg [4:0] IFID_rs, IFID_rt, IDEX_rt;
    reg IDEX_memRead, EXMEM_iord, branchFWD;
    wire PCWrite, IFIDWrite, HazMuxCtrl;
    
    Harzard uut(.IFID_rs(IFID_rs), .IFID_rt(IFID_rt), .IDEX_rt(IDEX_rt),.IDEX_memRead(IDEX_memRead),.EXMEM_iord(EXMEM_iord), .branchFWD(branchFWD),.PCWrite(PCWrite), .IFIDWrite(IFIDWrite), .HazMuxCtrl(HazMuxCtrl));
initial begin
  
IFID_rs=10;IFID_rt =11; IDEX_rt = 12; IDEX_memRead=1; EXMEM_iord=0; branchFWD=1;
$display("IFID_rs = %d, IFID_rt = %d, IDEX_rt = %d,IDEX_memRead = %d,EXMEM_iord = %d, branchFWD = %d, PCWrite = %d, IFIDWrite = %d, HazMuxCtrl = %d",IFID_rs, IFID_rt, IDEX_rt,IDEX_memRead ,EXMEM_iord, branchFWD , PCWrite , IFIDWrite, HazMuxCtrl);
  #1;

IFID_rs=10;IFID_rt =11; IDEX_rt = 12; IDEX_memRead=0; EXMEM_iord=0; branchFWD=0;
$display("IFID_rs = %d, IFID_rt = %d, IDEX_rt = %d,IDEX_memRead = %d,EXMEM_iord = %d, branchFWD = %d, PCWrite = %d, IFIDWrite = %d, HazMuxCtrl = %d",IFID_rs, IFID_rt, IDEX_rt,IDEX_memRead ,EXMEM_iord, branchFWD , PCWrite , IFIDWrite, HazMuxCtrl);
#1;


end 
  
  
  
endmodule
