% C.P. HW #3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load no-flash image, resize it as 768x1024, and transform into double
img_noflash = '/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_3/rot_noflash.jpg';
data_noflash = imread(img_noflash);
res_noflash = imresize(data_noflash, [1024 768]);
res_noflash = im2double(res_noflash);
res_noflash_cropped = imcrop(res_noflash, [250,500,400,400]);

% RGB channels for no-flash image
r_noflash = res_noflash(:,:,1);
g_noflash = res_noflash(:,:,2);
b_noflash = res_noflash(:,:,3);

% crop above channels, only for subplotting because it's easier to see
% NOTE: We won't use the cropped image for final, only the setting
r_cropped_noflash = imcrop(r_noflash, [250,500,400,400]);
g_cropped_noflash = imcrop(g_noflash, [250,500,400,400]);
b_cropped_noflash = imcrop(b_noflash, [250,500,400,400]);

% denoising no-flash image
bf_no_1_05 = cat(3, bilateralFilter(r_cropped_noflash, 1, .05), bilateralFilter(g_cropped_noflash, 1, .05), bilateralFilter(b_cropped_noflash, 1, .05));
bf_no_1_10 = cat(3, bilateralFilter(r_cropped_noflash, 1, .10), bilateralFilter(g_cropped_noflash, 1, .10), bilateralFilter(b_cropped_noflash, 1, .10));
bf_no_1_15 = cat(3, bilateralFilter(r_cropped_noflash, 1, .15), bilateralFilter(g_cropped_noflash, 1, .15), bilateralFilter(b_cropped_noflash, 1, .15));
bf_no_1_20 = cat(3, bilateralFilter(r_cropped_noflash, 1, .20), bilateralFilter(g_cropped_noflash, 1, .20), bilateralFilter(b_cropped_noflash, 1, .20));
bf_no_1_25 = cat(3, bilateralFilter(r_cropped_noflash, 1, .25), bilateralFilter(g_cropped_noflash, 1, .25), bilateralFilter(b_cropped_noflash, 1, .25));
bf_no_4_05 = cat(3, bilateralFilter(r_cropped_noflash, 4, .05), bilateralFilter(g_cropped_noflash, 4, .05), bilateralFilter(b_cropped_noflash, 4, .05));
bf_no_4_10 = cat(3, bilateralFilter(r_cropped_noflash, 4, .10), bilateralFilter(g_cropped_noflash, 4, .10), bilateralFilter(b_cropped_noflash, 4, .10));
bf_no_4_15 = cat(3, bilateralFilter(r_cropped_noflash, 4, .15), bilateralFilter(g_cropped_noflash, 4, .15), bilateralFilter(b_cropped_noflash, 4, .15));
bf_no_4_20 = cat(3, bilateralFilter(r_cropped_noflash, 4, .20), bilateralFilter(g_cropped_noflash, 4, .20), bilateralFilter(b_cropped_noflash, 4, .20));
bf_no_4_25 = cat(3, bilateralFilter(r_cropped_noflash, 4, .25), bilateralFilter(g_cropped_noflash, 4, .25), bilateralFilter(b_cropped_noflash, 4, .25));
bf_no_16_05 = cat(3, bilateralFilter(r_cropped_noflash, 16, .05), bilateralFilter(g_cropped_noflash, 16, .05), bilateralFilter(b_cropped_noflash, 16, .05));
bf_no_16_10 = cat(3, bilateralFilter(r_cropped_noflash, 16, .10), bilateralFilter(g_cropped_noflash, 16, .10), bilateralFilter(b_cropped_noflash, 16, .10));
bf_no_16_15 = cat(3, bilateralFilter(r_cropped_noflash, 16, .15), bilateralFilter(g_cropped_noflash, 16, .15), bilateralFilter(b_cropped_noflash, 16, .15));
bf_no_16_20 = cat(3, bilateralFilter(r_cropped_noflash, 16, .20), bilateralFilter(g_cropped_noflash, 16, .20), bilateralFilter(b_cropped_noflash, 16, .20));
bf_no_16_25 = cat(3, bilateralFilter(r_cropped_noflash, 16, .25), bilateralFilter(g_cropped_noflash, 16, .25), bilateralFilter(b_cropped_noflash, 16, .25));
bf_no_64_05 = cat(3, bilateralFilter(r_cropped_noflash, 64, .05), bilateralFilter(g_cropped_noflash, 64, .05), bilateralFilter(b_cropped_noflash, 64, .05));
bf_no_64_10 = cat(3, bilateralFilter(r_cropped_noflash, 64, .10), bilateralFilter(g_cropped_noflash, 64, .10), bilateralFilter(b_cropped_noflash, 64, .10));
bf_no_64_15 = cat(3, bilateralFilter(r_cropped_noflash, 64, .15), bilateralFilter(g_cropped_noflash, 64, .15), bilateralFilter(b_cropped_noflash, 64, .15));
bf_no_64_20 = cat(3, bilateralFilter(r_cropped_noflash, 64, .20), bilateralFilter(g_cropped_noflash, 64, .20), bilateralFilter(b_cropped_noflash, 64, .20));
bf_no_64_25 = cat(3, bilateralFilter(r_cropped_noflash, 64, .25), bilateralFilter(g_cropped_noflash, 64, .25), bilateralFilter(b_cropped_noflash, 64, .25));

