function [imgBraille,fichierTexte]=text2braille(imgDepart,wait)


espace = double((imread('./text2braille-utils/text2braille-images/alphabet_braille/braille_espace.png')))/255;

imgATesterBW = ~im2bw(imgDepart);



boundingboxStruct=regionprops(imgATesterBW,'BoundingBox');
boundingboxLettreTotal = struct2cell(boundingboxStruct);
[x nbLettreTotal] = size(boundingboxLettreTotal);


incrementLettre = 0;

imgReconstructa=[];
word=[ ];
ligneRestant=imgATesterBW;
filecontent=[];

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
    boundingboxMots = struct2cell(boundingboxStruct);
    rgCentroid=regionprops(imgLigne,'Centroid');
    
    [x nbLettre] = size(boundingboxMots);
    
    [moyenneX_size, moyenneY_size]=moyenneTailleLettre(boundingboxMots);
    [moyenneX_lettre,moyenneY_lettre]=moyennePositionCentre(rgCentroid);
    
    mots= decoupageMots(imgLigne,moyenneY_size);
    
    
    for index_mot=1:length(mots)
        boundingboxStruct=regionprops(mots{index_mot},'BoundingBox');
        boundingboxLettre = struct2cell(boundingboxStruct);
        
        [x nbLettreMot] = size(boundingboxLettre);
        
        max = -1;
        memeAlignement = 0;
        
        % On verifie si c'est un ! ; ?
        for i=1:nbLettreMot
            posX = cell2mat(boundingboxLettre(i));
            posX = posX(1);
            if ((max>0.95*posX && max<1.05*posX ))
                memeAlignement = 1;
            end
            max=posX;
        end
        
        
        % Si on à le même alignement entre deux ROI
        if (memeAlignement == 1)
            [lettre, braille, lettreNum]= readPonctuation(mots{index_mot});
            imgReconstructa=[imgReconstructa braille];
            word = [word convertLetter(lettreNum)];
            incrementLettre = incrementLettre +1;
            waitbar(incrementLettre/nbLettreTotal,wait,'Conversion en cours')
        else
            % Pour chaque ROI on cherche la lettre correspondante
            for i=1:nbLettreMot
                
                
                lettreATesterCrop = imcrop(mots{index_mot},cell2mat(boundingboxLettre(i)));
                [lettre, braille, lettreNum]= readLetter(lettreATesterCrop,rgCentroid(i),moyenneX_lettre,moyenneY_lettre);
                
                imgReconstructa=[imgReconstructa braille];
                word = [word convertLetter(lettreNum)];
                incrementLettre = incrementLettre +1;
                waitbar(incrementLettre/nbLettreTotal,wait,'Conversion en cours')
                
            end
        end
        
        imgReconstructa=[imgReconstructa espace];
        word = [word ' '];
        
    end
    
    ligneReconstruite{nbLigne}=imgReconstructa;
    imgReconstructa=[];
    
    filecontent{nbLigne} =(word);
    % Clear 'word' variable
    word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(ligneRestant)  %See variable 're' in Fcn 'lines'
        break
    end
    nbLigne=nbLigne+1;
end
close(wait);
imgBraille=reconstructImgFromLine(ligneReconstruite);

fichierTexte = filecontent;



