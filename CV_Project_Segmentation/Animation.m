
for i = 1:1:700
    im = strcat(sprintf('%6.6d', i), '.png');
    IMG =  Segmentation(im);
    %IMG = imread(im);
    imshow(imresize(IMG, 10))
    pause(.05);
end