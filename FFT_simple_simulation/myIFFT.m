function X = myIFFT(F)
w64 = exp(2i * pi / 64);
w8 = exp(2i * pi /8);

    function x1 = calcX1(k2, n2)
        x1 = 0;
        for n1 = 0:7
            x1 = x1 + F(n1 * 8 + n2 + 1) * w8^(n1 * k2);
        end
        x1 = x1 * w64^(n2 * k2);
    end

    function x = calcX(k2, k1)
        x = 0;
        for n2 = 0:7
            x = x + X1(k2 * 8 + n2 + 1) * w8^(n2 * k1);
        end
    end

X1 = zeros(1, 64);
for k2 = 0:7
    for n2 = 0:7
        X1(k2 * 8 + n2 + 1) = calcX1(k2, n2);
    end
end

X = zeros(1, 64);
for k2 = 0:7
    for k1 = 0:7
        X(k1 * 8 + k2 + 1) = calcX(k2, k1);
    end
end
X = X ./ 64;
end