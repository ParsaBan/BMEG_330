%% Author Block:
%Parsa Moheban
%56411994
%BMEG 330 - Project Part 3 - Data Analysis
%% Importing the Data
DigTrial = [-187.7926941	846.0817261	-3092.850586	-195.5337524	873.4899902	-3081.691162	-136.9971466	859.2122803	-3067.026123	-119.8740463	872.7463989	-3056.096191	-59.34156799	877.9420166	-3038.482422	-72.45173645	859.609436	-3068.387939];

% digitizer tip location in the digitizing trials
dataTipD1 = [-162.4383545	811.0076294	-3075.967041];
dataTipD2 = [-168.5965424	857.553772	-3081.572754];
dataTipD3 = [-116.7848892	842.0818481	-3084.507568];
dataTipD4 = [-125.6203995	863.2750244	-3069.746338];
dataTipD5 = [-42.70627213	883.4385376	-3036.419922];

%Toe-toe trials
Trial1 = [-415.8597107	778.1355591	-3104.059082	-427.0967712	798.6953125	-3096.953857	-369.642395	815.4590454	-3089.289551	-360.9622192	842.4242554	-3085.236816	-322.8597107	882.6184082	-3079.629395	-319.1346741	851.571106	-3100.513916];
Trial2 = [-410.0690918	751.7824097	-3069.705078	-426.0031433	768.979248	-3062.9104	-373.9226074	799.2076416	-3055.754395	-372.5412598	828.0748291	-3052.782715	-350.0693359	877.4976807	-3052.735107	-336.6112366	848.3380737	-3070.641846];
Trial3 = [-487.7618408	843.9824829	-3086.224609	-496.5531921	873.2722168	-3075.916504	-435.5020142	861.8881836	-3069.114258	-418.5147705	876.4562378	-3060.917969	-359.9173279	887.1439209	-3049.069824	-372.829071	864.8184814	-3078.000732];

%Trial 1 correlates to a pre-swing stance
%Trial 2 corrrelates to a mid stance
%Trial 3 correlates to a highest elevated toe position
%% Marker Calibration 1
%body 1 markers - forefoot is body 1 as it is stationary
cm4 = DigTrial(:,10:12);
cm5 = DigTrial(:,13:15);
cm6 = DigTrial(:,16:18);

% body 2 markers - hindfoot is body 2 as it mobile
cm1 = DigTrial(:,1:3); 
cm2 = DigTrial(:,4:6);
cm3 = DigTrial(:,7:9);
%% Creating a coordinate system for body 1 for the calibration trial
cB1_x = cm5 - cm6; %Setting marker 6 as the origin
cB1_r2 = cm4 - cm6; %temporary value for y
cB1_z = cross(cB1_x, cB1_r2);
cB1_y = cross(cB1_z, cB1_x);

%unit vectors
ciB1 = cB1_x/norm(cB1_x);
cjB1 = cB1_y/norm(cB1_y);
ckB1 = cB1_z/norm(cB1_z);

%% Converting row to column vectors
ciB1T = ciB1'; %Transpose the unit vectors
cjB1T = cjB1';
ckB1T = ckB1';
%Defining a calibration G-M coord. sys
cRB1 = [ciB1T cjB1T ckB1T];
%test for RHR
det(cRB1)
%% Marker Calibration 2: Creating a coordinate system for body 2 for the calibration trial

cB2_x = cm3 - cm1; %Marker 1 is the origin
cB2_r2 = cm2 - cm1;
cB2_z = cross(cB2_x, cB2_r2);
cB2_y = cross(cB2_z, cB2_x);

ciB2 = cB2_x/norm(cB2_x);
cjB2 = cB2_y/norm(cB2_y);
ckB2 = cB2_z/norm(cB2_z);

%% Converting row to column vectors

ciB2T = ciB2';
cjB2T = cjB2';
ckB2T = ckB2';

cRB2 = [ciB2T cjB2T ckB2T];
det(cRB2)

%% Marker data for body 1 (does not move) and body 2(moves)
% body 1 markers - forefoot (stationary)
m4 = Trial3(:,10:12);
m5 = Trial3(:,13:15);
m6 = Trial3(:,16:18);

