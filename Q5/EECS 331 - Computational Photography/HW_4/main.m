% C.P. HW #4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% random set of pixels (don't exceed 500 because image to be resized)
s = rng; % is this even working?
X = randi(1024, 500, 1);
r = rng; % is this even working?
Y = randi(768, 500, 1);

% load yunhao images
% path = '/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_4/images/image_YLi/';
% nanoseconds = [8601600, 17203200, 34406400, 68812800, 137625600, 275251200];
% seconds = nanoseconds ./ 1000.^3;

% load deanna images
path = '/Users/ikhlas/Northwestern/Q5/EECS 331 - Computational Photography/HW_4/images/THIRD SET/';
nanoseconds = [67200, 134400, 268800, 537600, 1075200, 2150400, 4300800, 8601600, 17203200, 34406400, 68812800, 137625600];
seconds = nanoseconds ./ 1000.^3;

% path into array 'imgs'
for j = 1:size(nanoseconds, 2)
    load = strcat(path, num2str(nanoseconds(j)), '.jpg');
    data = imresize(imread(load), [768 1024]);
    imgs(:,:,:,j) = data;
end

% # of pixels
for i = 1:size(X,1)
%   # of pictures
    for j = 1:size(seconds, 2)
%       # of channels
        for k = 1:3
            % Z[i,j] = pixel values of pixel location i in image j
            Z(i,j,k) = imgs(Y(i), X(i), k, j);
        end
    end
end

% g(Z[i,j]) = log exposure of Z[i,j]
% B[j] = log shutter speed for image j
Bj = log(seconds);
% l = amount of smoothness
l = [.1, 1, 5, 10];
for x = 1:size(l,2)
    for k = 1:3
%       g(Z[i,j]) = log exposure of Z[i,j]
        [g(:,k,x), lE(:,k,x)] = gsolve(Z(:,:,k), Bj, l(x));
    end
end

% show images
tiledlayout(3,4)
for j = 1:size(nanoseconds, 2)
    nexttile
    imshow(imgs(:,:,:,j))
    title(strcat('Exposure Time: ', num2str(seconds(j)), ' sec'))
end

% map camera response curves
figure()
tiledlayout(size(l, 2),3)
for x = 1:size(l,2)
    for k = 1:3
        nexttile
        for j = 1:size(Bj, 2)
            scatter(Bj(j) + lE(:,k,x), Z(:,j,k), 1, [0 0 0]);
            hold all
        end
        plot(g(:,k,x), 0:255, 'Linewidth', 2);
        if k == 1
            titleg = strcat('Red Channel, \lambda = ', num2str(l(x)));
        end
        if k == 2
            titleg = strcat('Green Channel, \lambda = ', num2str(l(x)));
        end
        if k == 3
            titleg = strcat('Blue Channel, \lambda = ', num2str(l(x)));
        end
        title(titleg)
        xlabel('Log Exposure, lE')
        ylabel('Pixel Value, Z[i,j]')
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for li = 1:size(l,2)
    for j = 1:size(nanoseconds, 2)
        for pixel_value = 1:256
            for k = 1:3
                [x,y] = find(imgs(:,:,k,j) == pixel_value);
                % [x,y,j,k] = find(imgs(:,:,k,j) == pixel_value);
                for s = 1:size(x,1)
                    % ln(E[i]) = 1/4(sum(g(z[i,j]) - ln(B[j])));
%                   NOTE: j/k index switch
                    rad_map(x(s), y(s), j, k, li) = g(pixel_value, k, li) - Bj(j);
                end
            end
        end
    end
end

% plot radiance image
% required sum(x,3) for 2d image representation
figure()
tiledlayout(size(l,2),3)
for li = 1:size(l,2)
    for k = 1:3
        for test = 1:3
            channels(:,:,test,li) = sum(rad_map(:,:,:,test,li), 3)/size(nanoseconds, 2);
        end
        channels = log10(exp(channels));
        
        nexttile
        chan_r = image(channels(:,:,k,li));
        chan_r.CDataMapping = 'scaled';
        if k == 1
            title(strcat('Red Channel', '\lambda = ', num2str(l(li))))
        end
        if k == 2
            title(strcat('Green Channel', '\lambda = ', num2str(l(li))))
        end
        if k == 3
            title(strcat('Blue Channel', '\lambda = ', num2str(l(li))))
        end
        axis off
        colorbar
    end
end

% TONE MAPPING

% channels seem the same across lambda values so don't worry??

% 1) uniform
E = 10.^channels;
Emin = min(min(min(E)));
Emax = max(max(max(E)));
Enorm = (E - Emin)./(Emax-Emin);

% plot RGB
figure()
tiledlayout(1,3)
for k = 1:3
    nexttile
    E_chan = image(Enorm(:,:,k))
    E_chan.CDataMapping = 'scaled';
    if k == 1
        title('Red Channel')
    end
    if k == 2
        title('Green Channel')
    end
    if k == 3
        title('Blue Channel')
    end
    colorbar
end

% 2) gamma curve
figure()
tiledlayout(4,2)
for gamma = [.1, .22857, .35714, .48571, .61429, .74286, .87143, 1]
    nexttile
    E_chan = image(Enorm(:,:,1).^gamma);
    E_chan.CDataMapping = 'scaled';
    title(strcat('Red Channel, gamma = ', num2str(gamma)))
    colorbar
end

% 3) reinhard['02]
% no time :/

