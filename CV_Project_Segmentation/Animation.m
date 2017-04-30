vidObj = VideoWriter('SegmentedResult_800.mp4', 'MPEG-4');
open(vidObj);

nFrames = 800;

for i = 21:1:nFrames
    im = strcat(sprintf('%6.6d', i), '.png');
    I_leaf =  (imread(im));
    
    %Crop Image by 20 percent
    %crop_size = 30;
    
    
%     %imshow(I_leaf)
%     [X Y Ch] = size(I_leaf);
%     xmin = X*(crop_size/200)
%     ymin = Y*(crop_size/200)
%     width = X - X*(crop_size/100)
%     height = Y - Y*(crop_size/100)
    
    %I_leaf = imcrop(I_leaf, [ymin, xmin, height, width]);
    I_leaf = imcrop(I_leaf, [0,0, 435, 230]);
    %I_leaf = imcrop(I_leaf, [120, 125, 130, 115]);
    %imshow(imresize(I_leaf, 10))
    
    B = I_leaf(:,:,3);
    
    Mask = B > 80;
    Mask =  bwareaopen(1-Mask, 30);
    IMM = bsxfun(@times, double(B), double(Mask)) > 0;
    
    % Generate seeds
    if i == 21
        [Ellipse_Data, maskedILeaf, seeds] =  getSeeds(I_leaf);
    end
    
    [imgMarkup, M] = SegmentationRandomWalker(seeds, I_leaf);
    M = M .* IMM;
    
    imshow(imresize(imgMarkup, 3))
    currFrame = getframe;
    writeVideo(vidObj,currFrame);
    %xlabel(num2str(i));
    
    newSeeds = zeros(size(seeds));
    newSeeds(1,:) = seeds(1,:);
    for seedIndex = 2:length(seeds)
        leafIndex = seedIndex - 1;
        [posY, posX] = find(M == leafIndex);
        if isempty(posY) || isempty(posX)
            newSeeds(seedIndex, :) = seeds(seedIndex, :);
        else
            newSeeds(seedIndex, :) = [mean(posX), mean(posY)];
        end
    end
    seeds = round(newSeeds)
    pause(1/14);
end


close(vidObj)