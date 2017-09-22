function out_img = equalize_hist(input_img)

in_img = double(input_img)+1;
%max_gray = max(max(in_img));
max_gray = 256;
[height,width] = size(in_img);
out_img = zeros(height, width);

% Another way to create column vector
gray_table = zeros(max_gray,1);
gray_table_new = zeros(max_gray,1);
probability = zeros(max_gray,1);
hist_img = zeros(max_gray,1);

%------------- Compute Occurrence Matrix of gray level -------------------------
% {
for i = 1:height
    for j = 1:width
        gray_table(in_img(i,j),1) = gray_table(in_img(i,j),1)+1;
    end
end
% }

%{
for p = 1:max_gray
    gray_table(p,1) = sum(sum(in_img == p));
end
%}

%--------------------------- Plot the histogram --------------------------------
%{
plot((0:1:255),gray_table(:,1));
ylabel('Count');
xlabel('Gray level value');
%}

%------------- Compute the Image Histogram(PDF) --------------------------------
% {
for p = 1:max_gray
    probability(p,1) = gray_table(p,1)/(height*width);
end
% }

%{
probability = gray_table / (height*width);
%}

%-------- Compute Cumulative distribution function(CDF) of the image -----------
hist_img(1,1) = probability(1,1);
for i = 2:max_gray
    hist_img(i,1) = hist_img(i-1,1) + probability(i,1);
end

%-------- Mapping (Notice that we don't multipy the gray level here) -----------
% {
for i = 1:height
    for j = 1:width
        out_img(i,j) = hist_img(in_img(i,j),1);
    end
end
% }
%{
for p = 1:max_gray
    out_img(in_img == p) = hist_img(p);
end
%}
%---------------- Obtain the new occurrence histogram --------------------------
% {
for i = 1:height
    for j = 1:width
        gray_table_new(round(out_img(i,j)*255)+1,1) = gray_table_new(round(out_img(i,j)*255)+1,1)+1;
    end
end
% }
%{
for p = 1:max_gray
    gray_table_new(p, 1) = sum(sum((round(out_img*255)+1) == p));
end
%}

%----------------------- Plot the new histogram --------------------------------
%{
figure,
plot((0:1:255),gray_table_new(:,1));
ylabel('Count_new');
xlabel('Gray level value');
%}


out_img1 = double(out_img);
max_out = max(max(out_img1));
out_img = out_img1/max_out;