% testing different bilateral filters on no-flash image
figure()
tiledlayout(4,5)
nexttile
imshow(bf_no_1_05)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_1_10)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_1_15)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_1_20)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_1_25)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .25')
nexttile
imshow(bf_no_4_05)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_4_10)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_4_15)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_4_20)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_4_25)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .25')
nexttile
imshow(bf_no_16_05)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_16_10)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_16_15)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_16_20)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_16_25)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .25')
nexttile
imshow(bf_no_64_05)
title('{\sigma}_{s} = 64, {\sigma}_{r} = .05')
nexttile
imshow(bf_no_64_10)
title('{\sigma}_{s} = 64, {\sigma}_{r} = .10')
nexttile
imshow(bf_no_64_15)
title('{\sigma}_{s} = 64, {\sigma}_{r} = .15')
nexttile
imshow(bf_no_64_20)
title('{\sigma}_{s} = 64, {\sigma}_{r} = .20')
nexttile
imshow(bf_no_64_25)
title('{\sigma}_{s} = 64, {\sigma}_{r} = .25')

% RESULT: 'bf_no_4_05' HAS THE BEST DENOISED RESULT
best_noflash = cat(3, bilateralFilter(r_noflash, 4, .05), bilateralFilter(g_noflash, 4, .05), bilateralFilter(b_noflash, 4, .05));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load flash image, resize it as 768x1024, and transform into double
img_flash = '/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_3/rot_flash.jpg';
data_flash = imread(img_flash);
res_flash = imresize(data_flash, [1024 768]);
res_flash = im2double(res_flash);
res_flash_cropped = imcrop(res_flash, [250,500,400,400]);

% RGB channels for flash image
r_flash = res_flash(:,:,1);
g_flash = res_flash(:,:,2);
b_flash = res_flash(:,:,3);

% crop above channels, only for subplotting because it's easier to see
% NOTE: We won't use the cropped image for final, only the setting
r_cropped_flash = imcrop(r_flash, [250,500,400,400]);
g_cropped_flash = imcrop(g_flash, [250,500,400,400]);
b_cropped_flash = imcrop(b_flash, [250,500,400,400]);

