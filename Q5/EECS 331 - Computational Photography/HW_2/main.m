% path = '/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_2/photos/100/';
% 

t100 = Tiff('/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_2/photos/100/0.dng','r');
im100 = imcrop(read(t100), [1050,1040,549,549]);
im100_1 = imcrop(read(t100), [1050,1040,549,549]);
t500 = Tiff('/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_2/photos/500/0.dng','r');
im500 = imcrop(read(t500), [1050,1040,549,549]);
im500_1 = imcrop(read(t500), [1050,1040,549,549]);

% for low sensitivity
for i = 1:49
    path100 = '/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_2/photos/100/';
    load100 = strcat(path100, num2str(i), '.dng');
    t100 = Tiff(load100, 'r');
    cropped_im100 = imcrop(read(t100),[1050,1040,549,549]);
    im100(:,:,i+1) = cropped_im100;
end

% for high sensitivity
for i = 1:49
    path500 = '/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_2/photos/500/';
    load500 = strcat(path500, num2str(i), '.dng');
    t500 = Tiff(load500, 'r');
    cropped_im500 = imcrop(read(t500),[1050,1040,549,549]);
    im500(:,:,i+1) = cropped_im500;
end

% same dims as 500
[m,n,d] = size(im100); 

% for 50 images, calculate mean of each pixel in images
for i = 1:m
    for j = 1:n
        mean_arr100(i,j) = mean(im100(i,j,:));
        mean_arr500(i,j) = mean(im500(i,j,:));
    end
end
% this messes up the calculation (turns to int)
%         x = 0;
%         y = 0;
%         for k = 1:d
%             x = x + im100(i,j,k);
%             y = y + im500(i,j,k);
%         x = x / d;
%         y = y / d;
%         mean_arr100(i,j) = x;
%         mean_arr500(i,j) = y;

% for 50 images, calculate variance of each pixel in images
for i = 1:m
    for j = 1:n
        var_arr100(i,j) = sum((im100(i,j,:) - mean_arr100(i,j)).^2)/50;
        var_arr500(i,j) = sum((im500(i,j,:) - mean_arr500(i,j)).^2)/50;
    end
end

% calculate variance of the mean
% first round each mean value
roundedmean_arr100 = ceil(mean_arr100);
roundedmean_arr500 = ceil(mean_arr500);
% z100 = mean(reshape(mean_arr100, [1,m*n]));
% z500 = mean(reshape(mean_arr500, [1,m*n]));

% second calculate average variance per unique mean value
% 100s
empty_mean100 = [];
z = 0;
for i = 1:m
    for j = 1:n
%         thanks to deanna for solving computational complexity problems
        r = roundedmean_arr100(i,j);
        if not(ismember(r, empty_mean100))
            z = z + 1;
            [x,y] = find(roundedmean_arr100 == r);
            empty_mean100(z) = r;
            temp100 = [];
            for k = 1:length(x)
                temp100(k) = var_arr100(x(k),y(k));
            end
            empty_var100(z) = mean(temp100);
        end
    end
end

% 500s
empty_mean500 = [];
z = 0;
for i = 1:m
    for j = 1:n
%         thanks to deanna for solving computational complexity problems
        r = roundedmean_arr500(i,j);
        if not(ismember(r, empty_mean500))
            z = z + 1;
            [x,y] = find(roundedmean_arr500 == r);
            empty_mean500(z) = r;
            temp500 = [];
            for k = 1:length(x)
                temp500(k) = var_arr500(x(k),y(k));
            end
            empty_var500(z) = mean(temp500);
        end
    end
end

% PLOT EVERYTHING
pix1_100 = im100(100,100,:);
pix2_100 = im100(150,150,:);
pix3_100 = im100(200,200,:);
pix4_100 = im100(250,250,:);
pix5_100 = im100(300,300,:);
pix6_100 = im100(350,350,:);
pix7_100 = im100(400,400,:);
pix8_100 = im100(450,450,:);
pix9_100 = im100(500,500,:);

pix1_500 = im500(100,100,:);
pix2_500 = im500(150,150,:);
pix3_500 = im500(200,200,:);
pix4_500 = im500(250,250,:);
pix5_500 = im500(300,300,:);
pix6_500 = im500(350,350,:);
pix7_500 = im500(400,400,:);
pix8_500 = im500(450,450,:);
pix9_500 = im500(500,500,:);

% pix1_500 = im500(50,50,:);
% pix2_500 = im500(250,250,:);
% pix3_500 = im500(500,500,:);

% histogram

