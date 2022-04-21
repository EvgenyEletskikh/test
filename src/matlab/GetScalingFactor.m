function K = GetScalingFactor(niters)
    K = 1;
    for it=1:niters
        K = K * sqrt(1 - 2^(-2*it));
    end
end