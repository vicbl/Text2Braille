function [moyenneTailleX,moyenneTailleY]=moyenneTailleLettre(boundingbox)
% Fonction qui renvoie la taille moyenne de chaque lettre d'un texte passé
% en entrée (image d'un mot, d'une ligne ...)
% Entrée :
% boundingbox : Tableau (regionProps) des boundingbox de chaque lettre
%
% Sortie :
% moyenneX_lettre : taille moyenne des lettres suivant x
% moyenneY_lettre : taille moyenne des lettres suivant y


[x, nbLettre] = size(boundingbox);

for i=1:nbLettre
    sizeBounding = cell2mat(boundingbox(i));
    x_size(i) = sizeBounding(3);
    y_size(i) = sizeBounding(4);
end
moyenneTailleX = mean(x_size);
moyenneTailleY = mean(y_size);