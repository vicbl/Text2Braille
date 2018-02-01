function [lettre, braille, lettreNum]=readLetter(lettreAConvertir,centre,moyennePositionX_lettre,moyennePositionY_lettre)
% Fonction qui renvoie les images de la lettre au format texte, braille
% ainsi que son index dans le dictionnaire
% Entr�e :
% lettreAConvertir : lettre au format binaire et d�coup�e au bord (boundingBox)
% centre : position moyenne du centre des lettre (permettra de diff�rencier , et ')
% moyenneTailleX_lettre : taille moyenne des lettres suivant x
% moyenneTailleY_lettre : taille moyenne des lettres suivant y
%
% Sortie :
% lettre : image de la lettre du dictionnaire au format texte correspondante � la lettre d'entr�e
% braille : image de la lettre du dictionnaire au format braille correspondante � la lettre d'entr�e
% lettreNum : index de la position de la lettre dans le dictionnaire correspondante � la lettre d'entr�e

val_correlation = 0;
index_lettre = 0;

lettretmp=[];
brailletmp=[];
index_lettre=0;




for n=1:32
    
    modeleLettre = double((imread(sprintf('./text2braille-utils/text2braille-images/alphabet/alphabet_%d.png',n))))/255;
    modeleLettreBW = ~im2bw(modeleLettre);
    
    
        boundingboxLetterStruct=regionprops(modeleLettreBW,'BoundingBox');
        boundingboxLetter = struct2cell(boundingboxLetterStruct);
        
        modelLettreCrop = imcrop(modeleLettreBW,cell2mat(boundingboxLetter(1)));

    
    taille = size(lettreAConvertir);
    
    tmpval_correlation = corr2(imresize(modelLettreCrop,taille),lettreAConvertir);
    if (val_correlation<tmpval_correlation)
        index_lettre=n;
        val_correlation=tmpval_correlation;
        lettretmp=imresize(modelLettreCrop,taille);
        brailletmp=double((imread(sprintf('./text2braille-utils/text2braille-images/alphabet_braille/braille_%d.png',n))))/255;
    end
    
    
    
    % Si le centre de la lettre est positionn� au dessus ou en dessous de la moyenne
    % Surement un des caract�res suivants  ' " , .
    % Si c'est une virgule ou un apostrophe
    if (index_lettre == 28 || index_lettre == 31)
        
        if (centre.Centroid(1)<0.7*moyennePositionY_lettre)
            index_lettre=28;
        else
            index_lettre=31;
        end
    end
    
    switch index_lettre
        case 27 % .
            if (centre.Centroid(1)>0.3*moyennePositionY_lettre)
                index_lettre=9;
            end
%         case 29 % (
            
%         case 30 % )
        otherwise
            index_lettre=index_lettre;
    end
end



lettreNum = index_lettre;
lettre = lettretmp;
braille = brailletmp;