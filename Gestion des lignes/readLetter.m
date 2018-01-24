function [lettre, braille, lettreNum]=readLetter(lettreATesterCrop,val,i,boundingbox,imgLigne)

for n=1:31
    modeleLettre = double((imread(sprintf('./../alphabet/alphabet_%d.png',n))))/255;
    modeleLettreBW = ~im2bw(modeleLettre);
    boundingboxLetterStruct=regionprops(modeleLettreBW,'BoundingBox');
    boundingboxLetter = struct2cell(boundingboxLetterStruct);
    
    modelLettreCrop = imcrop(modeleLettreBW,cell2mat(boundingboxLetter(1)));
    
    
    taille = size(lettreATesterCrop);
    
    tmpval = corr2(imresize(modelLettreCrop,taille),lettreATesterCrop);
    
    
    if (val(2,i)<tmpval)
        val(1,i)=n;
        val(2,i)=tmpval;
        lettretmp=imresize(modelLettreCrop,taille);
        brailletmp=double((imread(sprintf('./../alphabet_braille/braille_%d.png',n))))/255;
    end
    n
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
    imgLigne(tmp(2)-tmp(4),floor(tmp(1)+tmp(3)/2))
    if(imgLigne(tmp(2)-tmp(4),floor(tmp(1)+tmp(3)/2))~=1)
        brailleBW=~im2bw(brailletmp);
    end
else
    brailleBW=~im2bw(brailletmp);
end

lettreNum = val(1,i);
lettre = lettretmp;
braille = brailletmp;