% low
figure()
b_1 = 10;
tiledlayout(3,3)
nexttile
histogram(pix1_100,b_1)
title('Pix 100,100')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix2_100,b_1)
title('Pix 150,150')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix3_100,b_1)
title('Pix 200,200')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix4_100,b_1)
title('Pix 250,250')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix5_100,b_1)
title('Pix 300,300')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix6_100,b_1)
title('Pix 350,350')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix7_100,b_1)
title('Pix 400,400')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix8_100,b_1)
title('Pix 450,450')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix9_100,b_1)
title('Pix 500,500')
ylabel('Counts')
xlabel('Pixel Intensity')

% high
figure()
b_1 = 10;
tiledlayout(3,3)
nexttile
histogram(pix1_500,b_1)
title('Pix 100,100')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix2_500,b_1)
title('Pix 150,150')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix3_500,b_1)
title('Pix 200,200')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix4_500,b_1)
title('Pix 250,250')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix5_500,b_1)
title('Pix 300,300')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix6_500,b_1)
title('Pix 350,350')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix7_500,b_1)
title('Pix 400,400')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix8_500,b_1)
title('Pix 450,450')
ylabel('Counts')
xlabel('Pixel Intensity')
nexttile
histogram(pix9_500,b_1)
title('Pix 500,500')
ylabel('Counts')
xlabel('Pixel Intensity')

% sens & mean & variance
figure()
tiledlayout(4,2)
nexttile
imagesc(im100_1)
title('Low Sens. (100) Img# 1')
colorbar
nexttile
imagesc(cropped_im100)
title('Low Sens. (100) Img# 50')
colorbar
nexttile
imagesc(im500_1)
title('High Sens. (500) Img# 1')
colorbar
nexttile
imagesc(cropped_im500)
title('High Sens. (500) Img# 50')
colorbar
nexttile
imagesc(mean_arr100)
title('Mean Low Sens. (100)')
colorbar
nexttile
imagesc(mean_arr500)
title('Mean High Sens. (500)')
colorbar
nexttile
imagesc(var_arr100)
title('Variance Low Sens. (100)')
colorbar
nexttile
imagesc(var_arr500)
title('Variance High Sens. (500)')
colorbar

% QUESTION #5
figure()
tiledlayout(3,2)

nexttile
    scatter(empty_mean100, empty_var100, 5, 'filled')
p1 = polyfit(empty_mean100, empty_var100, 1);
y1 = polyval(p1, [0:2200]);
hold on
plot([0:2200], y1)
title('Low Sensitivity (100)')
ylabel('Variance')
xlabel('Mean Intensity')
legend({'data', 'linear fit'}, 'location', 'southeast')

nexttile
scatter(empty_mean500, empty_var500, 5, 'filled')
p2 = polyfit(empty_mean500, empty_var500, 1);
y2 = polyval(p2, [0:6000]);
hold on
plot([0:6000], y2)
title('High Sensitivity (500)')
ylabel('Variance')
xlabel('Mean Intensity')
legend({'data', 'linear fit'}, 'location', 'southeast')

SNR_100 = empty_mean100./empty_var100;
nexttile
scatter(empty_mean100, SNR_100, 5, 'filled')
title('Low Sensitivity (100)')
ylabel('SNR')
xlabel('Mean Intensity')

SNR_500 = empty_mean500./empty_var500;
nexttile
scatter(empty_mean500, SNR_500, 5, 'filled')
title('High Sensitivity (500)')
ylabel('SNR')
xlabel('Mean Intensity')
nexttile
scatter(empty_var100, SNR_100, 5, 'filled')
title('Low Sensitivity (100)')
ylabel('SNR')
xlabel('Variance')
nexttile
scatter(empty_var500, SNR_500, 5, 'filled')
title('High Sensitivity (500)')
ylabel('SNR')
xlabel('Variance')


% calculating read/adc

% ?^2(i) = µ(i)*g + ?^2(read)*g^2 + ?^2(ADC)
% (HIGHint-LOWint) / (HIGHslope^2 - LOWslope^2) = read
% (HIGHint-read*HIGHslope^2)

read = (p2(2) - p1(2)) ./ (p2(1).^2 - p1(1).^2);
adc = p2(2) - read .* p2(1).^2;

            % test3 = 10*im100;
% test4 = 50*im500;
% 
% for i = 1:m
% for j = 1:n
% mean_test3(i,j) = mean(test3(i,j,:));
% mean_test4(i,j) = mean(test4(i,j,:));
% end
% end
% 
% for i = 1:m
% for j = 1:n
% var_test3(i,j) = sum((test3(i,j,:) - mean_test3(i,j)).^2)/50;
% var_test4(i,j) = sum((test4(i,j,:) - mean_test4(i,j)).^2)/50;
% end
% end
% 
% % read variance 100
% read_100 = mean(mean(var_test3));
% % read variance 500
% read_500 = mean(mean(var_test4));
% 
% % adc variance 100
% adc_100 = p1(1)*read_100;
% % adc variance 500
% adc_500 = p2(1)*read_500;
% 
