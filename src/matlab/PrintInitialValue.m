function PrintInitialValue(x,sh,ch,ex,K,mode)
% This function will print values for initial block in verilog
% depending on MODE value
%
% If MODE = 1 - sh(x)
%           2 - ch(x)
%           3 - exp(x)
%           otherwise - nothing

fprintf("\n----- Input values: -----\n")
switch mode
    case 1
        for it = 1:length(x)
            if (it == 1)
                fprintf("#1.5 // sh(%.2f) = %.20f\n", x(it), sh(it));
            else
                fprintf("#2 // sh(%.2f) = %.20f\n", x(it), sh(it));
            end
            a = fi(1/K,1,32,16);
            fprintf("ix = 32'b%s; // x = %f\n", a.bin, a.double);
            fprintf("iy = 32'b0;\n");
            a = fi(x(it),1,32,16);
            fprintf("iz = 32'b%s; // z = %f\n\n", a.bin, a.double);
        end
    case 2
        for it = 1:length(x)
            if (it == 1)
                fprintf("#1.5 // ch(%.2f) = %.20f\n", x(it), ch(it));
            else
                fprintf("#2 // ch(%.2f) = %.20f\n", x(it), ch(it));
            end
            a = fi(1/K,1,32,16);
            fprintf("ix = 32'b%s; // x = %f\n", a.bin, a.double);
            fprintf("iy = 32'b0;\n");
            a = fi(x(it),1,32,16);
            fprintf("iz = 32'b%s; // z = %f\n\n", a.bin, a.double);
        end
    case 3
        for it = 1:length(x)
            ex(it) = sh(it) + ch(it);
            if (it == 1)
                fprintf("#1.5 // exp(%.2f) = %.20f\n", x(it), ex(it));
            else
                fprintf("#2 // exp(%.2f) = %.20f\n", x(it), ex(it));
            end
            a = fi(1/K,1,32,16);
            fprintf("ix = 32'b%s; // x = %f\n", a.bin, a.double);
            fprintf("iy = 32'b0;\n");
            a = fi(x(it),1,32,16);
            fprintf("iz = 32'b%s; // z = %f\n\n", a.bin, a.double);
        end
    otherwise
        fprintf("Selected non-output mode\n");
end
end