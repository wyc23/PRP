w8 = exp(-2i * pi / 8);
x = rand(1, 8) + 1i * rand(1, 8);
expected = zeros(1, 8);
actual = zeros(1, 8);
for k = 0:7
    for m = 0:7
    expected(k + 1) = expected(k + 1) + x(m + 1) * w8^(m * k);
    end
    actual(k + 1) = alpha(x, k);
end
plot((actual - expected) .* conj(actual - expected))
