close all; clc; clear;
%%
original_ramp = [0 1:50 50:-1:1]; % Ram-Lak
filter_f = fftshift(transpose(ifft(original_ramp)));
display(norm(imag(filter_f))/norm(real(filter_f)))
plot(-50:50,fftshift(original_ramp))
title('Frequency Response Characteristics of Ram-Lak Filter')
xlabel('Frequency Bins')
ylabel('$|\mathcal{F}(filter)|$',Interpreter='latex')
%% 

w = window(@barthannwin, 100);
ramp = original_ramp .* [0 fftshift(w')];  
filter_f = fftshift(transpose(ifft(ramp)));
display(norm(imag(filter_f))/norm(real(filter_f)))
figure
plot(ramp(2:end))
set(gca,'XTickLabel',-50:10:50)
title({'Frequency Response Characteristics of','Bartlett Hann window-convolved Ram-Lak Filter'})
xlabel('Frequency Bins')
ylabel('$|\mathcal{F}(filter)|$',Interpreter='latex')
%%

w = window(@hamming, 100);
ramp = original_ramp .* [0 fftshift(w')]; 
filter_f = fftshift(transpose(ifft(ramp)));
display(norm(imag(filter_f))/norm(real(filter_f)))
figure
plot(ramp(2:end))
set(gca,'XTickLabel',-50:10:50)
title({'Frequency Response Characteristics of','Hamming window-convolved Ram-Lak Filter'})
xlabel('Frequency Bins')
ylabel('$|\mathcal{F}(filter)|$',Interpreter='latex')