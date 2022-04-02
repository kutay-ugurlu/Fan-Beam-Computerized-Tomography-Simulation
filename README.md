# Fan-Beam-Computerized-Tomography-Simulation
# EE519 Medical Imaging Project
The developed code here is forked from this [repo](https://github.com/kutay-ugurlu/Parallel-Beam-Computerized-Tomography-Simulation).
## Implementation 
The project consists of 2 main scripts: [radon_project.m](https://github.com/kutay-ugurlu/Fan-Beam-Computerized-Tomography-Simulation/blob/master/radon_project.m) and [back_projection.m](https://github.com/kutay-ugurlu/Fan-Beam-Computerized-Tomography-Simulation/blob/master/back_projection.m). The remaining filtered back projections scripts are basicly convolution wrapper for backprojection script.
## Graphical User Interface
### Usage
![GUI](https://user-images.githubusercontent.com/83376963/161386161-d81b9f70-cfc5-4bc8-9726-36c719087eba.png)
#### Projection
* The interface requires the phantom path input as relative input to the MATLAB app directory. 
* Set the required parameters numerically.
* Press the <ins>PROJECT</ins> button.
#### Back Projection
* After the projection step is complete, the projection data is stored in the current working directory.
* Choose the Convolution Back Projection reconstruction filter.

| :warning: INFO & WARNINGS  |
|:---------------------------|
| Use "." for decimal seperator. | 
| Checking the __Delete Projections when quitting__ box will delete all the available projections generated while the app runs. Make sure to uncheck it if you want to reuse them.| 

### An example tutorial 
![GUI Example](https://user-images.githubusercontent.com/83376963/161386142-7ca3844d-2933-4976-9893-b8caa940af0a.png)