% denoising flash image
bf_f_1_05 = cat(3, bilateralFilter(r_cropped_flash, 1, .05), bilateralFilter(g_cropped_flash, 1, .05), bilateralFilter(b_cropped_flash, 1, .05));
bf_f_1_10 = cat(3, bilateralFilter(r_cropped_flash, 1, .10), bilateralFilter(g_cropped_flash, 1, .10), bilateralFilter(b_cropped_flash, 1, .10));
bf_f_1_15 = cat(3, bilateralFilter(r_cropped_flash, 1, .15), bilateralFilter(g_cropped_flash, 1, .15), bilateralFilter(b_cropped_flash, 1, .15));
bf_f_1_20 = cat(3, bilateralFilter(r_cropped_flash, 1, .20), bilateralFilter(g_cropped_flash, 1, .20), bilateralFilter(b_cropped_flash, 1, .20));
bf_f_1_25 = cat(3, bilateralFilter(r_cropped_flash, 1, .25), bilateralFilter(g_cropped_flash, 1, .25), bilateralFilter(b_cropped_flash, 1, .25));
bf_f_4_05 = cat(3, bilateralFilter(r_cropped_flash, 4, .05), bilateralFilter(g_cropped_flash, 4, .05), bilateralFilter(b_cropped_flash, 4, .05));
bf_f_4_10 = cat(3, bilateralFilter(r_cropped_flash, 4, .10), bilateralFilter(g_cropped_flash, 4, .10), bilateralFilter(b_cropped_flash, 4, .10));
bf_f_4_15 = cat(3, bilateralFilter(r_cropped_flash, 4, .15), bilateralFilter(g_cropped_flash, 4, .15), bilateralFilter(b_cropped_flash, 4, .15));
bf_f_4_20 = cat(3, bilateralFilter(r_cropped_flash, 4, .20), bilateralFilter(g_cropped_flash, 4, .20), bilateralFilter(b_cropped_flash, 4, .20));
bf_f_4_25 = cat(3, bilateralFilter(r_cropped_flash, 4, .25), bilateralFilter(g_cropped_flash, 4, .25), bilateralFilter(b_cropped_flash, 4, .25));
bf_f_16_05 = cat(3, bilateralFilter(r_cropped_flash, 16, .05), bilateralFilter(g_cropped_flash, 16, .05), bilateralFilter(b_cropped_flash, 16, .05));
bf_f_16_10 = cat(3, bilateralFilter(r_cropped_flash, 16, .10), bilateralFilter(g_cropped_flash, 16, .10), bilateralFilter(b_cropped_flash, 16, .10));
bf_f_16_15 = cat(3, bilateralFilter(r_cropped_flash, 16, .15), bilateralFilter(g_cropped_flash, 16, .15), bilateralFilter(b_cropped_flash, 16, .15));
bf_f_16_20 = cat(3, bilateralFilter(r_cropped_flash, 16, .20), bilateralFilter(g_cropped_flash, 16, .20), bilateralFilter(b_cropped_flash, 16, .20));
bf_f_16_25 = cat(3, bilateralFilter(r_cropped_flash, 16, .25), bilateralFilter(g_cropped_flash, 16, .25), bilateralFilter(b_cropped_flash, 16, .25));
bf_f_64_05 = cat(3, bilateralFilter(r_cropped_flash, 64, .05), bilateralFilter(g_cropped_flash, 64, .05), bilateralFilter(b_cropped_flash, 64, .05));
bf_f_64_10 = cat(3, bilateralFilter(r_cropped_flash, 64, .10), bilateralFilter(g_cropped_flash, 64, .10), bilateralFilter(b_cropped_flash, 64, .10));
bf_f_64_15 = cat(3, bilateralFilter(r_cropped_flash, 64, .15), bilateralFilter(g_cropped_flash, 64, .15), bilateralFilter(b_cropped_flash, 64, .15));
bf_f_64_20 = cat(3, bilateralFilter(r_cropped_flash, 64, .20), bilateralFilter(g_cropped_flash, 64, .20), bilateralFilter(b_cropped_flash, 64, .20));
bf_f_64_25 = cat(3, bilateralFilter(r_cropped_flash, 64, .25), bilateralFilter(g_cropped_flash, 64, .25), bilateralFilter(b_cropped_flash, 64, .25));

% testing different bilateral filters on no-flash image
figure()
tiledlayout(4,5)
nexttile
imshow(bf_f_1_05)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .05')
nexttile
imshow(bf_f_1_10)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .10')
nexttile
imshow(bf_f_1_15)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .15')
nexttile
imshow(bf_f_1_20)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .20')
nexttile
imshow(bf_f_1_25)
title('{\sigma}_{s} = 1, {\sigma}_{r} = .25')
nexttile
imshow(bf_f_4_05)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .05')
nexttile
imshow(bf_f_4_10)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .10')
nexttile
imshow(bf_f_4_15)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .15')
nexttile
imshow(bf_f_4_20)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .20')
nexttile
imshow(bf_f_4_25)
title('{\sigma}_{s} = 4, {\sigma}_{r} = .25')
nexttile
imshow(bf_f_16_05)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .05')
nexttile
imshow(bf_f_16_10)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .10')
nexttile
imshow(bf_f_16_15)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .15')
nexttile
imshow(bf_f_16_20)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .20')
nexttile
imshow(bf_f_16_25)
title('{\sigma}_{s} = 16, {\sigma}_{r} = .25')
nexttile
imshow(bf_f_64_05)
title('{\sigma}_{s} = 64, {\sigma}_{r} = .05')
nexttile
imshow(bf_f_64_10)
title('{\sigma}_{s} = 64, {\sigma}_{r} = .10')
nexttile
imshow(bf_f_64_15)
title('{\sigma}_{s} = 64, {\sigma}_{r} = .15')
nexttile
imshow(bf_f_64_20)
title('{\sigma}_{s} = 64, {\sigma}_{r} = .20')
nexttile
imshow(bf_f_64_25)
title('{\sigma}_{s} = 64, {\sigma}_{r} = .25')

