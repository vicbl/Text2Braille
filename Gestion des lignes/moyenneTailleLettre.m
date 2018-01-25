function [moyenneX_lettre,moyenneY_lettre]=moyenneTailleLettre(boundingbox,nbLettre)


for i=1:nbLettre
    sizeBounding = cell2mat(boundingbox(i));
    x_size(i) = sizeBounding(3);
    y_size(i) = sizeBounding(4);
end
moyenneX_lettre = mean(x_size)
moyenneY_lettre = mean(y_size)