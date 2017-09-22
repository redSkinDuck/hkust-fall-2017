clc
clear

img = imread('example_2.png');
img_eq = histeq(img);

img_eq_mine = equalize_hist(img);


subplot(221),imshow(img)
subplot(222),imhist(img)
subplot(223),imshow(img_eq);
subplot(224),imhist(img_eq);
