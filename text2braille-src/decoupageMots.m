function [mot]=decoupageMots(imgLigne,moyenneTailleLettre)
% Fonction qui renvoie chaque mot de l'image d'une ligne de texte
% Entrée :
% imgLigne : image d'une ligne d'un texte au format binaire
% moyenneTailleLettre : taille moyenne D'une lettre (utile pour la
% taille de l'élément structurant de la dilatation)
%
% Sortie :
% mot : tableau contenant tout les mots de la ligne passé en entrée

% figure
% Dilate to connect all the letters
binaryImage = imdilate(imgLigne, true(round(moyenneTailleLettre/3.5)));
% % Get rid of blobs less than 200 pixels (the dot of the i).
% binaryImage = bwareaopen(binaryImage, 200);
% Display the image.
% imshow(binaryImage, []);
% title('Binary Image');

%figure;
% Find the areas and bounding boxes.
measurements = regionprops(binaryImage, 'Area', 'BoundingBox');
allAreas = [measurements.Area];
numBlobs = length(allAreas);
numRows = ceil(sqrt(numBlobs));


% Crop out each word
for blob = 1 : numBlobs
	% Get the bounding box.
	thisBoundingBox = measurements(blob).BoundingBox;
	% Crop it out of the original gray scale image.
	thisWord = imcrop(imgLigne, thisBoundingBox);
	% Display the cropped image
% 	subplot(numRows, numRows, blob); % Switch to proper axes.
% 	imshow(thisWord); % Display it.
	% Put a caption above it.
%	caption = sprintf('Word #%d', blob);
%	title(caption);
    mot{blob}=thisWord;
end