%%
clear all; close all; clc


%Ouvre text.txt en écriture
fid = fopen('text.txt', 'wt');

% Ouvre l'image et convertit en noir et blanc
imgATester = double((imread('../img/foret.PNG')))/255;
imgATesterBW = ~im2bw(imgATester);
figure;
imshow(imgATesterBW);title('Image à analyser');
imgReconstructa=[];
word=[ ];
ligneRestant=imgATesterBW;
 nbLigne=1;
%% Tant qu'il y a des lignes à traiter 
while 1
   
    [imgLigne, ligneRestant]=lines(ligneRestant);
%     Décommenter pour afficher le texte et les lignes
%     figure;
%     subplot(3,1,1);imshow(imgATesterBW);title('INPUT IMAGE')
%     subplot(3,1,2);imshow(imgLigne);title('FIRST LINE')
%     subplot(3,1,3);imshow(ligneRestant);title('REMAIN LINES')

    % On récupère les région d'interets de la ligne à traiter
    rg = regionprops(imgLigne,'PixelIdxList');
    
    % Récuperation des rectangles qui contiennent les ROI
    % Chaque rectangle correspond à une lettre
    boundingboxStruct=regionprops(imgLigne,'BoundingBox');
    boundingbox = struct2cell(boundingboxStruct);
    
    [x y] = size(boundingbox);
    
    val=zeros(2,y);
    %lettreATesterCrop = imcrop(imgATesterBW,cell2mat(boundingbox(1)));
    for i=1:y
        
        lettreATesterCrop = imcrop(imgLigne,cell2mat(boundingbox(i)));
        [lettre, braille, lettreNum]= readLetter(lettreATesterCrop,val,i,boundingbox,imgLigne);
        %imgReconstructa(tmp(2):tmp(2)+tmp(4),tmp(1):tmp(1)+tmp(3))=imresize(braille,[tmp(4)+1 tmp(3)+1]);
        
        imgReconstructa=[imgReconstructa braille];
        word = [word convertLetter(lettreNum)];
    end
    
     fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
    % Clear 'word' variable
    word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(ligneRestant)  %See variable 're' in Fcn 'lines'
        break
    end
     nbLigne=nbLigne+11;
end
figure;
imshow(imgReconstructa);

%% remplacer la lettre par l'image de braille

%%
%
% modeleLettre = double((imread(sprintf('./alphabet/alphabet_%d.png',28))))/255;
% modeleLettreBW = ~im2bw(modeleLettre);
% figure, imshow(modeleLettreBW);
% boundingboxLetterStruct=regionprops(modeleLettreBW,'BoundingBox');
% boundingboxLetter = struct2cell(boundingboxLetterStruct);
%
% modelLettreCrop = imcrop(modeleLettreBW,cell2mat(boundingboxLetter(1)));
%
%
% taille = size(lettreATesterCrop);
%
% tmpval = corr2(imresize(modelLettreCrop,taille),lettreATesterCrop);

%%

