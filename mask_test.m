%% Masking
% Image to create mask from
I_leaf =  (imread('000835.png'));
%Crop Image by 20 percent
crop_size = 25;


imshow(I_leaf)
[X Y Ch] = size(I_leaf)
xmin = 1%X*(crop_size/200)
ymin = 1%Y*(crop_size/200)
width = Y*.5% - X*(crop_size/100)
height = X*.5% - Y*(crop_size/100)
I_leaf = imcrop(I_leaf, [xmin ymin width height]);
figure()
imshow((I_leaf))

[X Y Ch] = size(I_leaf);



%% Visualizing RGB channels 


R = I_leaf(:,:,1);
G = I_leaf(:,:,2);
B = I_leaf(:,:,3);

figure()
subplot(1,3,1)
imshow(R/255)
title('RED')

subplot(1,3,2)
imshow(G/255)
title('GREEN')

subplot(1,3,3)
imshow(B/255)
title('BLUE')

%% Green Value more than Blue & Red
Val_GB = G > B;
G_grt_B = (sum(sum(Val_GB))*100)/(Y*X);
disp('% Green more than Blue')
disp(G_grt_B)

Val_GR = G > R;
G_grt_R = (sum(sum(Val_GR))*100)/(Y*X);
disp('% Green more than Red')
disp(G_grt_R)

%% Background
% White Background in grayscale (---testing---)
[X Y Ch] = size(I_leaf);
I_background = (ones([X Y Ch]));


I1 = I_background;
I2 = B;%I_leaf;

figure()
imshow(I1)
figure()
imshow(I2)
%% Mask Generation
BW1 = im2bw(I1);
BW2 = im2bw(I2, .55);
I = (BW2-BW1);
I= bwareaopen(I,60);

figure()
subplot(1,1,1)
imagesc(I);

%subplot(1,2,2)
%imshow(B.*I);