% RESULT: 'bf_f_4_05' HAS THE BEST DENOISED RESULT (same sett. as before)
best_flash = cat(3, bilateralFilter(r_flash, 4, .05), bilateralFilter(g_flash, 4, .05), bilateralFilter(b_flash, 4, .05));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUSION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Formula: Af = Ad .* ((F + e)./(Fd + e))

% Ad = perfect de-noised no-flash image
Ad = best_noflash;
% F = original flash image
F = res_flash;
% Fd = perfect de-noised flash image
Fd = best_flash;
% e/epsilon = to make sure denominator doesn't hit 0.
e = 0.2;
% Af = fused image result
Af = Ad .* ((F + e)./(Fd + e));

% whole image
figure()
tiledlayout(2,4)
nexttile(1)
imshow(res_noflash)
title('No-flash Image')
nexttile(2)
imshow(best_noflash)
title('Denoised No-flash Image')
nexttile(5)
imshow(res_flash)
title('Flash Image')
nexttile(6)
imshow(best_flash)
title('Denoised Flash Image')
nexttile(3, [2 2])
imshow(Af)
title('Fused Image')

% cropped image
figure()
tiledlayout(2,4)
nexttile(1)
imshow(imcrop(res_noflash, [250,500,400,400]))
title('No-flash Image, Cropped')
nexttile(2)
imshow(bf_no_4_05)
title('Denoised No-flash Image, Cropped')
nexttile(5)
imshow(imcrop(res_flash, [250,500,400,400]))
title('Flash Image, Cropped')
nexttile(6)
imshow(bf_f_4_05)
title('Denoised Flash Image, Cropped')
nexttile(3, [2 2])
imshow(imcrop(Af, [250,500,400,400]))
title('Fused Image, Cropped')



% % % % % % % % % % % % % % % % % % % % % % % % 
% LATER ANALYSIS

% bf_no_4_075 = cat(3, bilateralFilter(r_cropped_noflash, 4, .075), bilateralFilter(g_cropped_noflash, 4, .075), bilateralFilter(b_cropped_noflash, 4, .075));
% bf_f_4_075 = cat(3, bilateralFilter(r_cropped_flash, 4, .075), bilateralFilter(g_cropped_flash, 4, .075), bilateralFilter(b_cropped_flash, 4, .075));

% BEST IMAGE I COULD COME UP WITH:
five = cat(3, bilateralFilter(r_noflash, 4, .05), bilateralFilter(g_noflash, 4, .05), bilateralFilter(b_noflash, 4, .05));
ten =  cat(3, bilateralFilter(r_flash,   4, .10), bilateralFilter(g_flash,   4, .10), bilateralFilter(b_flash,   4, .10));

figure()
tiledlayout(1,2)
nexttile
imshow(bf_no_4_05 .* ((res_flash_cropped + e)./(bf_f_4_10 + e)))
title('{\sigma}_{s} = 4, {\sigma}_{r} = .05(no-flash) / .10(flash), cropped')
nexttile
imshow(five .* ((res_flash + e)./(ten + e)))
title('{\sigma}_{s} = 4, {\sigma}_{r} = .05(no-flash) / .10(flash)')

% comparing epsilons
Af2 = Ad .* ((F + .2)./(Fd + .2));
Af1 = Ad .* ((F + .1)./(Fd + .1));
Af05 = Ad .* ((F + .05)./(Fd + .05));

figure()
tiledlayout(1,3)
nexttile
imshow(imcrop(Af2, [250,500,400,400]))
title('Fused image, {\sigma}_{s} = 4, {\sigma}_{r} = .05, {\epsilon} = .2')
nexttile
imshow(imcrop(Af1, [250,500,400,400]))
title('Fused image, {\sigma}_{s} = 4, {\sigma}_{r} = .05, {\epsilon} = .1')
nexttile
imshow(imcrop(Af05, [250,500,400,400]))
title('Fused image, {\sigma}_{s} = 4, {\sigma}_{r} = .05, {\epsilon} = .05')


