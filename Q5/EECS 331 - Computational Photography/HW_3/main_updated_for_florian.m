% C.P. HW #3 (UPDATED FOR FLORIAN)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load no-flash image, resize it as 768x1024, and transform into double
img_noflash = '/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_3/potsWB_01_noflash.jpg';
data_noflash = imread(img_noflash);
data_noflash = im2double(data_noflash);
cropsize = [120,425,140,70];
data_noflash_cropped = imcrop(data_noflash, cropsize);

% RGB channels for no-flash image
r_noflash = data_noflash(:,:,1);
g_noflash = data_noflash(:,:,2);
b_noflash = data_noflash(:,:,3);

% crop above channels, only for subplotting because it's easier to see
% NOTE: We won't use the cropped image for final, only the setting
r_cropped_noflash = imcrop(r_noflash, cropsize);
g_cropped_noflash = imcrop(g_noflash, cropsize);
b_cropped_noflash = imcrop(b_noflash, cropsize);

% denoising no-flash image
bf_no_1_05 = cat(3, bilateralFilter(r_noflash, 1, .05), bilateralFilter(g_noflash, 1, .05), bilateralFilter(b_noflash, 1, .05));
bf_no_1_10 = cat(3, bilateralFilter(r_noflash, 1, .10), bilateralFilter(g_noflash, 1, .10), bilateralFilter(b_noflash, 1, .10));
bf_no_1_15 = cat(3, bilateralFilter(r_noflash, 1, .15), bilateralFilter(g_noflash, 1, .15), bilateralFilter(b_noflash, 1, .15));
bf_no_1_20 = cat(3, bilateralFilter(r_noflash, 1, .20), bilateralFilter(g_noflash, 1, .20), bilateralFilter(b_noflash, 1, .20));

bf_no_2_05 = cat(3, bilateralFilter(r_noflash, 2, .05), bilateralFilter(g_noflash, 2, .05), bilateralFilter(b_noflash, 2, .05));
bf_no_2_10 = cat(3, bilateralFilter(r_noflash, 2, .10), bilateralFilter(g_noflash, 2, .10), bilateralFilter(b_noflash, 2, .10));
bf_no_2_15 = cat(3, bilateralFilter(r_noflash, 2, .15), bilateralFilter(g_noflash, 2, .15), bilateralFilter(b_noflash, 2, .15));
bf_no_2_20 = cat(3, bilateralFilter(r_noflash, 2, .20), bilateralFilter(g_noflash, 2, .20), bilateralFilter(b_noflash, 2, .20));

bf_no_4_05 = cat(3, bilateralFilter(r_noflash, 4, .05), bilateralFilter(g_noflash, 4, .05), bilateralFilter(b_noflash, 4, .05));
bf_no_4_10 = cat(3, bilateralFilter(r_noflash, 4, .10), bilateralFilter(g_noflash, 4, .10), bilateralFilter(b_noflash, 4, .10));
bf_no_4_15 = cat(3, bilateralFilter(r_noflash, 4, .15), bilateralFilter(g_noflash, 4, .15), bilateralFilter(b_noflash, 4, .15));
bf_no_4_20 = cat(3, bilateralFilter(r_noflash, 4, .20), bilateralFilter(g_noflash, 4, .20), bilateralFilter(b_noflash, 4, .20));

bf_no_8_05 = cat(3, bilateralFilter(r_noflash, 8, .05), bilateralFilter(g_noflash, 8, .05), bilateralFilter(b_noflash, 8, .05));
bf_no_8_10 = cat(3, bilateralFilter(r_noflash, 8, .10), bilateralFilter(g_noflash, 8, .10), bilateralFilter(b_noflash, 8, .10));
bf_no_8_15 = cat(3, bilateralFilter(r_noflash, 8, .15), bilateralFilter(g_noflash, 8, .15), bilateralFilter(b_noflash, 8, .15));
bf_no_8_20 = cat(3, bilateralFilter(r_noflash, 8, .20), bilateralFilter(g_noflash, 8, .20), bilateralFilter(b_noflash, 8, .20));

bf_no_16_05 = cat(3, bilateralFilter(r_noflash, 16, .05), bilateralFilter(g_noflash, 16, .05), bilateralFilter(b_noflash, 16, .05));
bf_no_16_10 = cat(3, bilateralFilter(r_noflash, 16, .10), bilateralFilter(g_noflash, 16, .10), bilateralFilter(b_noflash, 16, .10));
bf_no_16_15 = cat(3, bilateralFilter(r_noflash, 16, .15), bilateralFilter(g_noflash, 16, .15), bilateralFilter(b_noflash, 16, .15));
bf_no_16_20 = cat(3, bilateralFilter(r_noflash, 16, .20), bilateralFilter(g_noflash, 16, .20), bilateralFilter(b_noflash, 16, .20));

