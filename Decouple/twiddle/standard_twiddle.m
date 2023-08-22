function output = standard_twiddle(input)
    output = zeros(64, 1);
    for n = 0:7
        for k = 0:7
            output(8*n+k+1) = input(8*n+k+1) * exp(-1i*2*pi*n*k/64);
        end
    end
end