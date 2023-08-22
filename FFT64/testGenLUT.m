global D_LUT_FFT8;
global N_LUT_FFT8;

D_LUT_FFT8 = 16;
N_LUT_FFT8 = 11;

fil = zeros(4, 1);
fil(1) = 2.123;
fil(2) = 1.230;
fil(3) = 2.654;
fil(4) = 4.236;
% lut = genLUT(fil, D_LUT_FFT8, N_LUT_FFT8);
lut = genLUT(fil, D_LUT_FFT8, N_LUT_FFT8);
display(lut.bin)