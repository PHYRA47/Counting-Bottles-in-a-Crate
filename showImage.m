function showImage(imgNum)
    %SHOWIMAGE Displays an image with detected bottles.
    %
    % This function reads an image based on the input number, preprocesses it,
    % detects bottles using the Hough Transform, and displays the image with
    % detected bottles highlighted. Images are expected to be in the 'images'
    % folder and named 'bottle_crate_xx.png', where 'xx' is the image number.
    %
    % Inputs:
    %   imgNum - An integer specifying the image number (1 to 24).
    %
    % Example usage:
    %   showImage(3); % Displays the third image with detected bottles.
    %
    % Dependencies: Requires a 'preprocess' function for image preprocessing.
    %
    
    % Check input range
    if imgNum < 1 || imgNum > 24
        error('Image number must be between 1 and 24.');
    end

    % Generate image filename
    fname = sprintf('images/bottle_crate_%02d.png', imgNum);
    
    % Read and preprocess image
    img = imread(fname);
    preImg = preprocess(img);

    % Detect bottles with Hough Transform
    [centers, radii] = imfindcircles(preImg, [15 40], ...
                                     'ObjectPolarity', 'bright', ...
                                     'Sensitivity', 0.88, ...
                                     'EdgeThreshold', 0.25);
    % Display setup
    figure; imshow(img); hold on;
    viscircles(centers, radii, 'Color', 'red');
    title(sprintf('Detected Bottles: %d', numel(radii)));
    hold off;
end
