% C.P. HW #5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 2 - CALIBRATE FOCAL STACK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load yunhao images
path = '/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_5/images/';
N = 30;
x = 480;
y = 640;
for k = 1:N
%   load
    focal_dist(k) = (k-1)*.3+.9666667;
    load = strcat(path, num2str(k), '.jpg');
    data = imresize(imread(load), [x y]);
%   I
    I(:,:,:,k) = data;
%   vk
    v(k) = focal_dist(k);
%     v(k) = focal_dist(k) ./ 100;
%   uk
    u(k) = 1 ./ (1/(2.95/1000) - 1./v(k));
end

for k = 1:N
%   mk
    m(k) = u(N) ./ u(k);
end

for k = 1:N
%   mag factor is greater than 1
    m_fac(k) = 1.0 + m(N) - m(k);
%   compute I'
    for i = 1:x
        for j = 1:y
            xi = round(m_fac(k)*i);
            if xi > x
                xi = x;
            end
            yj = round(m_fac(k)*j);
            if yj > y
                yj = y;
            end
%             I_rescaled(i,i,:,k+1) = I(m(k+1) .* i, m(k+1) .* j, :, k+1);
            I_rescaled(i,j,:,k) = I(xi,yj,:,k);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 3 - COMPUTE DEPTH MAP & DEPTH INDEX MAP
% PLEASE NOTE: PART 3 IS INSIDE 'formula.m'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
kernel = [1,4,1; 4,-20,4; 1,4,1];
kernel = kernel ./ 6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 4 - RECOVER ALL-FOCUS IMAGE
% PLEASE NOTE: PART 4 IS INSIDE 'formula.m'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHOW RESULTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure()
tiledlayout(3,3)

[D, Map, A] = formula(I_rescaled, 5, kernel);
nexttile
imshow(D)
title('Depth Map, K = 5')
nexttile
imshow(uint8(Map))
title('Depth Index Map, K = 5')
nexttile
imshow(A)
title('All-Focus Image, K = 5')

[D, Map, A] = formula(I_rescaled, 20, kernel);
nexttile
imshow(D)
title('Depth Map, K = 20')
nexttile
imshow(uint8(Map))
title('Depth Index Map, K = 20')
nexttile
imshow(A)
title('All-Focus Image, K = 20')

[D, Map, A] = formula(I_rescaled, 30, kernel);
nexttile
imshow(D)
title('Depth Map, K = 30')
nexttile
imshow(uint8(Map))
title('Depth Index Map, K = 30')
nexttile
imshow(A)
title('All-Focus Image, K = 30')

figure()
tiledlayout(2,1)
[D, Map, A] = formula(I_rescaled, 50, kernel);
nexttile
imshow(I(:,:,:,10))
title('An example original image')
nexttile
imshow(A)
title('All-Focus Image, K = 50')

figure()
tiledlayout(1,3)
nexttile
[D, Map, A] = formula(I_rescaled, 5, kernel);
imshow(A)
title('All-Focus Image, K = 5')
nexttile
[D, Map, A] = formula(I_rescaled, 30, kernel);
imshow(A)
title('All-Focus Image, K = 30')
nexttile
[D, Map, A] = formula(I_rescaled, 50, kernel);
imshow(A)
title('All-Focus Image, K = 50')

