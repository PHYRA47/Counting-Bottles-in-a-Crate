function preImg = preprocess(img)
    % Apply median filter to reduce noise
    filtImg = medfilt2(img, [3 3]);
    
    % Enhance contrast using top-hat filtering
    preImg = imtophat(filtImg, strel('disk', 30));
end
