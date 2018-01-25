function [word]=cutWord(imgLigne,y)


figure
% Dilate to connect all the letters
binaryImage = imdilate(imgLigne, true(round(y/3.5)));
% % Get rid of blobs less than 200 pixels (the dot of the i).
% binaryImage = bwareaopen(binaryImage, 200);
% Display the image.
imshow(binaryImage, []);
title('Binary Image');

%figure;
% Find the areas and bounding boxes.
measurements = regionprops(binaryImage, 'Area', 'BoundingBox');
allAreas = [measurements.Area]
numBlobs = length(allAreas)
numRows = ceil(sqrt(numBlobs))


% Crop out each word
for blob = 1 : numBlobs
	% Get the bounding box.
	thisBoundingBox = measurements(blob).BoundingBox;
	% Crop it out of the original gray scale image.
	thisWord = imcrop(imgLigne, thisBoundingBox);
	% Display the cropped image
	subplot(numRows, numRows, blob); % Switch to proper axes.
	imshow(thisWord); % Display it.
	% Put a caption above it.
	caption = sprintf('Word #%d', blob);
	title(caption);
    word{blob}=thisWord;
end