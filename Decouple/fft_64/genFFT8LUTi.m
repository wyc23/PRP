function FFT8LUTi = genFFT8LUTi(k, N, D)
    
    if mod(k, 2) == 0
        fil = zeros(4, 1);
    else
        fil = zeros(6, 1);
    end
    index = 1;
    for m = 0:3
        if abs(sin(m * k * pi / 4)) < 0.001
            continue
        end
        fil(index) = -sin(m * k * pi / 4);
        index = index + 1;
    end
    for m = 0:3
        if abs(cos(m * k * pi / 4)) < 0.001
            continue
        end
        fil(index) = cos(m * k * pi / 4);
        index = index + 1;
    end
    FFT8LUTi = genLUT(fil, N, D);
end