%% PART 2 : RECONSTRUCTION
% Inputs : Size of the image, Projection matrix.
% Outputs : Image

function [Image] = back_projection(RowNumber_I, ColumnNumber_I, PROJECTIONS, source2det_dist)
D = 0.5 * source2det_dist;
[angles, gamma] = size(PROJECTIONS);
PROJECTIONS = transpose(PROJECTIONS);
angle_step_size = 180/angles;
Image = zeros(RowNumber_I, ColumnNumber_I);
left_end = -0.5*RowNumber_I;
right_end = -1 * left_end;
X_grid = left_end : right_end;
Y_grid = X_grid;
thetas = deg2rad(0:angle_step_size:180-angle_step_size) ; 
beams = linspace(left_end*sqrt(2),right_end*sqrt(2),gamma);
for angle = 1:length(thetas)
    theta = thetas(angle);
    for ray = 1:length(beams)
        gamma = beams(ray);   
        %%
        % Creating intersection vectors for each angle using the equation
        % _t_ = cos($$ \  \theta $$)  _x_  +  sin($$ \  \theta $$)  _y_

        intersect_y = ((D*sin(gamma) - X_grid * cos(theta+gamma)) / sin(theta+gamma));
        intersect_x = ((D*sin(gamma) - Y_grid * sin(theta+gamma)) / cos(theta+gamma));
        %%
        % Putting the sorted intersections in a matrix where first column is x,
        % second is y and merge them: 
        INTERSECTS_x = [X_grid'  intersect_y'];
        INTERSECTS_y = [intersect_x'  Y_grid'];
        INTERSECTS_all = [INTERSECTS_x ; INTERSECTS_y];
        % INTERSECTS_all = sortrows(unique(INTERSECTS_all,'rows'));
        INTERSECTS_all = sortrows(uniquetol(INTERSECTS_all,'ByRows',1e-10));
        % The above line is for Lena

        %%
        % Discarding the intersections out of the grid by conditionally
        % selecting the rows
        INTERSECTS_all = INTERSECTS_all(INTERSECTS_all(:,1)>=left_end & INTERSECTS_all(:,1)<=right_end & INTERSECTS_all(:,2)>=left_end & INTERSECTS_all(:,2)<=right_end,:);
        %%
        % Assigning 0 projection value for 1 point intersections.
        if size(INTERSECTS_all,1) == 1
        continue
        end
        %%
        % Using Pisagor to compute distances travelled in pixels by
        % computing the $$ l_2 $$ norm row vectors of intersection matrix
        weights = vecnorm(diff(INTERSECTS_all),2,2); 
        %%
        % Arithmetic mean of consecutive elements to find mid point: To
        % find the mid point between consecutive intersections, 2 point
        % moving average is used with factor 0.5.
        midpoints_x = movsum(INTERSECTS_all(:,1),2) * 0.5;
        midpoints_y = movsum(INTERSECTS_all(:,2),2) * 0.5;
        
        %%
        % MATLAB function movesum padds a 0 to the beginning of the
        % vector. To get rid of this extra entry at the beginning, vectors
        % are sliced.
        % This block of code is problematic when there is 1 intersection. 
        % Hence, if block above is added.
        midpoints_y = midpoints_y(2:end); 
        midpoints_x = midpoints_x(2:end);
        
        %%
        % The pixels that beam passes through are found.
        row_pixel_indices = right_end - floor(midpoints_y);
        column_pixel_indices = right_end + ceil(midpoints_x);
      
        %%
        % Projections are weighted with the distances that the beam travels inside a pixel and the product is written on the relevant pixel.               
        for i = 1:length(column_pixel_indices)
            Image(row_pixel_indices(i),column_pixel_indices(i)) = Image(row_pixel_indices(i),column_pixel_indices(i)) + weights(i)*PROJECTIONS(ray, angle);
        end 
    end
end
end
