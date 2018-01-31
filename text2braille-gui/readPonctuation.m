function [lettre, braille, lettreNum]=readPonctuation(lettreAConvertir)
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




for n=33:35
   
    modeleLettre = double((imread(sprintf('../text2braille-images/alphabet/alphabet_%d.png',n))))/255;
    modeleLettreBW = ~im2bw(modeleLettre);
 
    
    
    
    taille = size(lettreAConvertir);
    tmpval_correlation = corr2(imresize(modeleLettreBW,taille),lettreAConvertir);
    
    if (val_correlation<tmpval_correlation)
        index_lettre=n;
        val_correlation=tmpval_correlation;
        lettretmp=modeleLettreBW;
        brailletmp=double((imread(sprintf('../text2braille-images/alphabet_braille/braille_%d.png',n))))/255;
    end
    
    
    

end


lettreNum = index_lettre;
lettre = lettretmp;
braille = brailletmp;