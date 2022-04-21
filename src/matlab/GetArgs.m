function [x, y] = GetArgs(arg, n)

K = 1;

for it = 1:n
    K = K * sqrt(1-2^(-2*it));
end

x = (arg + 0.25)/K;
y = (arg - 0.25)/K;

x = fi(x,1,32,16);
y = fi(y,1,32,16);

x = x.bin;
y = y.bin;
end