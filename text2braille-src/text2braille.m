function [imgBraille,fichierTexte]=text2braille(imgDepart,fichierEntree,affichagefigure)


espace = double((imread('../text2braille-images/alphabet_braille/braille_espace.png')))/255;

imgATesterBW = ~im2bw(imgDepart);
figure;
imshow(imgATesterBW);title('Image à analyser');
imgReconstructa=[];
word=[ ];
ligneRestant=imgATesterBW;


nbLigne=1;
%% Tant qu'il y a des lignes à traiter
while 1
    
    [imgLigne, ligneRestant]=decoupageLignes(ligneRestant);
    
    
    %     Décommenter pour afficher le texte et les lignes
    %     figure;
    %     subplot(3,1,1);imshow(imgATesterBW);title('INPUT IMAGE')
    %     subplot(3,1,2);imshow(imgLigne);title('FIRST LINE')
    %     subplot(3,1,3);imshow(ligneRestant);title('REMAIN LINES')
    
    
    
    
    % Récuperation des rectangles qui contiennent les ROI
    % Chaque rectangle correspond à une lettre
    boundingboxStruct=regionprops(imgLigne,'BoundingBox');
    boundingbox = struct2cell(boundingboxStruct);
    rgCentroid=regionprops(imgLigne,'Centroid');
    
    [x nbLettre] = size(boundingbox);
    
    [moyenneX_size, moyenneY_size]=moyenneTailleLettre(boundingbox);
    [moyenneX_lettre,moyenneY_lettre]=moyennePositionCentre(rgCentroid);
    
    
    
    mots= decoupageMots(imgLigne,moyenneY_size);
    
    
    for index_mot=1:length(mots)
        boundingboxStruct=regionprops(mots{index_mot},'BoundingBox');
        boundingbox = struct2cell(boundingboxStruct);
        
        [x nbLettreMot] = size(boundingbox);
        % Pour chaque ROI on cherche la lettre correspondante
        for i=1:nbLettreMot
            
            lettreATesterCrop = imcrop(mots{index_mot},cell2mat(boundingbox(i)));
            [lettre, braille, lettreNum]= readLetter(lettreATesterCrop,rgCentroid(i),moyenneX_lettre,moyenneY_lettre);
            %imgReconstructa(tmp(2):tmp(2)+tmp(4),tmp(1):tmp(1)+tmp(3))=imresize(braille,[tmp(4)+1 tmp(3)+1]);
            
            imgReconstructa=[imgReconstructa braille];
            word = [word convertLetter(lettreNum)];
        end
        imgReconstructa=[imgReconstructa espace];
        word = [word ' '];
    
    end
    
    ligneReconstruite{nbLigne}=imgReconstructa;
    imgReconstructa=[];
    fprintf(fichierEntree,'%s\n',word);%Write 'word' in text file (upper)
    % Clear 'word' variable
    word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(ligneRestant)  %See variable 're' in Fcn 'lines'
        break
    end
    nbLigne=nbLigne+11;
end
imgBraille=reconstructImgFromLine(ligneReconstruite);

fichierTexte = fichierEntree;
