clcclear% Pay attention that the data type of matrix img is uint8img = imread('example_1.png');imshow(img)% Now we change it to double(Why?)img = double(img);% img = im2double(img);%{% Why need transfer to double?  img = imread('example_1.png');img = img + 2;img = img * 2;img = imread('example_1.png');img = double(img);img = img * 2;%}img_inv = 255 - img;img_log = 30 * log(1 + img);img_pow = 0.1 * img.^1.5; % A * B ~= A .* B (*, /, ^, ...)img_con = (img > 100) * 255; % img > 100: logical matrix%{% Why need transfer to uint8?img_inv = uint8(img_inv);img_log = uint8(img_log);img_pow = uint8(img_pow);img_con = uint8(img_con);%}subplot(221),imshow(img_inv),title('Inverse')subplot(222),imshow(img_log),title('Log')subplot(223),imshow(img_pow),title('Power')subplot(224),imshow(img_con),title('Contrast Stretching')%{% mat2grayimg = imread('example_1.png');img = double(img);img = img * 2;img = mat2gary(img);%}