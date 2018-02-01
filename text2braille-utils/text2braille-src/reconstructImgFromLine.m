function [imgReconstruite]=reconstructImgFromLine(tableLigne)
% Fonction qui renvoie l'image du texte braille reconstitué a partir de
% chaque ligne
% Entrée :
% tableLigne : Tableau d'images des lignes de braille
%
% Sortie :
% imgReconstruite : Image du texte braille sur plusieurs lignes


sizeX=0;
max=0;
length(tableLigne)
for i=1:length(tableLigne)
    [x y z]=size(tableLigne{i});
    if (y>max)
        max=y;
    end
    sizeX=sizeX+x;
    
end

imgReconstruite=[];

for i=1:length(tableLigne)
    imgrezie=im2bw(tableLigne{i});
    [x y]=size(imgrezie);
    
    if (y<max)
        imgrezie=[imgrezie ones(x,max-y)];
    end
    
    imgReconstruite=[imgReconstruite;imgrezie];
    
    
end