function [imgReconstruite]=reconstructImgFromLine(tableLigne)

sizeX=0;
max=0;
length(tableLigne)
for i=1:length(tableLigne)
    [x y z]=size(tableLigne{i});
    if (y>max)
        max=y;
    end
    sizeX=sizeX+x;
    
end

imgReconstruite=ones(sizeX,max);
imgReconstruita=im2bw(tableLigne{1});
for i=2:length(tableLigne)
%     tableLigne{i}(numel(imgReconstruite)) = 0;

ligne=im2bw(tableLigne{i});
%ligne(y,sizeX)=1;
sizeimg = size(imgReconstruite)
sizelin = size(ligne)
  imgReconstruita=[imgReconstruita;ligne];
  
    
end