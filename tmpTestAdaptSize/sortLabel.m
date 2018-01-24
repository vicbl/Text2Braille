function [brailleImage]=sortLabel(imgATesterBW)




rg = regionprops(imgATesterBW,'PixelList','Centroid');
% coords = vertcat(s.Centroid);  % 2-by-18 matrix of centroid data
% [~, ~, coords(:, 2)] = histcounts(coords(:, 2), 3);  % Bin the "y" data
% [~, sortIndex] = sortrows(coords, [2 1]);  % Sort by "y" ascending, then "x" ascending
% s = s(sortIndex);  % Apply sort index to s

coords = vertcat(rg.Centroid);  % 2-by-18 matrix of centroid data

coordsort = sort(coords,1);

sortIndex=zeros(size(coordsort));
lbl=1;
for j= 1:length(coordsort)
    if j==1
        sortIndex(j,1)=lbl;
    else
        coordsort(j,2)/coordsort(j-1,2)
        if ((coordsort(j,2)/coordsort(j-1,2))>1 && (coordsort(j,2)/coordsort(j-1,2))<1.2)
            sortIndex(j,1)=lbl;
        else
            lbl=lbl+1;
             sortIndex(j,1)=lbl;
        end
    end
end
sortIndex=double(sortIndex(:,1));
%  rg = rg();
coordsort(:, 2) = (sortIndex(:,1));  % Bin the "y" data

[~, sortIndex] = sortrows(sort(vertcat(rg.Centroid),1), [2 1]);  % Sort by "y" ascending, then "x" ascending
rg = rg(sortIndex);  % Apply sort index to s
[sort id]=sort(vertcat(rg.Centroid),1);


imshow(imgATesterBW);title('Image à analyser');
hold on
%%boucle pour afficher les valeurs sur les images
for i = 1:numel(s)
    cc = s(i).Centroid;
    text(cc(1),cc(2),['',num2str(i)],'Color','r','FontSize',9)
end
hold off
