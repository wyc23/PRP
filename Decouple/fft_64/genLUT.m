function LUT = genLUT(fil, N, D)
    bits = length(fil);
    lut = zeros(2 ^ bits, 1);
    for m = 0:2 ^ bits - 1
        lut(m + 1) = sum(str2num(dec2bin(m,bits)') .* fil);
    end
    LUT = fi(lut, 1, N, D);
end