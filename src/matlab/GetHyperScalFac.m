function scf = GetHyperScalFac(n)

scf = 1;
for it = 1:n
    scf = scf * sqrt(1 - 2^(-2*it));
end

end