%% Setup

% set up structural model and load geometry
smodel = createpde('structural','static-solid');
importGeometry(smodel,'vertebra3.stl');
% plot faces
pdegplot(smodel, 'FaceLabels','on', 'FaceAlpha', 0.5);
% plot vertices (uncomment to plot)
% pdegplot(smodel, 'VertexLabels','on', 'FaceAlpha', 0.5);
% plot edges (uncomment to plot)
% pdegplot(smodel, 'EdgeLabels','on', 'FaceAlpha', 0.5);
%% Mesh

% generate mesh and plot
msh = generateMesh(smodel);
figure,pdemesh(msh);
%% Material Properties

% Set Material properties

% Cancellous Bone
E = 350e6; % Young Modulus in Pa
nu = 0.25; % Poisson's Ratio
structuralProperties(smodel,'YoungsModulus',E, 'PoissonsRatio',nu);
%% Apply Boundary Conditions

% apply boundry conditions
% Fixed contraint on a face
structuralBC(smodel,'Face',7,'Constraint','fixed');

% Displacement constrain on a face (uncomment to use)
% structuralBC(smodel,'Face',7,'Displacement',[0; 0; 0]);

% Define loading area for pressure/surface traction
area = 382.5/1000000; % m^2

% Define loading force
force = 76.654e3; % in N

% Calculate pressure (alternatively insert pressure directly)
p2 = force/area;

% Apply loads
% Pressure load on a face
structuralBoundaryLoad(smodel, 'Face', 9, 'Pressure', p2);

% Surface traction on a face (uncomment to use)
% structuralBoundaryLoad(smodel,'Face',1,'SurfaceTraction',[p2;0;0]);

%% Solve the PDE model

Rs = solve(smodel);
%% Display Results
% Limitation is that for the Strain exx, pressure is applied only to the
% ends. Realistically apply pressure to where the clamps are located
% Calculate the maximum displacement and display it (note in mm)
minUz = max(abs(Rs.Displacement.ux));
disp(['Maximal deflection in the x-direction is ' num2str(minUz) ' mm'])

% Plot stresses/strains/displacements (break into individual figures if desired) 
figure    
subplot(2,2,1), ...
    pdeplot3D(smodel, 'ColorMapData', Rs.VonMisesStress, 'Deformation', Rs.Displacement,'DeformationScaleFactor', 100)
title('Von Mises Stress')                     
subplot(2,2,2), pdeplot3D(smodel,'ColorMapData', Rs.Displacement.Magnitude)
title('Displacement')
subplot(2,2,3), pdeplot3D(smodel,'ColorMapData', Rs.Strain.exx)
title('Strain exx')
subplot(2,2,4), pdeplot3D(smodel,'ColorMapData', Rs.Strain.eyy)
title('Strain eyy')