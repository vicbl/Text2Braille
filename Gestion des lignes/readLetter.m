function [lettre, braille, lettreNum]=readLetter(lettreATesterCrop,centre,moyenneX_lettre,moyenneY_lettre)

val_correlation = 0;
index_lettre = 0;

lettretmp=[];
brailletmp=[];
index_lettre=0;




for n=1:36
    
    modeleLettre = double((imread(sprintf('./../alphabet/alphabet_%d.png',n))))/255;
    modeleLettreBW = ~im2bw(modeleLettre);
    boundingboxLetterStruct=regionprops(modeleLettreBW,'BoundingBox');
    boundingboxLetter = struct2cell(boundingboxLetterStruct);
    
    modelLettreCrop = imcrop(modeleLettreBW,cell2mat(boundingboxLetter(1)));
    
    
    taille = size(lettreATesterCrop);
    
    tmpval_correlation = corr2(imresize(modelLettreCrop,taille),lettreATesterCrop);
    if (val_correlation<tmpval_correlation)
        index_lettre=n;
        val_correlation=tmpval_correlation;
        lettretmp=imresize(modelLettreCrop,taille);
        brailletmp=double((imread(sprintf('./../alphabet_braille/braille_%d.png',n))))/255;
    end
    
    
    
    % Si le centre de la lettre est positionné au dessus ou en dessous de la moyenne
    % Surement un des caractères suivants  ' " , .
    % Si c'est une virgule ou un apostrophe
    if (index_lettre == 28 || index_lettre == 36 )
        if (centre.Centroid(2)<0.7*moyenneY_lettre)
            index_lettre=28;
        else
            index_lettre=36;
        end
    end
end

%
% [tailleX tailleY]=round(size(lettreATesterCrop));
% if (index_lettre == 9 || index_lettre == 27 )
%     if(taille(2)/taille(1) < 0.7)
%         index_lettre = 9;
%     else
%         index_lettre = 27;
%     end
% end
% if (index_lettre == 27)
%     imgLigne(tmp(2)-tmp(4),floor(tmp(1)+tmp(3)/2))
%     if(imgLigne(tmp(2)-tmp(4),floor(tmp(1)+tmp(3)/2))~=1)
%         brailleBW=~im2bw(brailletmp);
%     end
% else
%     brailleBW=~im2bw(brailletmp);
% end

lettreNum = index_lettre;
lettre = lettretmp;
braille = brailletmp;