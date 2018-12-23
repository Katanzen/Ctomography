% kare = zeros(14,1);
% kare(5,1)= 1;
% kare(6,1)= 1;
% kare(7,1)= 1;
clc;
clear;
kare = ones(1,100);
% kare(5) = 1.2;
% kare(6) = 1.4;
% kare(7) = 1.2;
for j=40:50
    kare(j)=3.5;
end
for s=29:39
    kare(s)=2;
end
for c=51:61
    kare(c)=2;
end
% highPassF = [1,2,3,4,5,6,7,8,9,10,11,12,13,14];
for i=1:100
    if(i<=50)
        highPassF(i) = 50-i;
    else
        highPassF(i) = i-50;
    end
end
% for j=40:51
%     highPassF(j) = 0;
% end
plot(kare);
figure;
plot(real(fftshift(fft(kare))));
title("Fourier of kare");

% figure;
% plot(abs(ifft(fft(kare).*highPassF)));
really = abs(ifft((fft(kare)).*highPassF));
% plot((really));
figure;
plot(abs(fftshift(fft(really))));
title("fourier of highpassed");
