function atanhLUT = GetAatanhLUT(n)

atanhLUT = zeros(1,n);

for it = 1:n
    atanhLUT(it) = atanh(2^(-it));
end

end


