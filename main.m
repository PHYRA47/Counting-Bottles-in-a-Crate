% Group Members: Fromsa Teshome Negasa, Peter Samaha

clear; close all; clc; 

% Initialize results table
results = table([],[], 'VariableNames', {'Image', 'DetectedBottles'});

% For animation
fig = figure;

% Process images
for i = 1:24
    fname = sprintf('images/bottle_crate_%02d.png', i); % Filename
    img = imread(fname); % Read image
    
    % Preprocess image
    preImg = preprocess(img);
    
    % Detect circles using Hough Transform
    [centers, radii] = imfindcircles(preImg, [15 40], ...
                                     'ObjectPolarity', 'bright', ...
                                     'Sensitivity', 0.88, ...
                                     'EdgeThreshold', 0.25);

    % Display original image and detected circles
    imshow(img, 'Parent', gca);
    hold on;
    viscircles(centers, radii, 'Color', 'r');
    title(sprintf('Image: %02d - Bottles Detected: %d', i, numel(radii)));
    hold off;

    % Wait for a button press or mouse click before continuing
    waitforbuttonpress;
    
    % Wait before next image
    % pause(1); 

    % Store results
    results = [results; {fname, numel(radii)}];
end

% close(fig); % Close figure after loop

% True counts for comparison
trueCounts = [20 18 20 20 20 20 20 20 13 17 20 20 19 20 18 20 17 20 16 19 11 11 20 20]';
results.TrueBottles = trueCounts;

% Comparison result
results.Comparison = results.DetectedBottles == results.TrueBottles;

disp(results); % Display final table
