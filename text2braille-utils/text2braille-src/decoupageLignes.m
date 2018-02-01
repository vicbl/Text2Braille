function [ligne, ligneRestatnte]=decoupageLignes(imgText)
% Fonction qui renvoie chaque ligne de l'image d'un texte
% Entrée :
% imgText : image d'un texte au format binaire
%
% Sortie :
% ligne : première ligne en partant du haut extraite de l'image d'entrée
% ligneRestante : image du texte contant les lignes restantes


% Exemple d'utilisaiton:
% imgText=imread('TEST_3.jpg');
% [ligne, ligneRestatnte]=lines(imgText);
% subplot(3,1,1);imshow(im_texto);title('Image d'entrée')
% subplot(3,1,2);imshow(fl);title('1ère ligne')
% subplot(3,1,3);imshow(re);title('ligne restante')
imgText=clip(imgText);
num_filas=size(imgText,1);
for s=1:num_filas
    if sum(imgText(s,:))==0
        nm=imgText(1:s-1, :); % First line matrix
        rm=imgText(s:end, :);% Remain line matrix
        ligne = clip(nm);
        ligneRestatnte=clip(rm);
        break
    else
        ligne=imgText;%Only one line.
        ligneRestatnte=[ ];
    end
end

function img_out=clip(img_in)
[f c]=find(img_in);
img_out=img_in(min(f):max(f),min(c):max(c));%Crops image