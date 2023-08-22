function output = alpha(x, k)
realPart = 0;
imPart = 0;
for m = 0:3
    realPart = realPart + ((real(x(m + 1)) + (-1)^k * real(x(4 + m + 1))) * cos(m * k * pi / 4) + (imag(x(m + 1)) + (-1)^k * imag(x(4 + m + 1))) * sin(m * k * pi / 4));
    imPart = imPart + (-(real(x(m + 1)) + (-1)^k * real(x(4 + m + 1))) * sin(m * k * pi / 4) + (imag(x(m + 1)) + (-1)^k * imag(x(4 + m + 1))) * cos(m * k * pi / 4));
end
output = realPart + 1i * imPart;
end