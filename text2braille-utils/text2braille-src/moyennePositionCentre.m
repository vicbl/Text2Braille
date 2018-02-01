function [moyenneX_lettre,moyenneY_lettre]=moyennePositionCentre(rgCentroid)
% Fonction qui renvoie la position moyenne de chaque lettre d'un texte passé
% en entrée (image d'un mot, d'une ligne ...)
% Entrée :
% rgCentroid : Tableau (regionProps) des centroid de chaque lettre
%
% Sortie :
% moyenneX_lettre : position moyenne des lettres suivant x
% moyenneY_lettre : position moyenne des lettres suivant y


for i=1:length(rgCentroid)
    x_centroid(i) = rgCentroid(i).Centroid(1);
    y_centroid(i) = rgCentroid(i).Centroid(2);
end

moyenneX_lettre = mean(x_centroid);
moyenneY_lettre = mean(y_centroid);