function output = myfft8(input)
factor = (2^15 - 1) / max(abs(input));
input = input .* factor;
output = zeros(1, 8);

w8 = exp(-2i * pi / 8);
w = w8 .^ (0:7);

    function filter = generateFilter(k)
        power = mod((0:3) .* k, 8);
        filter = w(power + 1);
    end

    function LUT = generateLUT(k)
        filter = generateFilter(k);
        LUT = zeros(16, 1);
        for m = 0:15
            bin = dec2bin(m, 4);
            sum = 0;
            for b = 1:4
                sum = sum + str2double(bin(b)) * filter(b);
            end
            LUT(m + 1) = sum;
        end
    end

try
    load LUTrs.mat;
catch
    LUTs = zeros(16, 8);
    for k = 0:7
        LUTs(:, k + 1) = generateLUT(k);
    end
    save LUTs.mat LUTs;
end
    

    function f = calcF(k)  
        data = dec2bin(int16(input), 16);
        f = 0;
        for t = 1:16
            index = bin2dec(data(1:4, t)');
            f = f + LUTs(index + 1, k + 1);
            index = bin2dec(data(5:8, t)');
            f = f + (-1)^k * LUTs(index + 1, k + 1);
            if t == 1
                f = f * (-2);
            elseif t == 16
                break;
            else
                f = f * 2;
            end
        end
    end

for k = 0:7
    output(k + 1) = calcF(k);
end
output = output ./ factor;
end