re = rand(8, 1);
im = rand(8, 1);


fhat = fft(re + 1i * im);
reHAT = real(fhat);
imHAT = imag(fhat);

[rehat, imhat] = myfft8(fi(re, 1, 16, 11), fi(im, 1, 16, 11), 16, 32);