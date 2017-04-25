vidObj = VideoWriter('SegmentedResult.mp4', 'MPEG-4');
open(vidObj);

nFrames = 100;

for i = 1:1:nFrames
    im = strcat(sprintf('%6.6d', i), '.png');
    IMG =  Segmentation(im);
    %IMG = imread(im);
    imshow(imresize(IMG, 5))
    currFrame = getframe;
    writeVideo(vidObj,currFrame);
    %pause(.05);
end


close(vidObj)