function [brailleImage]=text2braille(texteImage)



%% On a joué sur le size de l'image d'input (x20) 
% et pour que l image de sortie ne soit pas grande, on l'a fait un resize (x1/20) 
imgATester = texteImage;
%imgATester = adapthisteq(imgATester);
imgATesterBW = ~im2bw(imgATester);
imgReconstructa = imgATesterBW;


% figure;
% imshow(imgATesterBW);title('Image à analyser');
%% Region d'interet
rg = regionprops(imgATesterBW,'PixelIdxList','Centroid'); 
hold on
%%boucle pour afficher les valeurs sur les images
for i = 1:length(rg)
    cc = rg(i).Centroid;
    text(cc(1),cc(2),['',num2str(i)],'Color','r','FontSize',9)
end
hold off
%% récuperation des rectangles qui contiennent les ROI
boundingboxStruct=regionprops(imgATesterBW,'BoundingBox');
boundingbox = struct2cell(boundingboxStruct);

[x y] = size(boundingbox);

val=zeros(2,y);

for i=1:y %Y nombre qui es sur l'objet
    %on compare la ROI avec tous les alphabets
    
    lettreATesterCrop = imcrop(imgATesterBW,cell2mat(boundingbox(i)));
    
    for n=1:26
        modeleLettre = double((imread(sprintf('../Alphabet/alphabet_%d.png',n))))/255;
        modeleLettreBW = ~im2bw(modeleLettre);
        boundingboxLetterStruct=regionprops(modeleLettreBW,'BoundingBox');
        boundingboxLetter = struct2cell(boundingboxLetterStruct);
        
        modelLettreCrop = imcrop(modeleLettreBW,cell2mat(boundingboxLetter));
        
        
        taille = size(lettreATesterCrop);
        
        tmpval = corr2(imresize(modelLettreCrop,taille),lettreATesterCrop);
        
        if (val(2,i)<tmpval)
            val(1,i)=n;
            val(2,i)=tmpval;
            letter=imresize(modelLettreCrop,taille);
            braille=double((imread(sprintf('../braille/braille_%d.png',n))))/255;
        end
        
    end
 
    brailleBW=~im2bw(braille);
 
    tmp=round(cell2mat(boundingbox(1,i)));
    imgReconstructa(tmp(2):tmp(2)+tmp(4),tmp(1):tmp(1)+tmp(3))=imresize(brailleBW,[tmp(4)+1 tmp(3)+1]); %**
    
end

brailleImage=~imgReconstructa;