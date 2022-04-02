%% Write the tests in for loop
clear; clc; close all;
N_detectors = 250;

%% Filter Table

F_T = array2table(zeros(4,4));
F_T.Properties.VariableNames = {'Filters','Shepp Logan', 'Square', 'Square Circle'};
F_T.Filters = ["No-filter";"Ram-Lak";"BartHann";"Hamming"];

%% Loop
phantom_names = ["Phantoms/SheppLogan","Phantoms/square","Phantoms/squarecircle"];
for phantom_name = phantom_names;
        folder_file = split(phantom_name,'/');
        col_name = find(phantom_name == phantom_names) + 1; % To skip Filter names column
        I = mat2gray(struct2array(load(phantom_name)));
        [RowNumber_I, ColumnNumber_I] = size(I);
        source2det_dist = RowNumber_I * sqrt(3);
        L_detector = source2det_dist;
        projection_angle_step_size = 1;

        [PROJECTIONS, ~] = radon_project(phantom_name,L_detector, N_detectors, projection_angle_step_size, source2det_dist);
        RI = mat2gray(back_projection(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        RI_similarity = ssim(I,RI);
        RI = mat2gray(filtered_back_projection_ram(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        RL_similarity = ssim(I,RI);
        RI = mat2gray(filtered_back_projection_bart(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        BH_similarity = ssim(I,RI);
        RI = mat2gray(filtered_back_projection_hamm(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        HM_similarity = ssim(I,RI);
        similarity_vec = ([RI_similarity, RL_similarity, BH_similarity, HM_similarity]);
        F_T.(col_name) = similarity_vec';
        F_T
end

table2latex(F_T,'Report/FiltersExperiment')

%% Angle Table

F_T = array2table(zeros(4,5));
F_T.Properties.VariableNames = {'Filter Names','2','1','0.5','0.25'};
F_T.("Filter Names") = ["No-filter";"Ram-Lak";"BartHann";"Hamming"];
angles = [2,1,0.5,0.25];
N_detectors = 250;

%% Loop
phantom_name = 'Phantoms/squarecircle';
for angle = angles
        I = mat2gray(struct2array(load(phantom_name)));
        [RowNumber_I, ColumnNumber_I] = size(I);
        source2det_dist = RowNumber_I * sqrt(3);
        L_detector = source2det_dist;

        [PROJECTIONS, ~] = radon_project(phantom_name,L_detector, N_detectors, angle, source2det_dist);
        RI = mat2gray(back_projection(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        RI_similarity = ssim(I,RI);
        RI = mat2gray(filtered_back_projection_ram(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        RL_similarity = ssim(I,RI);
        RI = mat2gray(filtered_back_projection_bart(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        BH_similarity = ssim(I,RI);
        RI = mat2gray(filtered_back_projection_hamm(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        HM_similarity = ssim(I,RI);
        similarity_vec = ([RI_similarity, RL_similarity, BH_similarity, HM_similarity]);
        F_T.(num2str(angle)) = similarity_vec';
        F_T
end

table2latex(F_T,'Report/AnglesExperiment')

%% Detectors Table

F_T = array2table(zeros(4,5));
F_T.Properties.VariableNames = {'Filter Names','50','75','150','300'};
F_T.("Filter Names") = ["No-filter";"Ram-Lak";"BartHann";"Hamming"];
N_detectorss = [50,75,150,300];
angle = 1;

%% Loop
phantom_name = 'Phantoms/square_circle';
for N_detectors = N_detectorss
        I = mat2gray(struct2array(load(phantom_name)));
        [RowNumber_I, ColumnNumber_I] = size(I);
        source2det_dist = RowNumber_I * sqrt(3);
        L_detector = source2det_dist;

        [PROJECTIONS, ~] = radon_project(phantom_name,L_detector, N_detectors, angle, source2det_dist);
        RI = mat2gray(back_projection(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        RI_similarity = ssim(I,RI);
        RI = mat2gray(filtered_back_projection_ram(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        RL_similarity = ssim(I,RI);
        RI = mat2gray(filtered_back_projection_bart(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        BH_similarity = ssim(I,RI);
        RI = mat2gray(filtered_back_projection_hamm(RowNumber_I, ColumnNumber_I, PROJECTIONS, L_detector, source2det_dist, N_detectors));
        HM_similarity = ssim(I,RI);
        similarity_vec = ([RI_similarity, RL_similarity, BH_similarity, HM_similarity]);
        F_T.(num2str(N_detectors)) = similarity_vec';
        F_T
end

table2latex(F_T,'Report/NumberofDetectorsExperiment')