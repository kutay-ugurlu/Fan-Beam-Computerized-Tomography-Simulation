%% Test Script
N_detectors = 200;
L_detector = 50;
source2det_dist = 300;
projection_angle_step_size = 0.1;

%% Square
Image = load('square_circle.mat');
fields = fieldnames(Image);
Image = Image.(fields{1});
[M,~] = size(Image);
[PROJECTIONS, gammas] = radon_project(Image,L_detector, N_detectors, projection_angle_step_size, source2det_dist);
[ImageBack] = back_projection(M, M, PROJECTIONS, source2det_dist);
subplot(1,3,1)
imagesc(Image)
title('Phantom')
subplot(1,3,2)
imagesc(PROJECTIONS)
title('Projections')
subplot(1,3,3)
imagesc(ImageBack)
title('Reconstruction')
sgtitle('Fan Beam')
figure
imagesc(radon(Image))
title('Radon Transform')
