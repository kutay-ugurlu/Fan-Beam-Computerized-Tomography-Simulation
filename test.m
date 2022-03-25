%% Test Script
N_detectors = 400;
L_detector = 100*pi;
source2det_dist = 75;
projection_angle_step_size = .5;
phantom_name = 'square';

%% Square
Image = load('SheppLogan.mat');
fields = fieldnames(Image);
Image = Image.(fields{1});
[M,~] = size(Image);
[PROJECTIONS, gammas] = radon_project(phantom_name,L_detector, N_detectors, projection_angle_step_size, source2det_dist);
[ImageBack] = filtered_back_projection_hamm(M, M, PROJECTIONS, L_detector, source2det_dist, N_detectors);
colormap gray
subplot(1,3,1)
imagesc(Image)
title('Phantom')
colormap gray
subplot(1,3,2)
imagesc(PROJECTIONS)
title('Projections')
colormap gray
subplot(1,3,3)
imagesc(ImageBack)
title('Reconstruction')
sgtitle('Fan Beam')
colormap gray
