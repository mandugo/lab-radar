close all
clear 

% Parameters
samplerate = 44100;
c = 3e8;
fc = 2.435e9;
fSamp = 20e3;
BW = 95e6;
lambda = c/fc;

period = 110;
TimePeriod = period/samplerate;
maxR = fSamp*c*TimePeriod/(2*BW);
maxV = lambda/(4*TimePeriod);

%%
dataMatrix = radarLabDataLoader('C:\Users\mandus\Desktop\Corsa2_corner.wav','resample');

[N,M] = size(dataMatrix);

window = true;

if window
    Hn = hamming(N);
    Hm = hamming(M);
else
    Hn = ones(N,1);
    Hm = ones(M,1);
end

ham2D = repmat(Hn,1,M).*repmat(Hm.',N,1);
dataMatrix = dataMatrix.*ham2D;

x = linspace(0,maxR,4*M);
y = linspace(-maxV,maxV,4*N);

compresso_temp_1 = ifft(dataMatrix,4*M,2); 
image = fftshift(fft(compresso_temp_1,4*N),1);

figure
imagesc(x,y,10*log10(abs(image(:,1:end/2))/max(max(abs(image(:,1:end/2))))))
colorbar
colormap jet
caxis([-70,-30])
sgtitle('resample')
xlabel('Range')
ylabel('Doppler')

% figure
% plot(dataMatrix(2,:))
% grid on

%%
dataMatrix = radarLabDataLoader('C:\Users\mandus\Desktop\Corsa2_corner.wav','trunc');

[N,M] = size(dataMatrix);

window = true;

if window
    Hn = hamming(N);
    Hm = hamming(M);
else
    Hn = ones(N,1);
    Hm = ones(M,1);
end

ham2D = repmat(Hn,1,M).*repmat(Hm.',N,1);
dataMatrix = dataMatrix.*ham2D;

x = linspace(0,maxR,4*M);
y = linspace(-maxV,maxV,4*N);

compresso_temp_1 = ifft(dataMatrix,4*M,2); 
image = fftshift(fft(compresso_temp_1,4*N),1);

% figure
% plot(dataMatrix(2,:))
% grid on

figure
imagesc(x,y,10*log10(abs(image(:,1:end/2))/max(max(abs(image(:,1:end/2))))))
colorbar
colormap jet
caxis([-70,-30])
sgtitle('trunc')
xlabel('Range')
ylabel('Doppler')