% testing different bilateral filters on no-flash image
% (UNCOMMENT BELOW TO REVEAL FIGURE())
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
tiledlayout(4,5)
nexttile
imshow(bf_no_1_05)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_2_05)
title('{\sigma}_{s} = 2, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_4_05)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_8_05)
title('{\sigma}_{s} = 8, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_16_05)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_1_10)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_2_10)
title('{\sigma}_{s} = 2, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_4_10)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_8_10)
title('{\sigma}_{s} = 8, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_16_10)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_1_15)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_2_15)
title('{\sigma}_{s} = 2, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_4_15)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_8_15)
title('{\sigma}_{s} = 8, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_16_15)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_1_20)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_2_20)
title('{\sigma}_{s} = 2, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_4_20)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_8_20)
title('{\sigma}_{s} = 8, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_16_20)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .20')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% RESULT: 'bf_no_8_05' HAS THE BEST DENOISED RESULT
best_noflash = bf_no_8_05;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load flash image, resize it as 768x1024, and transform into double
img_flash = '/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_3/potsWB_00_flash.jpg';
data_flash = imread(img_flash);
data_flash = im2double(data_flash);
data_flash_cropped = imcrop(data_flash, cropsize);

% RGB channels for flash image
r_flash = data_flash(:,:,1);
g_flash = data_flash(:,:,2);
b_flash = data_flash(:,:,3);

% crop above channels, only for subplotting because it's easier to see
% NOTE: We won't use the cropped image for final, only the setting
r_cropped_flash = imcrop(r_flash, cropsize);
g_cropped_flash = imcrop(g_flash, cropsize);
b_cropped_flash = imcrop(b_flash, cropsize);

% denoising flash image
bf_f_1_05 = cat(3, bilateralFilter(r_flash, 1, .05), bilateralFilter(g_flash, 1, .05), bilateralFilter(b_flash, 1, .05));
bf_f_1_10 = cat(3, bilateralFilter(r_flash, 1, .10), bilateralFilter(g_flash, 1, .10), bilateralFilter(b_flash, 1, .10));
bf_f_1_15 = cat(3, bilateralFilter(r_flash, 1, .15), bilateralFilter(g_flash, 1, .15), bilateralFilter(b_flash, 1, .15));
bf_f_1_20 = cat(3, bilateralFilter(r_flash, 1, .20), bilateralFilter(g_flash, 1, .20), bilateralFilter(b_flash, 1, .20));

bf_f_2_05 = cat(3, bilateralFilter(r_flash, 2, .05), bilateralFilter(g_flash, 2, .05), bilateralFilter(b_flash, 2, .05));
bf_f_2_10 = cat(3, bilateralFilter(r_flash, 2, .10), bilateralFilter(g_flash, 2, .10), bilateralFilter(b_flash, 2, .10));
bf_f_2_15 = cat(3, bilateralFilter(r_flash, 2, .15), bilateralFilter(g_flash, 2, .15), bilateralFilter(b_flash, 2, .15));
bf_f_2_20 = cat(3, bilateralFilter(r_flash, 2, .20), bilateralFilter(g_flash, 2, .20), bilateralFilter(b_flash, 2, .20));

bf_f_4_05 = cat(3, bilateralFilter(r_flash, 4, .05), bilateralFilter(g_flash, 4, .05), bilateralFilter(b_flash, 4, .05));
bf_f_4_10 = cat(3, bilateralFilter(r_flash, 4, .10), bilateralFilter(g_flash, 4, .10), bilateralFilter(b_flash, 4, .10));
bf_f_4_15 = cat(3, bilateralFilter(r_flash, 4, .15), bilateralFilter(g_flash, 4, .15), bilateralFilter(b_flash, 4, .15));
bf_f_4_20 = cat(3, bilateralFilter(r_flash, 4, .20), bilateralFilter(g_flash, 4, .20), bilateralFilter(b_flash, 4, .20));

bf_f_8_05 = cat(3, bilateralFilter(r_flash, 8, .05), bilateralFilter(g_flash, 8, .05), bilateralFilter(b_flash, 8, .05));
bf_f_8_10 = cat(3, bilateralFilter(r_flash, 8, .10), bilateralFilter(g_flash, 8, .10), bilateralFilter(b_flash, 8, .10));
bf_f_8_15 = cat(3, bilateralFilter(r_flash, 8, .15), bilateralFilter(g_flash, 8, .15), bilateralFilter(b_flash, 8, .15));
bf_f_8_20 = cat(3, bilateralFilter(r_flash, 8, .20), bilateralFilter(g_flash, 8, .20), bilateralFilter(b_flash, 8, .20));

bf_f_16_05 = cat(3, bilateralFilter(r_flash, 16, .05), bilateralFilter(g_flash, 16, .05), bilateralFilter(b_flash, 16, .05));
bf_f_16_10 = cat(3, bilateralFilter(r_flash, 16, .10), bilateralFilter(g_flash, 16, .10), bilateralFilter(b_flash, 16, .10));
bf_f_16_15 = cat(3, bilateralFilter(r_flash, 16, .15), bilateralFilter(g_flash, 16, .15), bilateralFilter(b_flash, 16, .15));
bf_f_16_20 = cat(3, bilateralFilter(r_flash, 16, .20), bilateralFilter(g_flash, 16, .20), bilateralFilter(b_flash, 16, .20));

% testing different bilateral filters on flash image
% (UNCOMMENT BELOW TO REVEAL FIGURE())
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
tiledlayout(4,5)
nexttile
imshow(bf_f_1_05)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .05')
nexttile
imshow(bf_f_2_05)
title('{\sigma}_{s} = 2, {\sigma}_{r} = .05')
nexttile
imshow(bf_f_4_05)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .05')
nexttile
imshow(bf_f_8_05)
title('{\sigma}_{s} = 8, {\sigma}_{r} = .05')
nexttile
imshow(bf_f_16_05)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .05')
nexttile
imshow(bf_f_1_10)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .10')
nexttile
imshow(bf_f_2_10)
title('{\sigma}_{s} = 2, {\sigma}_{r} = .10')
nexttile
imshow(bf_f_4_10)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .10')
nexttile
imshow(bf_f_8_10)
title('{\sigma}_{s} = 8, {\sigma}_{r} = .10')
nexttile
imshow(bf_f_16_10)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .10')
nexttile
imshow(bf_f_1_15)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .15')
nexttile
imshow(bf_f_2_15)
title('{\sigma}_{s} = 2, {\sigma}_{r} = .15')
nexttile
imshow(bf_f_4_15)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .15')
nexttile
imshow(bf_f_8_15)
title('{\sigma}_{s} = 8, {\sigma}_{r} = .15')
nexttile
imshow(bf_f_16_15)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .15')
nexttile
imshow(bf_f_1_20)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .20')
nexttile
imshow(bf_f_2_20)
title('{\sigma}_{s} = 2, {\sigma}_{r} = .20')
nexttile
imshow(bf_f_4_20)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .20')
nexttile
imshow(bf_f_8_20)
title('{\sigma}_{s} = 8, {\sigma}_{r} = .20')
nexttile
imshow(bf_f_16_20)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .20')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% RESULT: 'bf_f_8_05' HAS THE BEST DENOISED RESULT (same sett. as before)
best_flash = bf_f_8_05;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUSION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Formula: Af = Ad .* ((F + e)./(Fd + e))

% Ad = perfect de-noised no-flash image
Ad = best_noflash;
% F = original flash image
F = data_flash;
% Fd = perfect de-noised flash image
Fd = best_flash;
% e/epsilon = to make sure denominator doesn't hit 0.
e = 0.2;
% Af = fused image result
Af = Ad .* ((F + e)./(Fd + e));

% all fusions
% (UNCOMMENT BELOW TO REVEAL FIGURE())
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
tiledlayout(4,5)
nexttile
imshow(bf_no_1_05 .* ((F + e)./(bf_f_1_05 + e)))
title('{\sigma}_{s} = 1, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_2_05 .* ((F + e)./(bf_f_2_05 + e)))
title('{\sigma}_{s} = 2, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_4_05 .* ((F + e)./(bf_f_4_05 + e)))
title('{\sigma}_{s} = 4, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_8_05 .* ((F + e)./(bf_f_8_05 + e)))
title('{\sigma}_{s} = 8, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_16_05 .* ((F + e)./(bf_f_16_05 + e)))
title('{\sigma}_{s} = 16, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_1_10 .* ((F + e)./(bf_f_1_10 + e)))
title('{\sigma}_{s} = 1, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_2_10 .* ((F + e)./(bf_f_2_10 + e)))
title('{\sigma}_{s} = 2, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_4_10 .* ((F + e)./(bf_f_4_10 + e)))
title('{\sigma}_{s} = 4, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_8_10 .* ((F + e)./(bf_f_8_10 + e)))
title('{\sigma}_{s} = 8, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_16_10 .* ((F + e)./(bf_f_16_10 + e)))
title('{\sigma}_{s} = 16, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_1_15 .* ((F + e)./(bf_f_1_15 + e)))
title('{\sigma}_{s} = 1, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_2_15 .* ((F + e)./(bf_f_2_15 + e)))
title('{\sigma}_{s} = 2, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_4_15 .* ((F + e)./(bf_f_4_15 + e)))
title('{\sigma}_{s} = 4, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_8_15 .* ((F + e)./(bf_f_8_15 + e)))
title('{\sigma}_{s} = 8, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_16_15 .* ((F + e)./(bf_f_16_15 + e)))
title('{\sigma}_{s} = 16, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_1_20 .* ((F + e)./(bf_f_1_20 + e)))
title('{\sigma}_{s} = 1, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_2_20 .* ((F + e)./(bf_f_2_20 + e)))
title('{\sigma}_{s} = 2, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_4_20 .* ((F + e)./(bf_f_4_20 + e)))
title('{\sigma}_{s} = 4, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_8_20 .* ((F + e)./(bf_f_8_20 + e)))
title('{\sigma}_{s} = 8, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_16_20 .* ((F + e)./(bf_f_16_20 + e)))
title('{\sigma}_{s} = 16, {\sigma}_{r} = .20')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % whole image
figure()
tiledlayout(3,2)
nexttile(1)
imshow(data_noflash)
title('No-flash Image')
nexttile(2)
imshow(best_noflash)
title('Denoised No-flash Image')
nexttile(5)
imshow(data_flash)
title('Flash Image')
nexttile(6)
imshow(best_flash)
title('Denoised Flash Image')
nexttile(3, [1 2])
imshow(Af)
title('Fused Image')

% % cropped image
figure()
tiledlayout(3,2)
nexttile(1)
imshow(imcrop(data_noflash, cropsize))
title('No-flash Image, Cropped')
nexttile(2)
imshow(imcrop(best_noflash, cropsize))
title('Denoised No-flash Image, Cropped')
nexttile(5)
imshow(imcrop(data_flash, cropsize))
title('Flash Image, Cropped')
nexttile(6)
imshow(imcrop(best_flash, cropsize))
title('Denoised Flash Image, Cropped')
nexttile(3, [1 2])
imshow(imcrop(Af, cropsize))
title('Fused Image, Cropped')

% % comparison
figure()
tiledlayout(2,3)
nexttile(1)
imshow(imcrop(data_noflash, cropsize))
title('Original Image, Section 1')
nexttile(4)
imshow(imcrop(Af, cropsize))
title('Fused Image, Section 1')
nexttile(2)
imshow(imcrop(data_noflash, [650,350,200,200]))
title('Original Image, Section 2')
nexttile(5)
imshow(imcrop(Af, [650,350,200,200]))
title('Fused Image, Section 2')
nexttile(3)
imshow(data_noflash)
title('Original Image')
nexttile(6)
imshow(Af)
title('Fused Image')

% % % % % % % % % % % % % % % % % % % % % % % % 
% % LATER ANALYSIS (EPSILON TEST)

% % comparing epsilons
Af3 = Ad .* ((F + .3)./(Fd + .3));
Af2 = Ad .* ((F + .2)./(Fd + .2));
Af1 = Ad .* ((F + .1)./(Fd + .1));
Af05 = Ad .* ((F + .05)./(Fd + .05));

figure()
tiledlayout(4,1)
nexttile
imshow(imcrop(Af3, cropsize))
title('Fused image, {\sigma}_{s} = 4, {\sigma}_{r} = .05, {\epsilon} = .3')
nexttile
imshow(imcrop(Af2, cropsize))
title('Fused image, {\sigma}_{s} = 4, {\sigma}_{r} = .05, {\epsilon} = .2')
nexttile
imshow(imcrop(Af1, cropsize))
title('Fused image, {\sigma}_{s} = 4, {\sigma}_{r} = .05, {\epsilon} = .1')
nexttile
imshow(imcrop(data_noflash, cropsize))
title('Original Image')
