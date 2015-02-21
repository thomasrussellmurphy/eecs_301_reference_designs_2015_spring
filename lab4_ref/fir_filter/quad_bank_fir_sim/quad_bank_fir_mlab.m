%
%THIS IS A WIZARD GENERATED FILE. DO NOT EDIT THIS FILE!
%
%---------------------------------------------------------------------------------------------------------
%This is a filter with fixed coefficients.
%This Model Only Support Single Channel Input Data.
%Please input:
%data vector: 		stimulation(1:n)

%    This Model Only Support FIR_WIDTH to 51 Bits

%FILTER PARAMETER
%Input Data Type :	Signed Binary
%Input Data Width: 12
%Interpolation Factor: 1
%Decimation Factor: 1
%FIR Width (Full Calculation Width Before Output Width Adjust) :35
%-----------------------------------------------------------------------------------------------------------
%MegaWizard Scaled Coefficient Values

 function  output = quad_bank_fir_mlab(stimulation, bank, output)
 coef_matrix_in= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8191,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;-3,-2,-3,-4,-5,-6,-8,-10,-12,-14,-17,-19,-22,-26,-29,-33,-37,-40,-44,-48,-52,-56,-60,-63,-66,-68,-70,-71,-71,-71,-69,-66,-62,-56,-49,-40,-29,-17,-3,12,30,50,72,96,121,148,176,206,237,268,300,333,365,397,428,459,487,513,537,558,576,589,598,603,602,596,584,566,541,510,472,428,376,318,254,183,106,24,-63,-154,-249,-347,-447,-548,-649,-749,-846,-940,-1030,-1113,-1189,-1256,-1314,-1360,-1394,-1414,-1419,-1408,-1381,-1336,-1272,-1189,-1086,-963,-820,-656,-472,-268,-45,197,458,736,1030,1339,1661,1995,2339,2691,3049,3411,3775,4138,4499,4855,5204,5543,5870,6183,6480,6759,7018,7254,7467,7655,7816,7950,8054,8130,8175,8190,8175,8130,8054,7950,7816,7655,7467,7254,7018,6759,6480,6183,5870,5543,5204,4855,4499,4138,3775,3411,3049,2691,2339,1995,1661,1339,1030,736,458,197,-45,-268,-472,-656,-820,-963,-1086,-1189,-1272,-1336,-1381,-1408,-1419,-1414,-1394,-1360,-1314,-1256,-1189,-1113,-1030,-940,-846,-749,-649,-548,-447,-347,-249,-154,-63,24,106,183,254,318,376,428,472,510,541,566,584,596,602,603,598,589,576,558,537,513,487,459,428,397,365,333,300,268,237,206,176,148,121,96,72,50,30,12,-3,-17,-29,-40,-49,-56,-62,-66,-69,-71,-71,-71,-70,-68,-66,-63,-60,-56,-52,-48,-44,-40,-37,-33,-29,-26,-22,-19,-17,-14,-12,-10,-8,-6,-5,-4,-3,-2,-3;65,46,55,56,47,27,-6,-51,-104,-161,-214,-255,-276,-269,-230,-155,-49,82,229,376,507,605,654,644,569,430,236,4,-245,-488,-698,-852,-932,-928,-839,-672,-446,-184,84,333,536,674,735,720,637,505,345,183,44,-54,-101,-95,-44,35,123,195,230,211,132,-4,-185,-389,-588,-752,-856,-881,-817,-668,-449,-186,91,348,554,686,732,695,587,434,268,121,22,-9,34,145,301,471,616,699,689,567,332,0,-396,-810,-1189,-1481,-1643,-1650,-1494,-1193,-782,-315,146,542,824,959,942,790,549,278,46,-79,-49,163,550,1073,1658,2210,2621,2791,2637,2113,1219,3,-1432,-2948,-4378,-5548,-6299,-6506,-6099,-5073,-3492,-1487,760,3032,5100,6754,7822,8190,7822,6754,5100,3032,760,-1487,-3492,-5073,-6099,-6506,-6299,-5548,-4378,-2948,-1432,3,1219,2113,2637,2791,2621,2210,1658,1073,550,163,-49,-79,46,278,549,790,942,959,824,542,146,-315,-782,-1193,-1494,-1650,-1643,-1481,-1189,-810,-396,0,332,567,689,699,616,471,301,145,34,-9,22,121,268,434,587,695,732,686,554,348,91,-186,-449,-668,-817,-881,-856,-752,-588,-389,-185,-4,132,211,230,195,123,35,-44,-95,-101,-54,44,183,345,505,637,720,735,674,536,333,84,-184,-446,-672,-839,-928,-932,-852,-698,-488,-245,4,236,430,569,644,654,605,507,376,229,82,-49,-155,-230,-269,-276,-255,-214,-161,-104,-51,-6,27,47,56,55,46,65;8,-28,12,14,5,-1,-5,-6,-5,-2,0,2,4,4,3,2,0,-2,-3,-4,-4,-2,0,1,4,5,5,4,2,0,-3,-6,-7,-6,-4,0,3,6,8,8,6,2,-2,-6,-10,-11,-9,-5,0,6,11,13,13,9,3,-4,-11,-16,-17,-14,-8,0,10,17,21,20,14,4,-7,-17,-24,-26,-21,-11,1,15,26,31,30,20,6,-10,-26,-36,-39,-32,-17,2,23,39,47,45,31,9,-16,-39,-55,-59,-49,-26,3,35,60,73,70,49,15,-24,-62,-88,-95,-80,-44,4,57,101,125,122,89,30,-41,-112,-165,-185,-162,-95,4,121,230,302,315,249,99,-127,-411,-720,-1017,-1263,-1426,8191,-1426,-1263,-1017,-720,-411,-127,99,249,315,302,230,121,4,-95,-162,-185,-165,-112,-41,30,89,122,125,101,57,4,-44,-80,-95,-88,-62,-24,15,49,70,73,60,35,3,-26,-49,-59,-55,-39,-16,9,31,45,47,39,23,2,-17,-32,-39,-36,-26,-10,6,20,30,31,26,15,1,-11,-21,-26,-24,-17,-7,4,14,20,21,17,10,0,-8,-14,-17,-16,-11,-4,3,9,13,13,11,6,0,-5,-9,-11,-10,-6,-2,2,6,8,8,6,3,0,-4,-6,-7,-6,-3,0,2,4,5,5,4,1,0,-2,-4,-4,-3,-2,0,2,3,4,4,2,0,-2,-5,-6,-5,-1,5,14,12,-28,8];
 INTER_FACTOR  = 1;
 DECI_FACTOR  =  1;
 MSB_RM  = 0;
 MSB_TYPE  = 1;
 LSB_RM  = 0;
 LSB_TYPE  = 0;
 FIR_WIDTH  = 35 + MSB_RM + LSB_RM;
 OUT_WIDTH  = 35 ;  %35
 DATA_WIDTH = 12;
 BANKCOUNT = 4;
 data_type = 1;

  
 % check size of inputs. 
 [DX,DY] = size(stimulation);
 [CX,CY] = size(coef_matrix_in); 
 if (CY ~= DY * INTER_FACTOR) 
    fprintf('WARNING : coef_matrix size and input data size is not match\n'); 
 end 

 %fill coef_matrix to length of data with the latest coef set 
 if (CY < DY * INTER_FACTOR) 
   %for i= CX +1:DY * INTER_FACTOR 
   for i= 1:DY * INTER_FACTOR 
     if (BANKCOUNT > 1)
       coef_matrix(i,:) = coef_matrix_in(bank(i)+1,:); 
     else
       coef_matrix(i,:) = coef_matrix_in(1,:); 
     end
   end 
 end
	  
 % check if input is integer 
       	int_sti=round(stimulation); 
	    T = (int_sti ~= stimulation); 
	    if (max(T)~=0) 
	        fprintf('WARNING : Integer Input Expected: Rounding Fractional Input to Nearest Integer...\n'); 
	    end 
	     
	    %Input overflow check 
	    switch  data_type 
	    case 1 
	        %set max/min for signed 
	        maxdat = 2^(DATA_WIDTH-1)-1; 
	        mindat = -maxdat-1; 
	    case 2 
	        %set max/min for unsigned 
	        maxdat = 2^DATA_WIDTH-1; 
	        mindat = 0; 
	    end 

	    if(data_type == 2)
	    	if(abs(coef_matrix) == coef_matrix)
	    		FIR_WIDTH = FIR_WIDTH +1;
	    	end
	    end

	    %Saturating Input Value 
	    a=find(int_sti>maxdat); 
	    b=find(int_sti<mindat); 
	    if (~isempty(a)|~isempty(b)) 
	 	    fprintf('WARNING : Input Amplitude Exceeds MAXIMUM/MINIMUM allowable values - saturating input values...\n'); 
	            lena = length (a); 
	            lenb = length (b); 
	            for i =1:lena 
	        	    fprintf('%d > %d \n', int_sti(a(i)), maxdat); 
			        int_sti(a(i)) = maxdat; 
		        end 
		    for i =1:lenb 
			    fprintf('%d < %d \n', int_sti(b(i)), mindat); 
			    int_sti(b(i)) = mindat; 
		    end 
	    end 
         
	    % Add interpolation 
   	    inter_sti = zeros(1, INTER_FACTOR * length(int_sti)); 
	    inter_sti(1:INTER_FACTOR:INTER_FACTOR * length(int_sti)) = int_sti; 
 
         
        for i = 1 : DY *INTER_FACTOR 
    	    coef_current = coef_matrix(i,:); 
            output_temp(i) = simp_adaptive (inter_sti, coef_current, i); 
        end 
	% Truncate output 
	len1 = length(output_temp); 
	 
	    switch  LSB_TYPE 
	    case 0 
	        %truncate 
            out_dec = bi_trunc_lsb(output_temp,LSB_RM,FIR_WIDTH); 
	    case 1 
	        %round 
            out_dec = bi_round(output_temp,LSB_RM, FIR_WIDTH); 
	    end 
         
 	    switch  MSB_TYPE 
	    case 0 
	        %truncate 
            out_dec = bi_trunc_msb(out_dec,MSB_RM,FIR_WIDTH-LSB_RM); 
	    case 1 
	        %round 
            out_dec = bi_satu(out_dec,MSB_RM, FIR_WIDTH-LSB_RM); 
	    end 
 	    
    	% choose decimation output in phase=DECI_FACTOR-1  
     	if(DECI_FACTOR == 1) 
     		output = out_dec; 
     	else 
        output = out_dec(1:DECI_FACTOR:len1);

	 	end  
 	       
  	function[output, outindex] = simp_adaptive (int_sti, coef_current, data_index, output) 
	%Simulation is the whole input sequence 
	%coef_current is the current coefficient set 
	%data_index gives the last data to use 
	%outputs are the sum of input and coef multiplication 
	%outindex is the next data_index 
    
	sti_current = zeros(length(coef_current),1); 
	 
	data_length = length(int_sti); 
	 
	%Check data index 
	if (data_index > data_length) 
		fprintf('ERROR: DATA INDEX IS LARGER THAN DATA LENGTH!!!\n'); 
		return; 
	end 
	for i = 1: length(coef_current) 
	   if ((data_index -i+1)>0 & (data_index - i+1)<=data_length) 
	      sti_current(i,1) = int_sti(data_index - i+1); 
	   end 
	end 
	 
	outindex= data_index+1; 
	output = coef_current * sti_current; 
	% end of function simp_adaptive 
 
	function output = bi_round(data_in,LSB_RM,ORI_WIDTH, output) 
	% LSB_RM is the bit to lose in LSB 
	% ORI_WIDTH is the original data width

	data = round (data_in / 2^LSB_RM);

	output = bi_satu(data,0,ORI_WIDTH - LSB_RM); 
	%end of function bi_trunc_lsb 
	 
	function output = bi_trunc_lsb(data_in,LSB_RM,ORI_WIDTH, output) 
	% LSB_RM is the bit to lose in LSB 
	% ORI_WIDTH is the original data width 
	%2's complement system 
	output = bitshift(2^ORI_WIDTH*(data_in<0) + data_in, -LSB_RM) - 2^(ORI_WIDTH-LSB_RM) *(data_in<0); 
	% end of function bi_round 
	 
	function output = bi_trunc_msb(data_in,MSB_RM,ORI_WIDTH, output) 
	% MSB_RM is the bit to lose in LSB 
	% ORI_WIDTH is the original data width 
	%2's complement system 
	data = 2^ORI_WIDTH * (data_in < 0)+ data_in; 
	erase_num = 2^(ORI_WIDTH - MSB_RM) - 1; 
	data = bitand(data, erase_num); 
	output = data - 2^(ORI_WIDTH - MSB_RM)*(bitget(data,ORI_WIDTH - MSB_RM)); 
	%end of bi_trunc_msb 
	 
	function output = bi_satu(data_in,MSB_RM,ORI_WIDTH, output) 
	% MSB_RM is the bit to lose in LSB 
	% ORI_WIDTH is the original data width 
	%2's complement system 
	maxdat = 2^(ORI_WIDTH - MSB_RM - 1)-1; 
	mindat = 2^(ORI_WIDTH - MSB_RM - 1)*(-1); 
	data_in(find(data_in > maxdat)) = maxdat; 
	data_in(find(data_in < mindat)) = mindat; 
	output = data_in; 
	%end of bi_satu  


