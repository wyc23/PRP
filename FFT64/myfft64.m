function [outputr, outputi] = myfft64(inputr, inputi, D)

    inputr = fi(inputr, 1, 16, D);
    inputi = fi(inputi, 1, 16, D);

    global N_LUT_FFT8_1;
    global N_LUT_FFT8_2;
    global N_LUT_TWIDDL;
    global N_MID1;
    global N_MID2;
    global D_LUT_FFT8_1;
    global D_LUT_FFT8_2;
    global D_LUT_TWIDDLE;
    global D_MID1;
    global D_MID2;


    myVariable_1 = 18;
    myVariable_2 = 18;

    N_LUT_FFT8_1 = myVariable_1;
    N_LUT_FFT8_2 = 18;
    N_LUT_TWIDDL = myVariable_2;
    N_MID1 = myVariable_1;
    N_MID2 = myVariable_2;
    D_LUT_FFT8_1 = myVariable_1 - 4;
    D_LUT_FFT8_2 = 14;
    D_LUT_TWIDDLE = myVariable_2 - 4;
    D_MID1 = myVariable_1 - 4;
    D_MID2 = myVariable_2 - 4;

    mid1r = zeros(64, 1);
    mid1i = zeros(64, 1);

    for n_2 = 0:7
        [mid1r(n_2 + 1:8:64), mid1i(n_2 + 1:8:64)] = myfft8_1(inputr(n_2 + 1:8:64), inputi(n_2 + 1:8:64), 16, N_MID1);
    end
    mid1r = fi(mid1r, 1, N_MID1, D_MID1);
    mid1i = fi(mid1i, 1, N_MID1, D_MID1);

    % mid1r = fi(mid1r, 1, N_MID1);
    % mid1i = fi(mid1i, 1, N_MID1);

    mid2r = zeros(64, 1);
    mid2i = zeros(64, 1);

    for k_2 = 0:7
        for n_2 = 0:7
            [mid2r(8 * k_2 + n_2 + 1), mid2i(8 * k_2 + n_2 + 1)] = twiddle(mid1r(8 * k_2 + n_2 + 1), mid1i(8 * k_2 + n_2 + 1), n_2, k_2, N_MID2);
        end
    end

    mid2r = fi(mid2r, 1, N_MID2, D_MID2);
    mid2i = fi(mid2i, 1, N_MID2, D_MID2);

    % mid2r = fi(mid2r, 1, N_MID2);
    % mid2i = fi(mid2i, 1, N_MID2);

    % for testing

    % correctr = zeros(64, 1);
    % correcti = zeros(64, 1);

    % rree = inputr.double;
    % iimm = inputi.double;

    % X = rree + 1i * iimm;

    % function output = alpha(x, k)
    %     realPart = 0;
    %     imPart = 0;
    %     for m = 0:3
    %         realPart = realPart + ((real(x(m + 1)) + (-1)^k * real(x(4 + m + 1))) * cos(m * k * pi / 4) + (imag(x(m + 1)) + (-1)^k * imag(x(4 + m + 1))) * sin(m * k * pi / 4));
    %         imPart = imPart + (-(real(x(m + 1)) + (-1)^k * real(x(4 + m + 1))) * sin(m * k * pi / 4) + (imag(x(m + 1)) + (-1)^k * imag(x(4 + m + 1))) * cos(m * k * pi / 4));
    %     end
    %     output = realPart + 1i * imPart;
    % end

    % w64 = exp(-2i * pi / 64);
    % function x1 = calcX1(k2, n2)
    %     x1 = alpha(X(n2 + 1:8:64), k2);
    %     x1 = x1 * w64^(n2 * k2);
    % end

    % X1 = zeros(64, 1);
    % for k2 = 0:7
    %     for n2 = 0:7
    %         X1(k2 * 8 + n2 + 1) = calcX1(k2, n2);
    %     end
    % end

    % correctr = real(X1);
    % correcti = imag(X1);

    % end of the test

    outputr = zeros(64, 1);
    outputi = zeros(64, 1);

    for k_2 = 0:7
        [outputr(k_2 + 1:8:64), outputi(k_2 + 1:8:64)] = myfft8_2(mid2r(8 * k_2 + 1 : 8 * k_2 + 8), mid2i(8 * k_2 + 1 : 8 * k_2 + 8), N_MID2, 32);
    end

    outputr = fi(outputr, 1, 16);
    outputi = fi(outputi, 1, 16);
end