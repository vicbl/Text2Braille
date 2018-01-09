function [brailleImage]=text2braille(texteImage)


imgATester = texteImage;
imgATesterBW = ~im2bw(imgATester);
imgReconstructa = imgATesterBW;


rg = regionprops(imgATesterBW,'PixelIdxList','Centroid','Perimeter');
hold on
for i = 1:length(rg)
    cc = rg(i).Centroid;
    text(cc(1),cc(2),['',num2str(i)],'Color','r','FontSize',9)
end
hold off

boundingboxStruct=regionprops(imgATesterBW,'BoundingBox');
boundingbox = struct2cell(boundingboxStruct);

[x y] = size(boundingbox);

val=zeros(2,y);

for i=1:y
    
    lettreATesterCrop = imcrop(imgATesterBW,cell2mat(boundingbox(i)));
    
    for n=1:36
        modeleLettre = double((imread(sprintf('../Alphabet/alphabet_%d.png',n))))/255;
        modeleLettreBW = ~im2bw(modeleLettre);
        boundingboxLetterStruct=regionprops(modeleLettreBW,'BoundingBox');
        boundingboxLetter = struct2cell(boundingboxLetterStruct);
        
        modelLettreCrop = imcrop(modeleLettreBW,cell2mat(boundingboxLetter(1)));
        taille = size(lettreATesterCrop);
        
        % On récupère le périmètre de chaque lettre
%         perimetreLettreAtester=cell2mat(struct2cell(regionprops(lettreATesterCrop,'Perimeter')));
%         perimetreModelLettre=cell2mat(struct2cell(regionprops(imresize(modelLettreCrop,taille),'Perimeter')));
%      
        
        
        tmpval = corr2(imresize(modelLettreCrop,taille),lettreATesterCrop);
%         if (i==21||i==15)
%             perimetreModelLettre(1)/perimetreLettreAtester(1)
%         end
        
        if (val(2,i)<tmpval)
            val(1,i)=n;
            val(2,i)=tmpval;
            letter=imresize(modelLettreCrop,taille);
            braille=double((imread(sprintf('../braille/braille_%d.png',n))))/255;
        end
        
    end
 
    brailleBW=~im2bw(braille);
 
    tmp=round(cell2mat(boundingbox(1,i)));
    imgReconstructa(tmp(2):tmp(2)+tmp(4),tmp(1):tmp(1)+tmp(3))=imresize(brailleBW,[tmp(4)+1 tmp(3)+1]);
    
end

 %%
brailleImage=~imgReconstructa;