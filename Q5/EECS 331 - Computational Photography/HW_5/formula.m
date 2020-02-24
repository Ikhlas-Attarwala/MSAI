function [ D, Map, A ] = formula(img, large_k, kernel)
    
[x y ch num] =  size(img);

for k = 1:num
%   for some reason, the focus measure doesn't need to be squared??
%     focus_measure = imfilter(I_gs(:,:,k), kernel) .^ 2;
%     M(:,:,k) = focus_measure .* focus_measure;
    
%   compute grayscale of I'
    I_gs(:,:,k) = rgb2gray(img(:,:,:,k));
%   laplacian
    ii = I_gs(:,:,k);
    jj = I_gs(:,:,k);
    ii(1:x-large_k , :) = diff(I_gs(:,:,k), large_k, 1);
    jj(: , 1:y-large_k) = diff(I_gs(:,:,k), large_k, 2);
    focus_measure = max(ii, jj);
    focus_measure = imfilter(focus_measure, kernel) .^ 2;
    M(:,:,k) = focus_measure .* focus_measure;
end

for k = 1:num
    for i = 1:x
        for j = 1:y
%           ended up just following the equation from ollie's site...
            D(i,j) = max(M(i,j,:));
%             [max_val, max_ind] = max(M(i,j,:));
%             argmax = M(i,j,:)(max_ind);
            test = find(M(i,j,:) == max(M(i,j,:)));
%             argmax = test(M(i,j,:) == max(M(i,j,:)));
            DI(i,j) = test(1);
        end
    end
    max_val = max(max(DI));
    normed = 255 ./ max_val;
    Map = DI .* normed;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 4 - RECOVER ALL-FOCUS IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:x
    for j = 1:y
        image = DI(i,j);
        A(i,j,:) = img(i,j,:,image);
    end
end

end