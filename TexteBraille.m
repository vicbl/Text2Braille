clear all; close all; clc;

I = double(imread('textMultipleSize3.PNG'));

Ibw = ~im2bw(I);
imshow(Ibw);

CC = bwconncomp(Ibw);
L = labelmatrix(CC);
RGB = label2rgb(L);
figure, imshow(RGB);


stats = regionprops(Ibw);
rg = regionprops(Ibw,'PixelIdxList','Centroid');

centroids = cat(1, stats.Centroid);

hold on
for i = 1:length(rg)
    cc = rg(i).Centroid;
    text(cc(1),cc(2),['',num2str(i)],'Color','b','FontSize',9)
end


hold off

%%
aire=cat(1,stats.Area);
perimeterStruct=regionprops(Ibw,'Perimeter');
perimeter = cell2mat(struct2cell(perimeterStruct));

majoraxisStruct=regionprops(Ibw,'MajorAxisLength');
majoraxis = cell2mat(struct2cell(majoraxisStruct));

minoraxisStruct=regionprops(Ibw,'MinorAxisLength');
minoraxis = cell2mat(struct2cell(minoraxisStruct));

boundingboxStruct=regionprops(Ibw,'BoundingBox');
boundingboxtmp = struct2cell(boundingboxStruct);

[x y]=size(aire);
boundingbox=zeros(1,x);
for i=1:x
    tmp = cell2mat(boundingboxtmp(i));
    boundingbox(i)=tmp(3)*tmp(4);
end

figure;
plot(aire,'*','MarkerSize',5);
hold on
plot(perimeter,'*','MarkerSize',5);
plot(minoraxis,'*','MarkerSize',5);
plot(majoraxis,'*','MarkerSize',5);
plot(minoraxis,'*','MarkerSize',5);
plot(boundingbox,'*','MarkerSize',5);
hold off

%% Normalize
for i=1:size(aire)
    perimeter(i)=perimeter(i)/boundingbox(i);
    minoraxis(i)=minoraxis(i)/boundingbox(i);
    majoraxis(i)=majoraxis(i)/boundingbox(i);
    aire(i)=aire(i)/boundingbox(i);
end

figure;
plot(aire,aire,'*','MarkerSize',5);
hold on
plot(aire,perimeter,'*','MarkerSize',5);
plot(aire,minoraxis,'*','MarkerSize',5);
plot(aire,majoraxis,'*','MarkerSize',5);


hold off

%%
clear all; close all; clc
I = double(imread('alpha.PNG'));

Ibw = ~im2bw(I);
imshow(Ibw);
BW3 = bwmorph(Ibw,'skel',inf);
figure
imshow(BW3)

BW2 = bwmorph(BW3,'branchpoints');
figure
imshow(BW2)

%%
clear all; close all; clc
moti=im2bw(double(imread('alpha.png')));
img=double(im2bw(imread('alphabet\alphabet_1.PNG')));
figure;
subplot(1,2,1);imshow(moti,[]);title('Motif');axis on; colorbar;
subplot(1,2,2);imshow(img,[]);title('Image');axis on;colorbar;

[L, C]=size(img);
[Lm, Cm]=size(moti);
correlation=zeros(L-Lm+1, C-Cm+1);
for k=1:L-Lm+1
    for l=1:C-Cm+1
        ImExt=img(k:k+Lm-1,l:l+Cm-1);
        correlation(k,l)=sum(sum(moti.*ImExt));
    end
end

[maxL,maxC] =find(correlation == max(max(correlation)));
% Le maximum se trouve aux coordonnées maxL et maxC, dans ce cas maxC=12 et
% maxL=14
figure;
subplot(2,2,1);imshow(moti,[]);title('Motif');colorbar;axis on;
subplot(2,2,2);imshow(img,[]);title('Image');colorbar;axis on;
hold on;
plot(maxC+2,maxL+2,'r*')
hold off;
subplot(2,2,3.5);imshow(correlation,[]);title('Correlation');colorbar;axis on;
hold on;
plot(maxC,maxL,'r*')
hold off;

%%
clear all; close all; clc
i1=double((imread('alphabet.PNG')))/255;
m=double(imread('alphabet\alphabet_1.PNG'))/255;

cNC1=correlationNCentree(m,i1);

[licNC1,cocNC1]=find(cNC1==max(cNC1(:)));


figure; imshow(cNC1,[]);colorbar; axis on;colormap(gray); title('Corr Normalisée Centrée')
hold on;plot(cocNC1,licNC1,'or','MarkerSize',15)

%%
clear all; close all; clc
m=double(rgb2gray(imread('alphabet\alphabet_1.PNG')));
i1=double(rgb2gray(imread('test.PNG')));

imshowpair(i1,m,'montage')

c = corr2(m,i1);
figure, surf(c), shading flat

[ypeak, xpeak] = find(c==max(c(:)));
figure;
imshow(i1,[]);
hold on
plot(xpeak,ypeak,'*','MarkerSize',5)
hold off


yoffSet = gather(ypeak-size(m,1));
xoffSet = gather(xpeak-size(m,2));

figure
imshow(i1);
imrect(gca, [xoffSet+1, yoffSet+1, size(m,2), size(m,1)]);



