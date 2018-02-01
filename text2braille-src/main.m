%% Text2Braille
% Convertir une image d'un texte en image de ce même texte en braille

%% Clear and close all
clear all; close all; clc

%% Initialisation des fichiers

% Choix de l'image du texte
imgText = double((imread('../text2braille-images/img/foret.PNG')))/255;

%% Fonction de converion
wait = waitbar(0,'Conversion en cours');
tStart = tic;
[imgBraille,fichierTexte]=text2braille(imgText,wait);
tElapsed = toc(tStart);

fichierTexte
%% Affichage du résulatat
figure;
subplot(1,2,1);imshow(imgText);
subplot(1,2,2);imshow(imgBraille);


