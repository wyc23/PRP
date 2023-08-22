clc, clear

re = rand(64, 1);
im = rand(64, 1);

fhat = fft(re + 1i * im);
reHAT = real(fhat);
imHAT = imag(fhat);

[rehat, imhat] = myfft64(fi(re, 1, 16), fi(im, 1, 16), 15);

RMSEr = sqrt(sum((rehat.double - reHAT) .^ 2) / 64);
RMSEi = sqrt(sum((imhat.double - imHAT) .^ 2) / 64);


% re = rand(8, 1);
% im = rand(8, 1);
% 
% fhat = fft(re + 1i * im);
% reHAT = real(fhat);
% imHAT = imag(fhat);
% 
% [rehat, imhat] = myfft8(fi(re, 1, 16), fi(im, 1, 16), 16, 32);


% re = rand();
% im = rand();
% 
% aa = (re + 1i * im) * exp(-2i * 5 * 6 * pi / 64);
% 
% [RE, IM] = twiddle(fi(re, 1, 32, 31), fi(im, 1, 32, 31), 5, 6, 32)