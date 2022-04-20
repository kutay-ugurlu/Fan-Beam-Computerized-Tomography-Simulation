%% Sample outputs
close all; clear; clc;

sample_names = ["Phantoms/lena","Phantoms/SheppLogan","Phantoms/square", "Phantoms/squarecircle"];
projection_angle_step_size = 2;
N_detectors = 71;
for sample = sample_names
    I = struct2array(load(sample));
    [RowNumber_I, ColumnNumber_I] = size(I);
    L_detector = RowNumber_I * sqrt(3);
    source2det_dist = L_detector;
    folder_file = split(sample,'/');
    phantom_name = folder_file{2};
    [PROJECTIONS, ~] = radon_project(sample,L_detector, N_detectors, projection_angle_step_size, source2det_dist);
    RI = (back_projection(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
    RH = (filtered_back_projection_hamm(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
    figure('Position', [500, 100, 500, 650]); % To adjust figsizeclear
    subplot(3,2,1)
    imagesc(I), colormap gray
    title('Original Phantom')
    subplot(3,2,2)
    plot(PROJECTIONS(:,135))
    title('Projection at 0\circ')
    xlabel('Beams')
    ylabel('Intensity')
    subplot(3,2,3)
    plot(PROJECTIONS(:,158))
    title('Projection at 45\circ')
    xlabel('Beams')
    ylabel('Intensity')
    subplot(3,2,4)
    plot(PROJECTIONS(:,180))
    title('Projection at 90\circ')
    xlabel('Beams')
    ylabel('Intensity')
    subplot(3,2,5)
    imagesc(RI), colormap gray
    title('Backprojected Image')
    subplot(3,2,6)
    imagesc(RH), colormap gray
    title('Filtered Backprojected Image')
end
