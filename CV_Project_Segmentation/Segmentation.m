function imgMarkup = Segmentation(Img_ip)


%% Masking
% Image to create mask from
I_leaf =  (imread(Img_ip));
%Crop Image by 20 percent
%crop_size = 25;


%imshow(I_leaf)

% [X Y Ch] = size(I_leaf);
% xmin = 1%X*(crop_size/200)
% ymin = 1%Y*(crop_size/200)
% width = Y*.5% - X*(crop_size/100)
% height = X*.5% - Y*(crop_size/100)

%[120, 125, 130, 115]

I_leaf = imcrop(I_leaf, [100, 75, 230, 215]);
%figure()
%imshow((I_leaf))

% [X Y Ch] = size(I_leaf);



%% Visualizing RGB channels 


R = I_leaf(:,:,1);
G = I_leaf(:,:,2);
B = I_leaf(:,:,3);

%figure()
%subplot(1,3,1)
%imshow(R/255)
%title('RED')

%subplot(1,3,2)
%imshow(G/255)
%title('GREEN')

%subplot(1,3,3)
%imshow(B/255)
%title('BLUE')

%% Green Value more than Blue & Red


% Val_GB = G > B;
% G_grt_B = (sum(sum(Val_GB))*100)/(Y*X);
% disp('% Green more than Blue')
% disp(G_grt_B)
% 
% Val_GR = G > R;
% G_grt_R = (sum(sum(Val_GR))*100)/(Y*X);
% disp('% Green more than Red')
% disp(G_grt_R)

%% Background
% White Background in grayscale (---testing---)
% [X Y Ch] = size(I_leaf);
% I_background = (zeros([X Y Ch]));
% 
% 
% I1 = I_background;
% I2 = B;%I_leaf;

%figure()
%imshow(I1)
%figure()
%imshow(I2)
%% Mask Generation
% BW1 = im2bw(I1);
% BW2 = im2bw(I2, .5);
% I = (BW2-BW1);
% I= bwareaopen(I,60);
% 
% figure()
% subplot(1,2,1)
% imagesc(I);
% 
% subplot(1,2,2)
% imshow(B);
% 
% [feature] = getFeaturesHOG(B);

Mask = B > 95;
Mask =  bwareaopen(1-Mask, 10);
%figure()
%imshow(Mask)

%figure()
IMM = bsxfun(@times, double(B), double(Mask));
%imagesc([double(B); IMM]);



Ellipse_Data = regionprops(Mask, 'Centroid', 'MajorAxisLength', 'MinorAxisLength', 'Orientation');


%%
MaskRGB = cat(3, Mask, Mask, Mask);
EllipseMask = MaskRGB;
seeds = zeros(numel(Ellipse_Data) * 2 + 1, 2);

while true
    randX = round((size(Mask, 2) - 4) * rand());
    randY = round((size(Mask, 1) - 4) * rand());
    portion = Mask(randY:(randY+2), randX:(randX+2))
    if all(all(portion == 0)) == 1
        seeds(1,:) = [randX+1, randY+1]
        break
    end
end
maskedILeaf = uint8(MaskRGB) .* I_leaf;
copyILeaf = I_leaf;

%Find a background point to select


for idx= 1:1:numel(Ellipse_Data)
    y0 = Ellipse_Data(idx, 1).Centroid(2);
    x0 = Ellipse_Data(idx, 1).Centroid(1);
    a0 = 1.14 * Ellipse_Data(idx, 1).MajorAxisLength/2;
    b0 = Ellipse_Data(idx, 1).MinorAxisLength/2;
    theta = -Ellipse_Data(idx, 1).Orientation;

    EllipseMask = draw_ellipse(y0, x0, a0, b0, theta, EllipseMask, [1, 1, 0]);
    f_r = sqrt(a0^2 + b0^2);
    fy1 = round(y0+(f_r*sind(theta)/4));
    fx1 = round(x0+(f_r*cosd(theta)/4));
    fy2 = round(y0-(f_r*sind(theta)/4));
    fx2 = round(x0-(f_r*cosd(theta)/4));
    
    EllipseMask(fy1, fx1, :) = [0, 1, 0];
    EllipseMask(fy2, fx2, :) = [0, 1, 0];
    Mask(fy1, fx1, :) = 0;
    Mask(fy2, fx2, :) = 0;
    
    copyILeaf(fy1, fx1, :) = [0, 255, 0];
    copyILeaf(fy2, fx2, :) = [0, 255, 0];
    
    seeds((idx - 1)*2 + 2, :) = [fx1, fy1];
    seeds((idx - 1)*2 + 3, :) =  [fx2, fy2];
    
end
labels = linspace(0, 2*numel(Ellipse_Data) , 2*numel(Ellipse_Data) + 1)';

Mask1 = [];
beta = 40.0;
[M, ~] = grady(maskedILeaf,Mask1,seeds,labels,beta);
[~,~,imgMarkup] = segoutput(im2double(I_leaf),im2double(M));
%imshow(imgMarkup)

% figure()
% subplot(1,2,1)
% imshow(copyILeaf)
% subplot(1,2,2)
% imshow(Mask)

end



