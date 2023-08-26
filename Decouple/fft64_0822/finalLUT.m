function [LUTrs_1, LUTis_1] = finalLUT()
    LUTrs_1 = zeros(64,8);
    for k = 0:7
        if mod(k, 2) == 0
            LUTrs_1(1:16, k + 1) = genFFT8LUTr(k);
        else
            LUTrs_1(:, k + 1) = genFFT8LUTr(k);
        end
    end
    LUTis_1 = zeros(64,8);
    for k = 0:7
        if mod(k, 2) == 0
            LUTis_1(1:16, k + 1) = genFFT8LUTi(k);
        else
            LUTis_1(:, k + 1) = genFFT8LUTi(k);
        end
    end
%     LUTrs_1 = fi(LUTrs_1, 1, N_lut, "RoundingMethod", "Floor");
%     LUTis_1 = fi(LUTis_1, 1, N_lut, "RoundingMethod", "Floor");
end