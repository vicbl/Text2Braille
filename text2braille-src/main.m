%% Text2Braille
% Convertir une image d'un texte en image de ce m�me texte en braille

%% Clear and close all
clear all; close all; clc

%% Initialisation des fichiers
% Ouvre text.txt en �criture
fichierTxt = fopen('text.txt', 'wt');

% Choix de l'image du texte
imgText = double((imread('../img/lorem.PNG')))/255;

%% Fonction de converion
tStart = tic;
[imgBraille,fichierTexte]=text2braille(imgText,fichierTxt);
tElapsed = toc(tStart); 

%% Affichage du r�sulatat
figure;
subplot(1,2,1);imshow(imgText);
subplot(1,2,2);imshow(imgBraille);


