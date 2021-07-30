%% FILTERED BACK PROJECTION 

function [Image] = filtered_back_projection(RowNumber_I, ColumnNumber_I, PROJECTIONS)
[angles, L_c] = size(PROJECTIONS); % L_c : length of columns
PROJECTIONS = transpose(PROJECTIONS);
%% First filter the projections, then call back_projection.m script.
% For now, filter is set to ramp. Then, filter is designed in frequency
% domain and inverse FFT of it is taken to convolve the filter and
% projections in space domain. 

ramp = [0 1:50 50:-1:1]; % Ram-Lak

%% Different Filters
% To apply the selected filter, the user can just uncomment lines
% regarding that filter.

% w = window(@hamming, 100);
% ramp = ramp .* [0 fftshift(w')];    

% w = window(@barthannwin, 100);
% ramp = ramp .* [0 fftshift(w')];  

%% Filtering the projections in a loop through the columns of Projections Matrix
% The filter is convolved with the projections for a fixed angle.
filter_f = fftshift(transpose(ifft(ramp)));
for i = 1:angles
    column = PROJECTIONS(:,i);
    filtered_column = conv(filter_f, column);
    if mod(length(filtered_column),2) == 1 
        filtered_column = [filtered_column; 0];
    end
    first_idx = ceil(0.5*(length(filtered_column)-L_c));
    filtered_column = filtered_column(first_idx:first_idx+L_c-1);
    PROJECTIONS(:,i) = filtered_column;
end
PROJECTIONS = transpose(PROJECTIONS);
Image = back_projection(RowNumber_I, ColumnNumber_I, PROJECTIONS);
end

