%%
clear all; close all; clc

imgATester = double((imread('lorem.PNG')))/255;
imgATesterBW = ~im2bw(imgATester);
figure;
imshow(imgATesterBW);title('Image à analyser');
rg = regionprops(imgATesterBW,'PixelIdxList','Centroid');
hold on
for i = 1:length(rg)
    cc = rg(i).Centroid;
    text(cc(1),cc(2),['',num2str(i)],'Color','r','FontSize',9)
end
hold off

boundingboxStruct=regionprops(imgATesterBW,'BoundingBox');
boundingbox = struct2cell(boundingboxStruct);

[x y] = size(boundingbox);

val=zeros(2,y);

for i=1:y
    
    lettreATesterCrop = imcrop(imgATesterBW,cell2mat(boundingbox(i)));
    
    for n=1:26
         modeleLettre = double((imread(sprintf('./Alphabet/alphabet_%d.png',n))))/255;
         modeleLettreBW = ~im2bw(modeleLettre);
         boundingboxLetterStruct=regionprops(modeleLettreBW,'BoundingBox');
         boundingboxLetter = struct2cell(boundingboxLetterStruct);
         
         modelLettreCrop = imcrop(modeleLettreBW,cell2mat(boundingboxLetter));
         
         
         taille = size(lettreATesterCrop);
         
         tmpval = corr2(imresize(modelLettreCrop,taille),lettreATesterCrop);
        
         if (val(2,i)<tmpval)
            val(1,i)=n;
            val(2,i)=tmpval;
         end
         
    end
    
    
    
end