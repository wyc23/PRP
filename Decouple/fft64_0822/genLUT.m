function LUT = genLUT(fil)
    bits = length(fil);
    LUT = zeros(2 ^ bits, 1);
    for m = 0:2 ^ bits - 1
        LUT(m + 1) = sum(str2num(dec2bin(m,bits)') .* fil);
    end
end