% body 2 markers - hindfoot (mobile)
m1 = Trial3(:,1:3);
m2 = Trial3(:,4:6);
m3 = Trial3(:,7:9);
%% Digitization data for body 1 (does not move) and body 2(moves)
% body 1 digitized points
D1 = dataTipD1;
D2 = dataTipD2;
D3 = dataTipD3; %used for both body 1 and body 2

% body 2 digitized points
D4 = dataTipD4;
D5 = dataTipD5;

%% Creating a coordinate system for body 1
B1_x = m5 - m6; %Marker 6 as the origin
B1_r2 = m4 - m6;
B1_z = cross(B1_x, B1_r2);
B1_y = cross(B1_z, B1_x);

iB1 = B1_x/norm(B1_x);
jB1 = B1_y/norm(B1_y);
kB1 = B1_z/norm(B1_z);

%% Converting row to column vectors

iB1T = iB1';
jB1T = jB1';
kB1T = kB1';

RB1 = [iB1T jB1T kB1T]; %Body 1 marker matrix
det(RB1)

%% Creating a coordinate system for body 2

B2_x = m3 - m1; %Marker 1 as the origin 
B2_r2 = m2 - m1;
B2_z = cross(B2_x, B2_r2);
B2_y = cross(B2_z, B2_x);

iB2 = B2_x/norm(B2_x);
jB2 = B2_y/norm(B2_y);
kB2 = B2_z/norm(B2_z);

%% Converting row to column vectors

iB2T = iB2';
jB2T = jB2';
kB2T = kB2';

RB2 = [iB2T jB2T kB2T]; %Body 2 marker matrix
det(RB2)
%% Digitization Coordinate System I
% Creating the first anatomical axis
Dx = D3 - D4; %Anatomical Axis x1
Dtempy = D5 - D4;
Dz = cross(Dx, Dtempy);
Dy = cross(Dz, Dx); %Anatomical Axis y1

Di = Dx/norm(Dx);
Dj = Dy/norm(Dy);
Dk = Dz/norm(Dz);

DiT = Di';
DjT = Dj';
DkT = Dk';

RD = [DiT DjT DkT]; %Anatomical Axis 1
det(RD)

%% Digitization Coordinate System II
% Creating the second anatomical axis
Dx2 = D1 - D2;  %Anatomical Axis x2
Dtempy2 = D3 - D2;
Dz2 = cross(Dx2, Dtempy2);
Dy2 = cross(Dz2, Dx2);  %Anatomical Axis y2

Di2 = Dx2/norm(Dx2);
Dj2 = Dy2/norm(Dy2);
Dk2 = Dz2/norm(Dz2);

DiT2 = Di2';
DjT2 = Dj2';
DkT2 = Dk2';

RD2 = [DiT2 DjT2 DkT2]; %Anatomical Axis 2
det(RD2)
%% Flexion angle is the rotation of body 2 with reference to body 1

%Using the calibration trials to determine the Global to Anatomical matrices
M1toA1 = cRB1^(-1) * RD; 
M2toA2 = cRB2^(-1) * RD2;

%Using Constant Global to Anatomical matrices, finding the anatomical
%system with respect to the marker system
TA1 = RB1 * M1toA1; 
TA2 = RB2 * M2toA2;

%Displacement of the forefoot with respect to the hindfoot rotation matrix 
RMat = TA2^(-1) * TA1; %Correctly accounts for the arrow accounting for the angles (Final rotational matrix)

%% Determining Angles
% Using notes to determine Euler angles with reference to their position in
% the matrix for an X1,Y2,Z3 system 
Beta = asind(RMat(1,3));
Gamma = -atan2d(RMat(1,2), RMat(1,1));
Alpha = -atan2d(RMat(2,3), RMat(3,3));

sprintf("The beta angle = %2.2f degrees and describes internal and external rotation.", Beta)
sprintf("The gamma angle = %2.2f degrees and describes abduction and adduction.", Gamma)
sprintf("The alpha angle = %2.2f degrees and  describes the angle of extension.", Alpha)

