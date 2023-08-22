function [LUTrs_1, LUTis_1] = finalLUT(N_lut)
    LUTrs_1 = fi(zeros(64, 8), 1, N_lut, N_lut -4);
    for k = 0:7
        if mod(k, 2) == 0
            LUTrs_1(1:16, k + 1) = genFFT8LUTr(k, N_lut, N_lut -4);
        else
            LUTrs_1(:, k + 1) = genFFT8LUTr(k, N_lut, N_lut -4);
        end
    end
    LUTis_1 = fi(zeros(64, 8), 1, N_lut, N_lut -4);
    for k = 0:7
        if mod(k, 2) == 0
            LUTis_1(1:16, k + 1) = genFFT8LUTi(k, N_lut, N_lut -4);
        else
            LUTis_1(:, k + 1) = genFFT8LUTi(k, N_lut, N_lut -4);
        end
    end
end