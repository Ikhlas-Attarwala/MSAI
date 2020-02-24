% C.P. HW #6 - VIDEO #1
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 2 - TEMPLATE MATCHING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%
% 2.1 - LOAD THE VIDEO
video1 = VideoReader('1.mp4');
frames1 = read(video1, [1 Inf]);
[col, row, c, num_frames] = size(frames1);
% size(frames1) >> 1280y 720x 3c, 260f

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.3 - SELECT APPROXIMATELY 60 FRAMES
% NOTE: I CHANGED THE ORDER OF 2.2 AND 2.3 (DISCUSSED IN PAPER WHY)
short1 = frames1(:,:,:,1:3:end);
num_short = size(short1, 4);
% num_short >> 87f

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.2 - CONVERT FRAMES TO GRAYSCALE
for f = 1:num_short
    grays1(:,:,f) = rgb2gray(short1(:,:,:,f));
end

%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.4 - SELECT A TEMPLATE
first_frame = grays1(:,:,1);

% water bottle
T1 = 70;
template1 = imcrop(first_frame, [260 480 T1-1 T1-1]);

% sketchbook
T2 = 100;
template2 = imcrop(first_frame, [450 480 T2-1 T2-1]);

% boxing gloves
T3 = 90;
template3 = imcrop(first_frame, [130 440 T3-1 T3-1]);

%%%%%%%%%%%%%%%%%%%%%%%
% 2.5 - SELECT A WINDOW

% this was used to observe about 30 photos to make sure my window
% was of an appopriate size:
% % % figure()
% % % tiledlayout(6,5)
% % % for i = 1:3:num_short
% % %     nexttile
% % %     imshow(window1(:,:,i))
% % % end

% water bottle
W1 = 600;
for i = 1:num_short
    window1(:,:,i) = imcrop(grays1(:,:,i), [60 425 W1-1 W1-1]);
end

% sketchbook
W2 = 500;
for i = 1:num_short
    window2(:,:,i) = imcrop(grays1(:,:,i), [300 400 W2-1 W2-1]);
end

% boxing gloves
W3 = 300;
for i = 1:num_short
    window3(:,:,i) = imcrop(grays1(:,:,i), [60 425 W3-1 W3-1]);
end

%%%%%%%%%%%%%%%%%%%%%%
% 2.6 - TEMPLATE MATCH
% PLEASE NOTE: PART 2.6 IS INSIDE THE FORMULA 'ncc' below

% the following code is tested but doesn't work because I couldn't
% get the sliding window to grab a template-sized mini-window from
% the first window. I ended up having to use a different function
% besides nlfilter... :/

% % % to_crop = im2double(windows);
% % % fun = @(x) imcrop(x, [1 1 89 89]);
% % % B = nlfilter(to_crop(:,:,1), [1,1], fun);
% % % montage({to_crop(:,:,1), B})

% % % I_hat = windows(:,:,1) - mean2(windows(:,:,1));
% % % T_hat = template - mean2(template);
% % % numerator = sum(I_hat .* T_hat);
% % % denominator = (sum(I_hat .^ 2) .* sum(T_hat .^ 2)) .^ .5;
% % % ncc = numerator ./ denominator;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 3 - SYNTHETIC APERTURE PHOTO
% PLEASE NOTE: PART 3 IS INSIDE THE FORMULA 'Synthethic Aperture' below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 4 - REFOCUS ON NEW OBJECTS
% ALREADY REFOCUSED ON 3 TEMPLATES (REPEATED PART 3 IN SHOW RESULTS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHOW RESULTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure()
imshow(first_frame)
imrect(gca, [260 480 T1-1 T1-1]);
imrect(gca, [450 480 T2-1 T2-1]);
imrect(gca, [130 440 T3-1 T3-1]);
title('These 3 templates were chosen from the first frame')

figure()
tiledlayout(2,3)
nexttile(1)
[y1, x1, res1] = ncc(template1, window1, T1);
plot(x1, y1, '-x')
title('Pixel shifts with template on WATER BOTTLE')
nexttile(4)
surf(res1), shading flat
nexttile(2)
[y2, x2, res2] = ncc(template2, window2, T2);
plot(x2, y2, '-x')
title('Pixel shifts with template on SKETCHBOOK')
nexttile(5)
surf(res2), shading flat
nexttile(3)
[y3, x3, res3] = ncc(template3, window3, T3);
plot(x3, y3, '-x')
title('Pixel shifts with template on BOXING GLOVES')
nexttile(6)
surf(res3), shading flat

figure()
tiledlayout(1,3)
nexttile
P1 = SyntheticAperture(short1, x1, y1);
imshow(P1)
title('Synthethic Aperture focused on WATER BOTTLE')
nexttile
P2 = SyntheticAperture(short1, x2, y2);
imshow(P2)
title('Synthethic Aperture focused on SKETCHBOOK')
nexttile
P3 = SyntheticAperture(short1, x3, y3);
imshow(P3)
title('Synthethic Aperture focused on BOXING GLOVES')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [y_shift, x_shift, res] = ncc(T,W,T_)
    frames = 87;
    for i = 1:frames
        res = normxcorr2(T, W(:,:,i));
        [y_peak, x_peak] = find(res == max(res(:)));
        y_off(i) = y_peak - T_;
        x_off(i) = x_peak - T_;
    end
    y_shift = y_off - y_off(1);
    x_shift = x_off - x_off(1);
end

function [P] = SyntheticAperture(images, dx, dy)
    frames = 87;
    for i = 1:frames
        synth(:,:,:,i) = imtranslate(images(:,:,:,i), [-dx(i), -dy(i)], 'FillValues', 255);
    end
    P = uint8(sum(synth,4) ./ frames);
end
