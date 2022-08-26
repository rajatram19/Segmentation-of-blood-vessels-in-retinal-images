Test_image=imread('1.jpg')
Resized_Image =imresize(Test_image,[584 565]);
Converted_Image=im2double(Resized_Image);
Lab_Image=rgb2lab(Converted_Image);
fill=cat(3,1,0,0);
Filled_Image=bsxfun(@times,fill,Lab_Image);
Reshaped_Lab_Image=reshape(Filled_Image,[],3);
[C, S]=pca(Reshaped_Lab_Image);
S=reshape(S,size(Lab_Image));
S=S(:,:,1);
Gray_Image=(S-min(S(:)))./(max(S(:))-min(S(:)));
Enhanced_Image=adapthisteq(Gray_Image,'NumTiles',[8 8],'nbins',128);
Avg_Filter=fspecial('average',[9 9]);
Filtered_Image=imfilter(Enhanced_Image,Avg_Filter);

substracted_Image=imsubtract(Filtered_Image,Enhanced_Image)

level=Threshold_Level(substracted_Image);

figure,subplot(221),imshow(Test_image)
title('Test image 1')

,subplot(222), imshow(Filtered_Image)
title('Filtered Image')


%Binary_Image=im2bw(substracted_Image,level-0.008);
%subplot(223),imshow(Binary_Image)
%title('Binary Image')

Clean_Image=bwareaopen(Binary_Image,100);
subplot(223),imshow(Clean_Image)
title('clean image')

Complemented_Image=imcomplement(Clean_Image)
subplot(224),imshow(Complemented_Image)
title('Complemented image')

