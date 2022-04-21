clear, clc

range = 1.5; % range of input args in function
pointsCount = 1000; % count of points in selected range
iterationsNumber = 16; % count of cordic_unit blocks
mode = 1; % mode of output for initial block


x = -range:(2*range/pointsCount):range;

sh_ideal = sinh(x);
ch_ideal = cosh(x);
ex_ideal = exp(x);

K = GetScalingFactor(iterationsNumber);

sh = zeros(1,length(x));
ch = zeros(1,length(x));
ex = zeros(1,length(x));

for it = 1:length(x)
    [sh(it),ch(it)] = CordicHyper(x(it),iterationsNumber);
end
ex = sh + ch;

% PrintInitialValue(x,sh,ch,ex,K,mode);
PlotGraphics(x,sh,sh_ideal,ch,ch_ideal,ex,ex_ideal);
% PrintLUTbinary();
% PrintResult(x,sh,'sinh');







