function PrintLUTbinary()
    fprintf("\n----- atanh(2^(-2i) lookup-table -----\n");
    atanhLUT = GetAtanhLUT(16);
    for it=1:16
        a = fi(atanhLUT(it),1,32,16);
        fprintf("atanhLUT[%d] = 32'b%s;\n",it-1, a.bin)
    end    
end