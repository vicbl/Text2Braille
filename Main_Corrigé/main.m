%%
clear all; close all; clc

imgATester = imresize(double((imread('./img/textSymb.png')))/255,20);
imgATesterBW = ~im2bw(imgATester);
figure;
imshow(imgATesterBW);title('Image à analyser');

%% Region d'interet
rg = regionprops(imgATesterBW,'PixelIdxList','Centroid');


% boucle pour afficher les valeurs sur les images
hold on
for i = 1:length(rg)
    cc = rg(i).Centroid;
    text(cc(1),cc(2),['',num2str(i)],'Color','r','FontSize',9)
end
hold off
% récuperation des rectangles qui contiennent les ROI
boundingboxStruct=regionprops(imgATesterBW,'BoundingBox');
boundingbox = struct2cell(boundingboxStruct);

[x y] = size(boundingbox);

val=zeros(2,y);
%lettreATesterCrop = imcrop(imgATesterBW,cell2mat(boundingbox(1)));
for i=1:y
    
    lettreATesterCrop = imcrop(imgATesterBW,cell2mat(boundingbox(i)));
%     figure,
%     imshow(lettreATesterCrop), title('lettre a tester crop');
%     figure,
%     imshow(imgATesterBW), title('imgATesterBW');
    
    for n=1:36
        modeleLettre = double((imread(sprintf('./alphabet/alphabet_%d.png',n))))/255;
        modeleLettreBW = ~im2bw(modeleLettre);
        boundingboxLetterStruct=regionprops(modeleLettreBW,'BoundingBox');
        boundingboxLetter = struct2cell(boundingboxLetterStruct);
        
        modelLettreCrop = imcrop(modeleLettreBW,cell2mat(boundingboxLetter(1)));
        
        
        taille = size(lettreATesterCrop);
        
        tmpval = corr2(imresize(modelLettreCrop,taille),lettreATesterCrop);
        
        
        if (val(2,i)<tmpval)
            val(1,i)=n;
            val(2,i)=tmpval;
            letter=imresize(modelLettreCrop,taille);
            braille=double((imread(sprintf('./braille/braille_%d.png',n))))/255;
        end
        
    end
    
    tmp=round(cell2mat(boundingbox(1,i)));
    if (val(1,i) == 9 || val(1,i) == 27 )
        if(taille(2)/taille(1) < 0.7)
            val(1,i) = 9;
        else
            val(1,i) = 27;
        end
    end
    if (val(1,i) == 27)
        imgATesterBW(tmp(2)-tmp(4),floor(tmp(1)+tmp(3)/2))
       if(imgATesterBW(tmp(2)-tmp(4),floor(tmp(1)+tmp(3)/2))~=1)
            brailleBW=~im2bw(braille);
            imgReconstructa(tmp(2):tmp(2)+tmp(4),tmp(1):tmp(1)+tmp(3))=imresize(brailleBW,[tmp(4)+1 tmp(3)+1]);
       end
    else
        brailleBW=~im2bw(braille);
        imgReconstructa(tmp(2):tmp(2)+tmp(4),tmp(1):tmp(1)+tmp(3))=imresize(brailleBW,[tmp(4)+1 tmp(3)+1]);
    end
   
    
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

