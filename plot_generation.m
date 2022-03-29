
ramp = [0 1:50 50:-1:1]; % Ram-Lak
filter_f = fftshift(transpose(ifft(ramp)));
display(norm(imag(filter_f))/norm(real(filter_f)))
plot(fftshift(ramp))

%% 

w = window(@barthannwin, 100);
ramp = [0 fftshift(w')];  
filter_f = fftshift(transpose(ifft(ramp)));
display(norm(imag(filter_f))/norm(real(filter_f)))
figure
plot(ramp)


%%

w = window(@hamming, 100);
ramp = [0 fftshift(w')]; 
filter_f = fftshift(transpose(ifft(ramp)));
display(norm(imag(filter_f))/norm(real(filter_f)))
figure
plot(ramp)

