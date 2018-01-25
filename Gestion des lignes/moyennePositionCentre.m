function [moyenneX_lettre,moyenneY_lettre]=moyennePositionCentre(rgCentroid)


for i=1:length(rgCentroid)
    x_centroid(i) = rgCentroid(i).Centroid(1);
    y_centroid(i) = rgCentroid(i).Centroid(2);
end
moyenneY_lettre = mean(y_centroid)
moyenneX_lettre = mean(x_centroid)