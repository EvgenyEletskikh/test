function [sh, ch] = CordicHyper(arg, n)

k = 4;

atanhLUT = GetAtanhLUT(n);
K = GetHyperScalFac(n);


x = 1/K;
y = 0;
z = arg;
% d = sign(z(i))
for it = 1:n
    xtmp = bitsra(x,it);
    ytmp = bitsra(y,it);
    if (z < 0)
        x(:) = x - ytmp;        
        y(:) = y - xtmp;
        z(:) = z + atanhLUT(it);
    else
        x(:) = x + ytmp;        
        y(:) = y + xtmp;
        z(:) = z - atanhLUT(it);
    end
    
    if (it == k)        
        xtmp = bitsra(xtmp,it);
        ytmp = bitsra(ytmp,it);
        if (z < 0)
            x(:) = x - ytmp;        
            y(:) = y - xtmp;
            z(:) = z + atanhLUT(it);
        else
            x(:) = x + ytmp;        
            y(:) = y + xtmp;
            z(:) = z - atanhLUT(it);
        end
        
        k = 3*k + 1;
    end
end

sh = y;
ch = x;

end