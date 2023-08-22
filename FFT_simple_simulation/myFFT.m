function F = myFFT(X)
w64 = exp(-2i * pi / 64);
w8 = exp(-2i * pi /8);

    function x1 = calcX1(k2, n2)
        x1 = alpha(X(n2 + 1:8:64), k2);
        x1 = x1 * w64^(n2 * k2);
    end

    function f = calcF(k2, k1)
        f = alpha(X1(k2 * 8 + 1:k2 * 8 + 8), k1);
    end

X1 = zeros(1, 64);
for k2 = 0:7
    for n2 = 0:7
        X1(k2 * 8 + n2 + 1) = calcX1(k2, n2);
    end
end

F = zeros(1, 64);
for k2 = 0:7
    for k1 = 0:7
        F(k1 * 8 + k2 + 1) = calcF(k2, k1);
    end
end
end