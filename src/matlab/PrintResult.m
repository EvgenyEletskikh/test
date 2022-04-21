function PrintResult(x,func,func_name)
% This function will display results of function FUNC in format
% func_name(x) = func;

    fprintf("\n----- CORDIC computations results for %s(x) -----\n",func_name);
    for it = 1:length(x)
        fprintf("%s(%2.3f) = %.20f;\n",func_name, x(it), func(it));
    end
end