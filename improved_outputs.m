%% Sample outputs
close all; clear; clc;

sample_names = ["Phantoms/lena","Phantoms/SheppLogan","Phantoms/square", "Phantoms/squarecircle"];
projection_angle_step_size = 0.5;
N_detectors = 200;
for sample = sample_names
    I = struct2array(load(sample));
    [RowNumber_I, ColumnNumber_I] = size(I);
    L_detector = RowNumber_I * sqrt(3);
    source2det_dist = L_detector;
    folder_file = split(sample,'/');
    phantom_name = folder_file{2};
    [PROJECTIONS, ~] = radon_project(sample,L_detector, N_detectors, projection_angle_step_size, source2det_dist);
    RI = (back_projection(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
    RR = (filtered_back_projection_ram(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
    RH = (filtered_back_projection_hamm(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
    figure
    subplot(1,3,1)
    imagesc(RI), colormap gray
    title('Backprojected Image')
    subplot(1,3,2)
    imagesc((RR)), colormap gray
    title('Ram-Lak Filtered Backprojected Image')
    subplot(1,3,3)
    imagesc((RH)), colormap gray
    title('Hamming Filtered Backprojected Image')
end
