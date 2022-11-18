
clc
close all
% clear all
clearvars -except pinGrid TibiaGrid BplanKneeEdgeGrid BplanPinEdgeGrid

%% intrinsic parameters
cols = 512;
rows = 512;
sensor_width = cols;
sensor_height = rows;
pixel_size = 0.2; % unit, pixel/mm
alpha = 5000; % unit, pixel / m
focal_length = 1200; % unit mm
f = focal_length /1000; % unit m
fx = f*alpha; % unit pixel
fy = f*alpha;
cx = cols/2.0;
cy = rows/2.0;
K = [fx 0 cx; 0 fy cy; 0 0 1];

%% load 3d sdf of pin model and tibia
%% add the path to the 2d/3d tsdf of the knee model and pin model
addpath(genpath('EulerDerivation'));% euler derivation
addpath(genpath('SDF_prior_calculation/3d_model_grid_generation/'));
addpath(genpath('SDF_prior_calculation/Nail_grid_generation/'));

load gaofuyouModelUpdate.mat
load nailTR.mat
load TibiaDTXgrid.mat;
load TibiaDTYgrid.mat;
load TibiaDTZgrid.mat;
load TibiaGDTXXgrid.mat;
load TibiaGDTXYgrid.mat;
load TibiaGDTXZgrid.mat;
load TibiaGDTYXgrid.mat;
load TibiaGDTYYgrid.mat;
load TibiaGDTYZgrid.mat;
load TibiaGDTZXgrid.mat;
load TibiaGDTZYgrid.mat;
load TibiaGDTZZgrid.mat;

TibiaGrid.roi_bone_nearCamera = pointCloud(gaofuyouModelUpdate.ver);
TibiaGrid.roi_bone_nearCamera_tri = gaofuyouModelUpdate.tri;
TibiaGrid.TibiaDTXgrid = TibiaDTXgrid;
TibiaGrid.TibiaDTYgrid = TibiaDTYgrid;
TibiaGrid.TibiaDTZgrid = TibiaDTZgrid;
TibiaGrid.TibiaGDTXXgrid = TibiaGDTXXgrid;
TibiaGrid.TibiaGDTXYgrid = TibiaGDTXYgrid;
TibiaGrid.TibiaGDTXZgrid = TibiaGDTXZgrid;
TibiaGrid.TibiaGDTYXgrid = TibiaGDTYXgrid;
TibiaGrid.TibiaGDTYYgrid = TibiaGDTYYgrid;
TibiaGrid.TibiaGDTYZgrid = TibiaGDTYZgrid;
TibiaGrid.TibiaGDTZXgrid = TibiaGDTZXgrid;
TibiaGrid.TibiaGDTZYgrid = TibiaGDTZYgrid;
TibiaGrid.TibiaGDTZZgrid = TibiaGDTZZgrid;

load PinDTXgrid.mat;
load PinDTYgrid.mat;
load PinDTZgrid.mat;
load PinGDTXXgrid.mat;
load PinGDTXYgrid.mat;
load PinGDTXZgrid.mat;
load PinGDTYXgrid.mat;
load PinGDTYYgrid.mat;
load PinGDTYZgrid.mat;
load PinGDTZXgrid.mat;
load PinGDTZYgrid.mat;
load PinGDTZZgrid.mat;

pinGrid.nail_points = nailTR.ver;
pinGrid.nail_tri = nailTR.tri;
pinGrid.PinDTXgrid = PinDTXgrid;
pinGrid.PinDTYgrid = PinDTYgrid;
pinGrid.PinDTZgrid = PinDTZgrid;
pinGrid.PinGDTXXgrid = PinGDTXXgrid;
pinGrid.PinGDTXYgrid = PinGDTXYgrid;
pinGrid.PinGDTXZgrid = PinGDTXZgrid;
pinGrid.PinGDTYXgrid = PinGDTYXgrid;
pinGrid.PinGDTYYgrid = PinGDTYYgrid;
pinGrid.PinGDTYZgrid = PinGDTYZgrid;
pinGrid.PinGDTZXgrid = PinGDTZXgrid;
pinGrid.PinGDTZYgrid = PinGDTZYgrid;
pinGrid.PinGDTZZgrid = PinGDTZZgrid;

%% load 2D tsdf of knee edge and left/right pin edge from two views x_ray frames
addpath(genpath('SDF_prior_calculation/2d_observation_grid_generation'));
load('BplanKneeEdgeGrid.mat');
load('BplanPinEdgeGrid.mat');
BplanKneeEdgeGrid.KneeEdgeDTgrid = KneeEdgeDTgrid;
BplanKneeEdgeGrid.KneeEdgeGXgrid = KneeEdgeGXgrid;
BplanKneeEdgeGrid.KneeEdgeGYgrid = KneeEdgeGYgrid;
BplanKneeEdgeGrid.KneeEdgeIDgrid = KneeEdgeIDgrid;
BplanKneeEdgeGrid.KneeEdgeNV_theta = KneeEdgeNV_theta;

BplanPinEdgeGrid.PinEdgeDTgrid = PinEdgeDTgrid;
BplanPinEdgeGrid.PinEdgeGXgrid = PinEdgeGXgrid;
BplanPinEdgeGrid.PinEdgeGYgrid = PinEdgeGYgrid;
BplanPinEdgeGrid.PinEdgeIDgrid = PinEdgeIDgrid;
BplanPinEdgeGrid.PinEdgeNV_theta = PinEdgeNV_theta;

%% p30 and n30 view observation
% edge observation
load('observations_vs_initialValue/observation_tibia_first_view.mat');
load('observations_vs_initialValue/observation_left_pin_first_view.mat'); % u,v
load('observations_vs_initialValue/observation_right_pin_first_view.mat');
load('observations_vs_initialValue/observation_tibia_second_view.mat');
load('observations_vs_initialValue/observation_left_pin_second_view.mat');
load('observations_vs_initialValue/observation_right_pin_second_view.mat');

% depth groundtruth load
load('observations_vs_initialValue/depth_tibia_projection_first_view.mat');
load('observations_vs_initialValue/depth_nail_left_only_first_view.mat');
load('observations_vs_initialValue/depth_nail_right_only_first_view.mat');

load('observations_vs_initialValue/depth_tibia_projection_second_view.mat');
load('observations_vs_initialValue/depth_nail_left_only_second_view.mat');
load('observations_vs_initialValue/depth_nail_right_only_second_view.mat');

load('observations_vs_initialValue/T_cw_first_view.mat');
load('observations_vs_initialValue/T_cw_second_view.mat');

load('observations_vs_initialValue/T_wn_left.mat');
load('observations_vs_initialValue/T_wn_right.mat');

%% adapt the following in-vivo code
R_cw_first_view_estd = T_cw_first_view(1:3,1:3);
t_cw_first_view_estd = T_cw_first_view(1:3,4);

R_cw_second_view_estd = T_cw_second_view(1:3,1:3);
t_cw_second_view_estd = T_cw_second_view(1:3,4);

R_wn_left_pin_estd = T_wn_left(1:3,1:3);
t_wn_left_pin_estd = T_wn_left(1:3,4);

R_wn_right_pin_estd = T_wn_right(1:3,1:3);
t_wn_right_pin_estd = T_wn_right(1:3,4);

R_cw_first_view_initial = R_cw_first_view_estd;
t_cw_first_view_initial = t_cw_first_view_estd;
R_cw_second_view_initial = R_cw_second_view_estd;
t_cw_second_view_initial = t_cw_second_view_estd;
R_wn_left_pin_initial = R_wn_left_pin_estd;
t_wn_left_pin_initial = t_wn_left_pin_estd;
R_wn_right_pin_initial = R_wn_right_pin_estd;
t_wn_right_pin_initial = t_wn_right_pin_estd;

%% full view observation initialization (only use part of the extracted knee edge features)
%% ensure the length of used knee edge is shorter than the length of the 3D tsdf edge
num_tibia_edge_first_view = size(observation_tibia_first_view,1);% number of edge points in the knee frame of view1

R_wc_first_view_initial = R_cw_first_view_initial';
t_wc_first_view_initial = -R_cw_first_view_initial' * t_cw_first_view_initial;

% load and select uv depth from estimated depth map
depth_model_projection_first_view = depth_tibia_projection_first_view;
depth_tibia_edge_first_view = zeros(0,1);
u = observation_tibia_first_view(:,1);
v = observation_tibia_first_view(:,2);
dv = zeros(0,1);
du = zeros(0,1);

for j = 1:num_tibia_edge_first_view
    depth_temp = depth_model_projection_first_view(v(j),u(j));
    if depth_temp > 0
        depth_tibia_edge_first_view = [depth_tibia_edge_first_view;depth_temp];
        dv = [dv;v(j)];
        du = [du;u(j)];
    else
        continue;
    end
end
v_tibia_edge_frame_first_view = dv;
u_tibia_edge_frame_first_view = du;
num_tibia_edge_first_view = size(v_tibia_edge_frame_first_view,1);

% 3D edge point initialziation using the initial depth and pose
uv_edge_tibia_first_view = [u_tibia_edge_frame_first_view';v_tibia_edge_frame_first_view';ones(1,num_tibia_edge_first_view)];
NormPlane_edge_tibia_first_view = K\uv_edge_tibia_first_view; % inv(K)*pixel-->image plane
edge3dCam_tibia_first_view = NormPlane_edge_tibia_first_view * diag(depth_tibia_edge_first_view); % fix X and Y by always using ground truth depth
edge3dWrd_tibia_first_view = R_wc_first_view_initial * edge3dCam_tibia_first_view + t_wc_first_view_initial; % 3D edge point in the world space

uv_edge_tibia_first_view_gt = [u_tibia_edge_frame_first_view';v_tibia_edge_frame_first_view'];
vecEdge3dWrd_tibia_first_view = edge3dWrd_tibia_first_view(:); % Xw1;Yw1;Zw1;Xw2;Yw2;Zw2...

% Initialize the state vector from the full view frame of tibia edge observation
[Alpha_first_view,Beta_first_view,Gamma_first_view] = InvRotMatrixYPR22(R_cw_first_view_initial);
Pose_camera_first_view = [Alpha_first_view,Beta_first_view,Gamma_first_view,...
    t_cw_first_view_initial(1),t_cw_first_view_initial(2),t_cw_first_view_initial(3)]'; % Euler along z,y,x, optimize Alpha, Beta, Gamma
X_first_view_initial = [Pose_camera_first_view(1:6,1);vecEdge3dWrd_tibia_first_view]; % (6+num_tibia_edge_full_view*3)-by-1


%% part view frame 53326 initialization
num_tibia_edge_second_view = size(observation_tibia_second_view,1);

R_wc_second_view_initial = R_cw_second_view_initial';
t_wc_second_view_initial = -R_cw_second_view_initial' * t_cw_second_view_initial;

% load and select uv depth from estimated depth map
depth_model_projection_second_view = depth_tibia_projection_second_view;
depth_tibia_edge_second_view = zeros(0,1);
u = observation_tibia_second_view(:,1);
v = observation_tibia_second_view(:,2);
dv = zeros(0,1);
du = zeros(0,1);

for j = 1:num_tibia_edge_second_view
    depth_temp = depth_model_projection_second_view(v(j),u(j));
    if depth_temp > 0
        depth_tibia_edge_second_view = [depth_tibia_edge_second_view;depth_temp];
        dv = [dv;v(j)];
        du = [du;u(j)];
    else
        continue;
    end  
end
v_edge_tibia_second_view = dv;
u_edge_tibia_second_view = du;
num_tibia_edge_second_view = size(v_edge_tibia_second_view,1);

% 3D edge point initialziation using the initial depth and pose
uv_edge_tibia_second_view = [u_edge_tibia_second_view';v_edge_tibia_second_view';ones(1,num_tibia_edge_second_view)];
NormPlane_edge_tibia_second_view = K\uv_edge_tibia_second_view; % inv(K)*pixel-->image plane
edge3dCam_tibia_second_view = NormPlane_edge_tibia_second_view * diag(depth_tibia_edge_second_view); % fix X and Y by always using ground truth depth
edge3dWrd_tibia_second_view = R_wc_second_view_initial * edge3dCam_tibia_second_view + t_wc_second_view_initial; % 3D edge point in the world space

uv_edge_tibia_second_view_gt = [u_edge_tibia_second_view';v_edge_tibia_second_view'];
vecEdge3dWrd_tibia_second_view = edge3dWrd_tibia_second_view(:); % Xw1;Yw1;Zw1;Xw2;Yw2;Zw2...

% Initialize the state vector from the full view frame of tibia edge observation
[Alpha_second_view,Beta_second_view,Gamma_second_view] = InvRotMatrixYPR22(R_cw_second_view_initial);
Pose_camera_second_view = [Alpha_second_view,Beta_second_view,Gamma_second_view,...
    t_cw_second_view_initial(1),t_cw_second_view_initial(2),t_cw_second_view_initial(3)]'; % Euler along z,y,x, optimize Alpha, Beta, Gamma
X_second_view_initial = [Pose_camera_second_view(1:6,1);vecEdge3dWrd_tibia_second_view]; % (6+num_tibia_edge_full_view*3)-by-1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% initialization of left pin observation from the full view frame
%% the pose of left pin in the full view frame w.r.t the tibia model
R_nw_left_pin_initial = R_wn_left_pin_initial';
t_nw_left_pin_initial = -R_wn_left_pin_initial'*t_wn_left_pin_initial;

R_nw_right_pin_initial = R_wn_right_pin_initial';
t_nw_right_pin_initial = -R_wn_right_pin_initial'*t_wn_right_pin_initial;

% left pin 3D edge observation initialization from the full view frame
depth_left_pin_projection_first_view = depth_nail_left_only_first_view;
left_pin_edge_index_first_view = observation_left_pin_first_view;
edge_left_pin_frame_first_view = left_pin_edge_index_first_view;
num_edge_left_pin_first_view = size(edge_left_pin_frame_first_view,1);
depth_edge_left_pin_first_view = zeros(0,1);
u = edge_left_pin_frame_first_view(:,1);
v = edge_left_pin_frame_first_view(:,2);

dv = zeros(0,1);
du = zeros(0,1);

pixel_range = 2;
for j = 1:num_edge_left_pin_first_view
    depth_temp = depth_left_pin_projection_first_view(v(j),u(j));
    if depth_temp > 0
        depth_edge_left_pin_first_view = [depth_edge_left_pin_first_view;depth_temp];
        dv = [dv;v(j)];
        du = [du;u(j)];
    else
        for m = -pixel_range:1:pixel_range
            for n = -pixel_range:1:pixel_range
                depth_temp = depth_left_pin_projection_first_view(v(j)+m,u(j)+n);
                if depth_temp > 0
                    depth_edge_left_pin_first_view = [depth_edge_left_pin_first_view;depth_temp];
                    dv = [dv;v(j)];
                    du = [du;u(j)];
                    break;
                else
                    continue;
                end
            end
            if depth_temp > 0
                break;
            end
        end
    end
end

v_edge_left_pin_first_view = dv;
u_edge_left_pin_first_view = du;
num_edge_left_pin_first_view = size(v_edge_left_pin_first_view,1);

% 3D edge point initialziation using the initial depth and pose
uv_edge_left_pin_first_view = [u_edge_left_pin_first_view';v_edge_left_pin_first_view';ones(1,num_edge_left_pin_first_view)];
NormPlane_edge_left_pin_first_view = K\uv_edge_left_pin_first_view; % inv(K)*pixel-->image plane
edge3dCam_left_pin_first_view = NormPlane_edge_left_pin_first_view * diag(depth_edge_left_pin_first_view); % fix X and Y by always using ground truth depth
edge3dWrd_left_pin_first_view = R_wc_first_view_initial * edge3dCam_left_pin_first_view + t_wc_first_view_initial; % 3D edge point in the world space
edge3dNWrd_left_pin_first_view = R_nw_left_pin_initial*edge3dWrd_left_pin_first_view + t_nw_left_pin_initial; % ground truth points in the nail space

uv_edge_left_pin_first_view_gt = [u_edge_left_pin_first_view';v_edge_left_pin_first_view'];
vecEdge3dNWrd_left_pin_first_view= edge3dNWrd_left_pin_first_view(:); % Xw1;Yw1;Zw1;Xw2;Yw2;Zw2...

%% the pose of right pin in the full view frame w.r.t the tibia model
% right pin 3D edge observation initialization from the full view frame
depth_right_pin_projection_first_view = depth_nail_right_only_first_view;
right_pin_edge_index_first_view = observation_right_pin_first_view;
edge_right_pin_frame_first_view = right_pin_edge_index_first_view;
num_edge_right_pin_first_view = size(edge_right_pin_frame_first_view,1);
depth_edge_right_pin_first_view = zeros(0,1);
u = edge_right_pin_frame_first_view(:,1);
v = edge_right_pin_frame_first_view(:,2);
dv = zeros(0,1);
du = zeros(0,1);

for j = 1:num_edge_right_pin_first_view
    depth_temp = depth_right_pin_projection_first_view(v(j),u(j));
    if depth_temp > 0
        depth_edge_right_pin_first_view = [depth_edge_right_pin_first_view;depth_temp];
        dv = [dv;v(j)];
        du = [du;u(j)];
    else
        for m = -pixel_range:1:pixel_range
            for n = -pixel_range:1:pixel_range
                depth_temp = depth_right_pin_projection_first_view(v(j)+m,u(j)+n);
                if depth_temp > 0
                    depth_edge_right_pin_first_view = [depth_edge_right_pin_first_view;depth_temp];
                    dv = [dv;v(j)];
                    du = [du;u(j)];
                    break;
                else
                    continue;
                end
            end
            if depth_temp > 0
                break;
            end
        end
    end
end

v_edge_right_pin_first_view = dv;
u_edge_right_pin_first_view = du;
num_edge_right_pin_first_view = size(v_edge_right_pin_first_view,1);

% 3D edge point initialziation using the initial depth and pose
uv_edge_right_pin_first_view = [u_edge_right_pin_first_view';v_edge_right_pin_first_view';ones(1,num_edge_right_pin_first_view)];
NormPlane_edge_right_pin_first_view = K\uv_edge_right_pin_first_view; % inv(K)*pixel-->image plane
edge3dCam_right_pin_first_view = NormPlane_edge_right_pin_first_view * diag(depth_edge_right_pin_first_view); % fix X and Y by always using ground truth depth
edge3dWrd_right_pin_first_view = R_wc_first_view_initial * edge3dCam_right_pin_first_view + t_wc_first_view_initial; % 3D edge point in the world space
edge3dNWrd_right_pin_first_view = R_nw_right_pin_initial*edge3dWrd_right_pin_first_view + t_nw_right_pin_initial; % ground truth points in the nail space

uv_edge_right_pin_first_view_gt = [u_edge_right_pin_first_view';v_edge_right_pin_first_view'];
vecEdge3dNWrd_right_pin_first_view= edge3dNWrd_right_pin_first_view(:); % Xw1;Yw1;Zw1;Xw2;Yw2;Zw2...

%% initialization of left pin observation from the part view frame
%% the pose of left pin in the part view frame w.r.t the tibia model
depth_left_pin_projection_second_view = depth_nail_left_only_second_view;
left_pin_edge_index_second_view = observation_left_pin_second_view;
edge_left_pin_frame_second_view = left_pin_edge_index_second_view;
num_edge_left_pin_second_view = size(edge_left_pin_frame_second_view,1);

depth_edge_left_pin_second_view = zeros(0,1);
u = edge_left_pin_frame_second_view(:,1);
v = edge_left_pin_frame_second_view(:,2);

dv = zeros(0,1);
du = zeros(0,1);

for j = 1:num_edge_left_pin_second_view
    depth_temp = depth_left_pin_projection_second_view(v(j),u(j));
    if depth_temp > 0
        depth_edge_left_pin_second_view = [depth_edge_left_pin_second_view;depth_temp];
        dv = [dv;v(j)];
        du = [du;u(j)];
    else
        for m = -pixel_range:1:pixel_range
            for n = -pixel_range:1:pixel_range
                depth_temp = depth_left_pin_projection_second_view(v(j)+m,u(j)+n);
                if depth_temp > 0
                    depth_edge_left_pin_second_view = [depth_edge_left_pin_second_view;depth_temp];
                    dv = [dv;v(j)];
                    du = [du;u(j)];
                    break;
                else
                    continue;
                end
            end
            if depth_temp > 0
                break;
            end
        end
    end
end

v_edge_left_pin_second_view = dv;
u_edge_left_pin_second_view = du;
num_edge_left_pin_second_view = size(v_edge_left_pin_second_view,1);

% 3D edge point initialziation using the initial depth and pose
uv_edge_left_pin_second_view = [u_edge_left_pin_second_view';v_edge_left_pin_second_view';ones(1,num_edge_left_pin_second_view)];
NormPlane_edge_left_pin_second_view = K\uv_edge_left_pin_second_view; % inv(K)*pixel-->image plane
edge3dCam_left_pin_second_view = NormPlane_edge_left_pin_second_view * diag(depth_edge_left_pin_second_view); % fix X and Y by always using ground truth depth
edge3dWrd_left_pin_second_view = R_wc_second_view_initial * edge3dCam_left_pin_second_view + t_wc_second_view_initial; % 3D edge point in the world space
edge3dNWrd_left_pin_second_view = R_nw_left_pin_initial*edge3dWrd_left_pin_second_view + t_nw_left_pin_initial; % ground truth points in the nail space

uv_edge_left_pin_second_view_gt = [u_edge_left_pin_second_view';v_edge_left_pin_second_view'];
vecEdge3dNWrd_left_pin_second_view= edge3dNWrd_left_pin_second_view(:); % Xw1;Yw1;Zw1;Xw2;Yw2;Zw2...

%% the pose of right pin in the part view frame w.r.t the tibia model
depth_right_pin_projection_second_view = depth_nail_right_only_second_view;
right_pin_edge_index_second_view = observation_right_pin_second_view;
edge_right_pin_frame_second_view = right_pin_edge_index_second_view;
num_edge_right_pin_second_view = size(edge_right_pin_frame_second_view,1);
depth_edge_right_pin_second_view = zeros(0,1);
u = edge_right_pin_frame_second_view(:,1);
v = edge_right_pin_frame_second_view(:,2);
dv = zeros(0,1);
du = zeros(0,1);

for j = 1:num_edge_right_pin_second_view
    depth_temp = depth_right_pin_projection_second_view(v(j),u(j));
    if depth_temp > 0
        depth_edge_right_pin_second_view = [depth_edge_right_pin_second_view;depth_temp];
        dv = [dv;v(j)];
        du = [du;u(j)];
    else
        for m = -pixel_range:1:pixel_range
            for n = -pixel_range:1:pixel_range
                depth_temp = depth_right_pin_projection_second_view(v(j)+m,u(j)+n);
                if depth_temp > 0
                    depth_edge_right_pin_second_view = [depth_edge_right_pin_second_view;depth_temp];
                    dv = [dv;v(j)];
                    du = [du;u(j)];
                    break;
                else
                    continue;
                end
            end
            if depth_temp > 0
                break;
            end
        end
    end
end

v_edge_right_pin_second_view = dv;
u_edge_right_pin_second_view = du;
num_edge_right_pin_second_view = size(v_edge_right_pin_second_view,1);

% 3D edge point initialziation using the initial depth and pose
uv_edge_right_pin_second_view = [u_edge_right_pin_second_view';v_edge_right_pin_second_view';ones(1,num_edge_right_pin_second_view)];
NormPlane_edge_right_pin_second_view = K\uv_edge_right_pin_second_view; % inv(K)*pixel-->image plane
edge3dCam_right_pin_second_view = NormPlane_edge_right_pin_second_view * diag(depth_edge_right_pin_second_view); % fix X and Y by always using ground truth depth
edge3dWrd_right_pin_second_view = R_wc_second_view_initial * edge3dCam_right_pin_second_view + t_wc_second_view_initial; % 3D edge point in the world space
edge3dNWrd_right_pin_second_view = R_nw_right_pin_initial*edge3dWrd_right_pin_second_view + t_nw_right_pin_initial; % ground truth points in the nail space
uv_edge_right_pin_second_view_gt = [u_edge_right_pin_second_view';v_edge_right_pin_second_view'];
vecEdge3dNWrd_right_pin_second_view= edge3dNWrd_right_pin_second_view(:); % Xw1;Yw1;Zw1;Xw2;Yw2;Zw2...

%% construct state vector from the left and right pin of full view and part view frames
[Alpha_left_pin,Beta_left_pin,Gamma_left_pin] = InvRotMatrixYPR22(R_wn_left_pin_initial);
Pose_left_pin_gt = [Alpha_left_pin,Beta_left_pin,Gamma_left_pin,...
    t_wn_left_pin_initial(1),t_wn_left_pin_initial(2),t_wn_left_pin_initial(3)]'; % Euler along z,y,x, optimize Alpha, Beta, Gamma
X_left_pin_initial = [Pose_left_pin_gt(1:6,1);vecEdge3dNWrd_left_pin_first_view;vecEdge3dNWrd_left_pin_second_view]; % 6+pin_pts_gt_v1+pin_pts_gt_v27

[Alpha_right_pin,Beta_right_pin,Gamma_right_pin] = InvRotMatrixYPR22(R_wn_right_pin_initial);
Pose_right_pin_gt = [Alpha_right_pin,Beta_right_pin,Gamma_right_pin,...
    t_wn_right_pin_initial(1),t_wn_right_pin_initial(2),t_wn_right_pin_initial(3)]'; % Euler along z,y,x, optimize Alpha, Beta, Gamma
X_right_pin_initial = [Pose_right_pin_gt(1:6,1);vecEdge3dNWrd_right_pin_first_view;vecEdge3dNWrd_right_pin_second_view]; % 6+pin_pts_gt_v1+pin_pts_gt_v27

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% add noise to the state vector, you can try with differen levels of nosie
euler_noise_level = 0.1;
translation_noise_level = 10;
points_translation_level = 10;

Euler_noise_first_view = euler_noise_level*(rand(3,1)-0.5);
translation_noise_first_view = translation_noise_level*(rand(3,1)-0.5);
knee_ptsw_noise_first_view = points_translation_level*(rand(size(vecEdge3dWrd_tibia_first_view))-0.5);

Euler_noise_second_view = euler_noise_level*(rand(3,1)-0.5);
translation_noise_second_view = translation_noise_level*(rand(3,1)-0.5);
knee_ptsw_noise_second_view = points_translation_level*(rand(size(vecEdge3dWrd_tibia_second_view))-0.5);

Euler_noise_left_pin = euler_noise_level*(rand(3,1)-0.5);
translation_noise_left_pin = translation_noise_level*(rand(3,1)-0.5);
knee_ptsw_noise_left_pin_first_view = points_translation_level*(rand(size(vecEdge3dNWrd_left_pin_first_view))-0.5);
knee_ptsw_noise_left_pin_second_view = points_translation_level*(rand(size(vecEdge3dNWrd_left_pin_second_view))-0.5);

Euler_noise_right_pin = euler_noise_level*(rand(3,1)-0.5);
translation_noise_right_pin = translation_noise_level*(rand(3,1)-0.5);
knee_ptsw_noise_right_pin_first_view = points_translation_level*(rand(size(vecEdge3dNWrd_right_pin_first_view))-0.5);
knee_ptsw_noise_right_pin_second_view = points_translation_level*(rand(size(vecEdge3dNWrd_right_pin_second_view))-0.5);

X = zeros(size(X_first_view_initial,1)+size(X_second_view_initial,1)+...
    size(X_left_pin_initial,1) +  size(X_right_pin_initial,1),1);

X(1:3,1) = X_first_view_initial(1:3,1) + Euler_noise_first_view; % Euler
X(4:6,1) = X_first_view_initial(4:6,1) + translation_noise_first_view; % translation
X(7:size(X_first_view_initial),1) = X_first_view_initial(7:end,1) + knee_ptsw_noise_first_view;

index_X = size(X_first_view_initial);
X(index_X+1:index_X+3,1) = X_second_view_initial(1:3,1) + Euler_noise_second_view; % Euler
X(index_X+4:index_X+6,1) = X_second_view_initial(4:6,1) + translation_noise_second_view; % translation
X(index_X+7:index_X+size(X_second_view_initial),1) = ...
    X_second_view_initial(7:end,1) + knee_ptsw_noise_second_view; % translation

index_X = size(X_first_view_initial)+size(X_second_view_initial);
X(index_X+1:index_X+3,1) = X_left_pin_initial(1:3,1)+Euler_noise_left_pin;
X(index_X+4:index_X+6,1) = X_left_pin_initial(4:6,1)+translation_noise_left_pin;
X(index_X+7:index_X+6+size(vecEdge3dNWrd_left_pin_first_view),1) = ...
    X_left_pin_initial(7:6+size(vecEdge3dNWrd_left_pin_first_view),1)+knee_ptsw_noise_left_pin_first_view;
index_X = size(X_first_view_initial)+size(X_second_view_initial) + 6 + size(vecEdge3dNWrd_left_pin_first_view);
X(index_X+1:index_X+size(vecEdge3dNWrd_left_pin_second_view),1) = ...
    X_left_pin_initial(6+size(vecEdge3dNWrd_left_pin_first_view)+1:end,1)+knee_ptsw_noise_left_pin_second_view;

index_X = size(X_first_view_initial) + size(X_second_view_initial) + size(X_left_pin_initial);
X(index_X+1:index_X+3,1) = X_right_pin_initial(1:3,1)+Euler_noise_right_pin;
X(index_X+4:index_X+6,1) = X_right_pin_initial(4:6,1)+translation_noise_right_pin;
X(index_X+7:index_X+6+size(vecEdge3dNWrd_right_pin_first_view),1) = ...
    X_right_pin_initial(7:6+size(vecEdge3dNWrd_right_pin_first_view),1)+knee_ptsw_noise_right_pin_first_view;
index_X = size(X_first_view_initial)+size(X_second_view_initial) + size(X_left_pin_initial) + ...
    6 + size(vecEdge3dNWrd_right_pin_first_view);
X(index_X+1:index_X+size(vecEdge3dNWrd_right_pin_second_view),1) = ...
    X_right_pin_initial(6+size(vecEdge3dNWrd_right_pin_first_view)+1:end,1)+knee_ptsw_noise_right_pin_second_view;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% construct the final state vector combing all the observations
% X_Ray pose and 3dEdge from full view + X_Ray pose and 3dEdge from part view
% + left pin pose and 3dEdge from full view and part view ...
% + right pin pose and 3dEdge from full view and part view
%% covariance matrix inverse
% weight for the edge observation of the full view tibia 
Var_edge3d_tibia_fv = 0.01; % weight for 3D edge term of tibia-full-view
Cov_edge3d_tibia_fv = zeros(num_tibia_edge_first_view*3,1);
Cov_edge3d_tibia_fv(:,1) = Var_edge3d_tibia_fv;
Var_UV_edge_tibia_fv = 0.01; % weight for uv cost function term of tibia-full-view
Cov_UV_edge_tibia_fv = zeros(num_tibia_edge_first_view*2,1);
Cov_UV_edge_tibia_fv(:,1) = Var_UV_edge_tibia_fv;

% weight for the part view tibvia edge observation 
Var_edge3d_tibia_sv = 0.01; % weight for 3D edge term of tibia-part-view
Cov_edge3d_tibia_sv = zeros(num_tibia_edge_second_view*3,1);
Cov_edge3d_tibia_sv(:,1) = Var_edge3d_tibia_sv;
Var_UV_edge_tibia_sv = 1; % weight for uv cost function term of knee_view27
Cov_UV_edge_tibia_sv = zeros(num_tibia_edge_second_view*2,1);
Cov_UV_edge_tibia_sv(:,1) = Var_UV_edge_tibia_sv;

% weight for the observation from the left pin of the full view frame
Var_edge3dNWrd_left_pin_fv = 0.01;
Cov_edge3dNWrd_left_pin_fv = zeros(num_edge_left_pin_first_view*3,1);
Cov_edge3dNWrd_left_pin_fv(:,1) = Var_edge3dNWrd_left_pin_fv;
Var_UV_edge_left_pin_fv = 1; % weight for uv cost function term of pin_view1
Cov_UV_edge_left_pin_fv = zeros(num_edge_left_pin_first_view*2,1);
Cov_UV_edge_left_pin_fv(:,1) = Var_UV_edge_left_pin_fv;

% weight for the observation from the left pin of the part view frame
Var_edge3dNWrd_left_pin_sv = 0.01;
Cov_edge3dNWrd_left_pin_sv = zeros(num_edge_left_pin_second_view*3,1);
Cov_edge3dNWrd_left_pin_sv(:,1) = Var_edge3dNWrd_left_pin_sv;
Var_UV_edge_left_pin_sv = 1; % weight for uv cost function term of pin_view1
Cov_UV_edge_left_pin_sv = zeros(num_edge_left_pin_second_view*2,1);
Cov_UV_edge_left_pin_sv(:,1) = Var_UV_edge_left_pin_sv;

% weight for the observation from the right pin of the full view frame
Var_edge3dNWrd_right_pin_fv = 0.01;
Cov_edge3dNWrd_right_pin_fv = zeros(num_edge_right_pin_first_view*3,1);
Cov_edge3dNWrd_right_pin_fv(:,1) = Var_edge3dNWrd_right_pin_fv;
Var_UV_edge_right_pin_fv = 1; % weight for uv cost function term of pin_view1
Cov_UV_edge_right_pin_fv = zeros(num_edge_right_pin_first_view*2,1);
Cov_UV_edge_right_pin_fv(:,1) = Var_UV_edge_right_pin_fv;

% weight for the observation from the right pin of the part view frame
Var_edge3dNWrd_right_pin_sv = 0.01;
Cov_edge3dNWrd_right_pin_sv = zeros(num_edge_right_pin_second_view*3,1);
Cov_edge3dNWrd_right_pin_sv(:,1) = Var_edge3dNWrd_right_pin_sv;
Var_UV_edge_right_pin_sv = 1; % weight for uv cost function term of pin_view1
Cov_UV_edge_right_pin_sv = zeros(num_edge_right_pin_second_view*2,1);
Cov_UV_edge_right_pin_sv(:,1) = Var_UV_edge_right_pin_sv;

Cov = [Cov_edge3d_tibia_fv;Cov_UV_edge_tibia_fv;Cov_edge3d_tibia_sv;Cov_UV_edge_tibia_sv;...
    Cov_edge3dNWrd_left_pin_fv;Cov_UV_edge_left_pin_fv;Cov_edge3dNWrd_left_pin_sv;Cov_UV_edge_left_pin_sv;...
    Cov_edge3dNWrd_right_pin_fv;Cov_UV_edge_right_pin_fv;Cov_edge3dNWrd_right_pin_sv;Cov_UV_edge_right_pin_sv];
nCov = num_tibia_edge_first_view*5 + num_tibia_edge_second_view*5 + num_edge_left_pin_first_view*5 + ...
    num_edge_left_pin_second_view*5 + num_edge_right_pin_first_view*5 + num_edge_right_pin_second_view*5;
CovMatrixInv = sparse(1:nCov,1:nCov,Cov);

%% Optimization
%% GN algorithm

[F,Sum_Error,J] = ...
    FuncDiffJacobianMultiViews(K,rows,cols,TibiaGrid,pinGrid,X,CovMatrixInv,...
    uv_edge_tibia_first_view_gt,uv_edge_tibia_second_view_gt,uv_edge_left_pin_first_view_gt,...
    uv_edge_left_pin_second_view_gt,uv_edge_right_pin_first_view_gt,uv_edge_right_pin_second_view_gt,...
    BplanKneeEdgeGrid,BplanPinEdgeGrid); % Points_Depth is ground truth depth

fprintf('Initial Chi^2 is %.8f\n', Sum_Error);

LM = 1;

if LM == 0
    disp('Begin: GN algorithm');
    Sum_Delta = 22;
    MaxIter = 500;
    MinError = -1;
    MinDelta = 1e-12;

    tic;
    Iter = 0;
    while Sum_Error>MinError && Sum_Delta>MinDelta && Iter<=MaxIter
        [Delta,Sum_Delta] = FuncDelta(J,F,CovMatrixInv);   
        [X] = FuncUpdate(X,Delta);
        [F,Sum_Error,J] = ...
        FuncDiffJacobianMultiViews(K,rows,cols,TibiaGrid,pinGrid,X,CovMatrixInv,...
            uv_edge_tibia_first_view_gt,uv_edge_tibia_second_view_gt,uv_edge_left_pin_first_view_gt,...
            uv_edge_left_pin_second_view_gt,uv_edge_right_pin_first_view_gt,uv_edge_right_pin_second_view_gt,...
            BplanKneeEdgeGrid,BplanPinEdgeGrid);
        Iter = Iter+1;
        fprintf('Iterations %d Chi^2 %.8f\n', Iter,Sum_Error);    
    end
    disp('End: GN algorithm');
    Time = toc;
    %fprintf('Reason is %d\n', Reason);
    fprintf('Time use %f\n\n', Time);
else
    disp('Begin: LM algorithm');
    epsilong1 = 1e-12; % the magnitude of the gradient J drops below a threshold epsilong1
    epsilong2 = 1e-12; % the relative magnitude of delta d drops below a threshold involving a parameter epsilong2
    epsilong3 = 1e-12; % the magnitude of the residual F drops below epsilong3
    epsilong4 = 1e-10; % the relative reduction in the magnitude of F drops below threshold epsilong4
    tau = 1e-3;
    k = 0;
    k_max = 200;
    %X = X0; %p =x; p0 = x0; A = (J'*P*J); ksi_p = F; g = (J'*P*F)
    v = 2;
    stats_d = zeros(k_max,1);
    stats_f = zeros(k_max,1);
    F = sparse(F);
    A = J'*J;
    g = -J'*F;
    mu = tau * max(diag(A)); % damping parameter
    stop = (norm(g,inf) <= epsilong1);

    [row, col] = size(J);
    I = ones(1,col);
    I_sparse = sparse(1:col,1:col, I);

    while(~stop && k<k_max)
        k = k+1;

        d = (A + mu*I_sparse)\g;
        stats_d(k,1) = sumsqr(d);
        stats_f(k,1) = F'*F;

        if( norm(d,2) <= epsilong2*(norm(X,2)+epsilong2) )
            stop = true;
        else
            X_new = X + d;
            [F_new,Sum_Error,J_new] = ...
                FuncDiffJacobianMultiViews(K,rows,cols,TibiaGrid,pinGrid,X_new,CovMatrixInv,...
                uv_edge_tibia_first_view_gt,uv_edge_tibia_second_view_gt,uv_edge_left_pin_first_view_gt,...
                uv_edge_left_pin_second_view_gt,uv_edge_right_pin_first_view_gt,uv_edge_right_pin_second_view_gt,...
                BplanKneeEdgeGrid,BplanPinEdgeGrid);

            rho = (F'*F - F_new'*F_new)/(d'*(mu*d+g));

            if rho > 0
                stop = ( (norm(F'*F,2)-norm(F_new'*F_new,2)) < epsilong4*norm(F,2) );
                X = X_new;
                J = J_new;
                F = F_new;
                A = J'*J;
                g = -J'*F;
                stop = ( stop || (norm(g,inf) <= epsilong1) );
                mu = mu*max(1/3, 1-(2*rho-1)^3);
                v = 2;
            else
                mu = mu*v;
                v = 2*v;
            end
        end
        stop = (stop || (norm(F,2) < epsilong3));
        fprintf('Iterations %d Chi^2 %.8f\n', k,Sum_Error);
    end
    disp('End: LM algorithm');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% validation
%% first view
Alpha_first_view_estd = X(1);
Beta_first_view_estd = X(2);
Gamma_first_view_estd = X(3);
R_cw_first_view_estd = RMatrixYPR22(Alpha_first_view_estd,Beta_first_view_estd,Gamma_first_view_estd); 
t_cw_first_view_estd = X(4:6,1);
camera_first_view_error = X(1:6,1) - Pose_camera_first_view

edge3dWrd_tibia_frame_first_view_estd = reshape(X(7:6+3*num_tibia_edge_first_view),3,[]); % obtain pts_world from state
edge3dCam_tibia_frame_first_view_estd = R_cw_first_view_estd *edge3dWrd_tibia_frame_first_view_estd + t_cw_first_view_estd; % transform pts in the world space to the camera space
uv_edge_tibia_frame_first_view_estd = K*(edge3dCam_tibia_frame_first_view_estd(1:3,:) ./ edge3dCam_tibia_frame_first_view_estd(3,:)); % uv estimation
uv_edge_tibia_frame_first_view_estd = uv_edge_tibia_frame_first_view_estd(1:2,:);

%% part view
index_X = 6+3*num_tibia_edge_first_view;
Alpha_second_view_estd = X(index_X+1,1);
Beta_second_view_estd  = X(index_X+2,1);
Gamma_second_view_estd = X(index_X+3,1); 
R_cw_second_view_estd = RMatrixYPR22(Alpha_second_view_estd,Beta_second_view_estd,Gamma_second_view_estd); % convert to rotation as order of Alpha, Beta and Gamma
t_cw_second_view_estd = X(index_X+4:index_X+6,1);

camera_second_view_error = X(index_X+1:index_X+6,1) - Pose_camera_second_view

edge3dWrd_tibia_frame_second_view_estd = reshape(X(index_X+7:index_X+6+3*num_tibia_edge_second_view),3,[]);
edge3dCam_tibia_frame_second_view_estd = R_cw_second_view_estd*edge3dWrd_tibia_frame_second_view_estd + t_cw_second_view_estd; % transform pts in the world space to the camera space
uv_edge_tibia_second_view_estd = ...
    K*(edge3dCam_tibia_frame_second_view_estd(1:3,:) ./ edge3dCam_tibia_frame_second_view_estd(3,:)); % uv estimation
uv_edge_tibia_second_view_estd = uv_edge_tibia_second_view_estd(1:2,:);

%% left pin
index_X = 6+3*num_tibia_edge_first_view+6+3*num_tibia_edge_second_view;
Alpha_left_pin_estd = X(index_X+1,1);
Beta_left_pin_estd = X(index_X+2,1);
Gamma_left_pin_estd = X(index_X+3,1); 
R_wn_left_pin_estd = RMatrixYPR22(Alpha_left_pin_estd,Beta_left_pin_estd,Gamma_left_pin_estd); % convert to rotation as order of Alpha, Beta and Gamma
t_wn_left_pin_estd = X(index_X+4:index_X+6,1);
edge3dNWrd_left_pin_first_view_estd = reshape(X(index_X+7:index_X+6+3*num_edge_left_pin_first_view),3,[]); 

left_pin_pose_error = X(index_X+1:index_X+6,1) - Pose_left_pin_gt

edge3dCam_left_pin_first_view_estd = ...
    R_cw_first_view_estd*( R_wn_left_pin_estd*edge3dNWrd_left_pin_first_view_estd + t_wn_left_pin_estd) + t_cw_first_view_estd;
uv_edge_left_pin_first_view_estd = K*(edge3dCam_left_pin_first_view_estd(1:3,:) ./ edge3dCam_left_pin_first_view_estd(3,:)); % uv estimation
uv_edge_left_pin_first_view_estd = uv_edge_left_pin_first_view_estd(1:2,:);

index_X = 6+3*num_tibia_edge_first_view+6+3*num_tibia_edge_second_view+6+3*num_edge_left_pin_first_view;
edge3dNWrd_left_pin_second_view_estd = reshape(X(index_X+1:index_X+3*num_edge_left_pin_second_view),3,[]); 
edge3dCam_left_pin_second_view_estd = ...
    R_cw_second_view_estd*( R_wn_left_pin_estd*edge3dNWrd_left_pin_second_view_estd + t_wn_left_pin_estd) + t_cw_second_view_estd; % transform pts in the world space to the camera space
uv_edge_left_pin_second_view_estd = K*(edge3dCam_left_pin_second_view_estd(1:3,:) ./ edge3dCam_left_pin_second_view_estd(3,:)); % uv estimation
uv_edge_left_pin_second_view_estd = uv_edge_left_pin_second_view_estd(1:2,:);

%% right pin
index_X = 6+3*num_tibia_edge_first_view+6+3*num_tibia_edge_second_view+...
    6+3*num_edge_left_pin_first_view+3*num_edge_left_pin_second_view;
Alpha_right_pin_estd = X(index_X+1,1);
Beta_right_pin_estd = X(index_X+2,1);
Gamma_right_pin_estd = X(index_X+3,1); 
R_wn_right_pin_estd = RMatrixYPR22(Alpha_right_pin_estd,Beta_right_pin_estd,Gamma_right_pin_estd); % convert to rotation as order of Alpha, Beta and Gamma
t_wn_right_pin_estd = X(index_X+4:index_X+6,1);

right_pin_pose_error = X(index_X+1:index_X+6,1) - Pose_right_pin_gt

edge3dNWrd_right_pin_first_view_estd = reshape(X(index_X+7:index_X+6+3*num_edge_right_pin_first_view),3,[]);
edge3dCam_right_pin_first_view_estd = ...
    R_cw_first_view_estd*( R_wn_right_pin_estd*edge3dNWrd_right_pin_first_view_estd + t_wn_right_pin_estd) + t_cw_first_view_estd; % transform pts in the world space to the camera space
uv_edge_right_pin_first_view_estd = K*(edge3dCam_right_pin_first_view_estd(1:3,:) ./ edge3dCam_right_pin_first_view_estd(3,:)); % uv estimation
uv_edge_right_pin_first_view_estd = uv_edge_right_pin_first_view_estd(1:2,:);


index_X = 6+3*num_tibia_edge_first_view+6+3*num_tibia_edge_second_view+...
    6+3*num_edge_left_pin_first_view+3*num_edge_left_pin_second_view+6+3*num_edge_right_pin_first_view;
edge3dNWrd_right_pin_second_view_estd = reshape(X(index_X+1:index_X+3*num_edge_right_pin_second_view),3,[]); 
edge3dCam_right_pin_second_view_estd = ...
    R_cw_second_view_estd*( R_wn_right_pin_estd*edge3dNWrd_right_pin_second_view_estd + t_wn_right_pin_estd) + t_cw_second_view_estd; % transform pts in the world space to the camera space
uv_edge_right_pin_second_view_estd = K*(edge3dCam_right_pin_second_view_estd(1:3,:) ./ edge3dCam_right_pin_second_view_estd(3,:)); % uv estimation
uv_edge_right_pin_second_view_estd = uv_edge_right_pin_second_view_estd(1:2,:);

roi_bone_nearCamera = TibiaGrid.roi_bone_nearCamera.Location;
nail_points = pinGrid.nail_points;

%% project the 3D points and model points into 2D image plane
edge3dCam_model_first_view_estd = ...
    R_cw_first_view_estd*roi_bone_nearCamera'+ t_cw_first_view_estd; % transform model in the world space to the camera space
uv_TibiaModel_first_view_estd = K*(edge3dCam_model_first_view_estd(1:3,:) ./ edge3dCam_model_first_view_estd(3,:)); % uv estimation
uv_TibiaModel_first_view_estd = uv_TibiaModel_first_view_estd(1:2,:);

edge3dCam_model_second_view_estd = ...
    R_cw_second_view_estd*roi_bone_nearCamera'+ t_cw_second_view_estd; % transform model in the world space to the camera space
uv_tibiaModel_second_view_estd = K*(edge3dCam_model_second_view_estd(1:3,:) ./ edge3dCam_model_second_view_estd(3,:)); % uv estimation
uv_tibiaModel_second_view_estd = uv_tibiaModel_second_view_estd(1:2,:);

edge3dCam_leftPinModel_first_view_estd = R_cw_first_view_estd*( R_wn_left_pin_estd*nail_points' + t_wn_left_pin_estd) + t_cw_first_view_estd;
uv_edge_left_pinModel_first_view_estd = K*(edge3dCam_leftPinModel_first_view_estd(1:3,:) ./ edge3dCam_leftPinModel_first_view_estd(3,:)); % uv estimation
uv_edge_left_pinModel_first_view_estd = uv_edge_left_pinModel_first_view_estd(1:2,:);

edge3dCam_rightPinModel_first_view_estd = R_cw_first_view_estd*( R_wn_right_pin_estd*nail_points' + t_wn_right_pin_estd) + t_cw_first_view_estd;
uv_edge_right_pinModel_first_view_estd = K*(edge3dCam_rightPinModel_first_view_estd(1:3,:) ./ edge3dCam_rightPinModel_first_view_estd(3,:)); % uv estimation
uv_edge_right_pinModel_first_view_estd = uv_edge_right_pinModel_first_view_estd(1:2,:);

edge3dCam_leftPinModel_second_view_estd = R_cw_second_view_estd*( R_wn_left_pin_estd*nail_points' + t_wn_left_pin_estd) + t_cw_second_view_estd;
uv_edge_left_pinModel_second_view_estd = K*(edge3dCam_leftPinModel_second_view_estd(1:3,:) ./ edge3dCam_leftPinModel_second_view_estd(3,:)); % uv estimation
uv_edge_left_pinModel_second_view_estd = uv_edge_left_pinModel_second_view_estd(1:2,:);

edge3dCam_rightPinModel_second_view_estd = R_cw_second_view_estd*( R_wn_right_pin_estd*nail_points' + t_wn_right_pin_estd) + t_cw_second_view_estd;
uv_edge_right_pinModel_second_view_estd = K*(edge3dCam_rightPinModel_second_view_estd(1:3,:) ./ edge3dCam_rightPinModel_second_view_estd(3,:)); % uv estimation
uv_edge_right_pinModel_second_view_estd = uv_edge_right_pinModel_second_view_estd(1:2,:);

figure(1)
imshow(depth_tibia_projection_first_view)
hold on
plot(uv_TibiaModel_first_view_estd(1,:), uv_TibiaModel_first_view_estd(2,:),'y.')
plot(observation_tibia_first_view(:,1),observation_tibia_first_view(:,2),'r.');
plot(uv_edge_left_pin_first_view_gt(1,:),uv_edge_left_pin_first_view_gt(2,:),'r.');
plot(uv_edge_right_pin_first_view_gt(1,:),uv_edge_right_pin_first_view_gt(2,:),'r.');
plot(uv_edge_left_pinModel_first_view_estd(1,:),uv_edge_left_pinModel_first_view_estd(2,:),'b--')
plot(uv_edge_right_pinModel_first_view_estd(1,:),uv_edge_right_pinModel_first_view_estd(2,:),'b--');
hold off

pause(0.5)
figure(2)
imshow(depth_tibia_projection_second_view)
hold on
plot(uv_tibiaModel_second_view_estd(1,1:1:end), uv_tibiaModel_second_view_estd(2,1:1:end),'y.')
plot(observation_tibia_second_view(1:1:end,1),observation_tibia_second_view(1:1:end,2),'r-');
plot(uv_edge_left_pin_second_view_gt(1,:),uv_edge_left_pin_second_view_gt(2,:),'r-');
plot(uv_edge_right_pin_second_view_gt(1,:),uv_edge_right_pin_second_view_gt(2,:),'r-');
plot(uv_edge_left_pinModel_second_view_estd(1,:),uv_edge_left_pinModel_second_view_estd(2,:),'b.')
plot(uv_edge_right_pinModel_second_view_estd(1,:),uv_edge_right_pinModel_second_view_estd(2,:),'b.');
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compare the 3D back-projection points and ground truth in the tibia model frame
leftNailModel_world_estd = R_wn_left_pin_estd*nail_points' + t_wn_left_pin_estd;
rightNailModel_world_estd = R_wn_right_pin_estd*nail_points' + t_wn_right_pin_estd;
leftNailModel_world_gt = R_nw_left_pin_initial*nail_points' + t_wn_left_pin_initial;
rightNailModel_world_gt = R_wn_right_pin_initial*nail_points' + t_wn_right_pin_initial;

edge3W_left_pin_first_view_estd = R_wn_left_pin_estd*edge3dNWrd_left_pin_first_view_estd + t_wn_left_pin_estd;
edge3W_left_pin_second_view_estd = R_wn_left_pin_estd*edge3dNWrd_left_pin_second_view_estd + t_wn_left_pin_estd;
edge3W_right_pin_first_view_estd = R_wn_right_pin_estd*edge3dNWrd_right_pin_first_view_estd + t_wn_right_pin_estd;
edge3W_right_pin_second_view_estd = R_wn_right_pin_estd*edge3dNWrd_right_pin_second_view_estd + t_wn_right_pin_estd; 

figure(3) % first view
hold on
plot3(edge3dWrd_tibia_frame_first_view_estd(1,:),edge3dWrd_tibia_frame_first_view_estd(2,:),...
    edge3dWrd_tibia_frame_first_view_estd(3,:),'ms','MarkerSize',1.5);
plot3(edge3W_left_pin_first_view_estd(1,:),edge3W_left_pin_first_view_estd(2,:),...
    edge3W_left_pin_first_view_estd(3,:),'gs','MarkerSize',1.5);

plot3(edge3dWrd_tibia_first_view(1,:),edge3dWrd_tibia_first_view(2,:),...
    edge3dWrd_tibia_first_view(3,:),'bs','MarkerSize',1.5);
plot3(edge3dWrd_left_pin_first_view(1,:),edge3dWrd_left_pin_first_view(2,:),...
    edge3dWrd_left_pin_first_view(3,:),'bs','MarkerSize',1.5);
plot3(edge3dWrd_right_pin_first_view(1,:),edge3dWrd_right_pin_first_view(2,:),...
    edge3dWrd_right_pin_first_view(3,:),'bs','MarkerSize',1.5);

plot3(edge3W_right_pin_first_view_estd(1,:),edge3W_right_pin_first_view_estd(2,:),...
     edge3W_right_pin_first_view_estd(3,:),'gs','MarkerSize',1.5);
patch('Faces',pinGrid.nail_tri,'Vertices', leftNailModel_world_estd',...
    'FaceColor', [0.4,0.4,0.4], 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',1);
patch('Faces',pinGrid.nail_tri,'Vertices', rightNailModel_world_estd',...
    'FaceColor', [0.4,0.4,0.4], 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',1);
patch('Faces',TibiaGrid.roi_bone_nearCamera_tri,'Vertices', roi_bone_nearCamera,...
    'FaceColor', [0.8,0.8,1.0], 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',0.5);
material('dull')
view([0 270]);
h = camlight('headlight');
set(gca,'XColor','none','Ycolor','none','Zcolor','none')
set(gcf,'color','w');
set(gca,'color','w');
%axis equal
legend('tibia and fibula contour back-projection','pin contour back-projection',...
    'ground truth of tibia and fibula contour back-projection','ground truth of pin contour back-projection');
legend('Location','northwest')
camlight(h,'headlight');
axis('image')
camorbit(gca, 20, 0, 'data', [0, 1, 0])
hold off

figure(4) % second view
hold on
plot3(edge3dWrd_tibia_frame_second_view_estd(1,:),edge3dWrd_tibia_frame_second_view_estd(2,:),...
    edge3dWrd_tibia_frame_second_view_estd(3,:),'ms','MarkerSize',1.5);
plot3(edge3W_left_pin_second_view_estd(1,:),edge3W_left_pin_second_view_estd(2,:),...
    edge3W_left_pin_second_view_estd(3,:),'gs','MarkerSize',1.5);

plot3(edge3dWrd_tibia_second_view(1,:),edge3dWrd_tibia_second_view(2,:),...
    edge3dWrd_tibia_second_view(3,:),'bs','MarkerSize',1.5);
plot3(edge3dWrd_left_pin_second_view(1,:),edge3dWrd_left_pin_second_view(2,:),...
    edge3dWrd_left_pin_second_view(3,:),'bs','MarkerSize',1.5);
plot3(edge3dWrd_right_pin_second_view(1,:),edge3dWrd_right_pin_second_view(2,:),...
    edge3dWrd_right_pin_second_view(3,:),'bs','MarkerSize',1.5);
plot3(edge3W_right_pin_second_view_estd(1,:),edge3W_right_pin_second_view_estd(2,:),...
     edge3W_right_pin_second_view_estd(3,:),'gs','MarkerSize',1.5);
patch('Faces',pinGrid.nail_tri,'Vertices', leftNailModel_world_estd',...
    'FaceColor', [0.4,0.4,0.4], 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',1);
patch('Faces',pinGrid.nail_tri,'Vertices', rightNailModel_world_estd',...
    'FaceColor', [0.4,0.4,0.4], 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',1);
patch('Faces',TibiaGrid.roi_bone_nearCamera_tri,'Vertices', roi_bone_nearCamera,...
    'FaceColor', [0.8,0.8,1.0], 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',0.5);
material('dull')
view([0 270]);
h = camlight('headlight');
set(gca,'XColor','none','Ycolor','none','Zcolor','none')
set(gcf,'color','w');
set(gca,'color','w');
%axis equal
legend('tibia and fibula contour back-projection','pin contour back-projection',...
    'ground truth of tibia and fibula contour back-projection','ground truth of pin contour back-projection');
legend('Location','northwest')
camlight(h,'headlight');
axis('image')
camorbit(gca, 20, 0, 'data', [0, 1, 0])
hold off

%% compare the estimated pins and ground truth in the tibia model
figure(5)
hold on
patch('Faces',pinGrid.nail_tri,'Vertices', leftNailModel_world_gt',...
    'FaceColor','r', 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',0.4);
patch('Faces',pinGrid.nail_tri,'Vertices', leftNailModel_world_estd',...
    'FaceColor', [0.4,0.4,0.4], 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',1.0);
patch('Faces',pinGrid.nail_tri,'Vertices', rightNailModel_world_estd',...
    'FaceColor', [0.4,0.4,0.4], 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',1.0);
patch('Faces',TibiaGrid.roi_bone_nearCamera_tri,'Vertices', roi_bone_nearCamera,...
    'FaceColor', [0.8,0.8,1.0], 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',0.5);
patch('Faces',pinGrid.nail_tri,'Vertices', rightNailModel_world_gt',...
    'FaceColor','r', 'EdgeColor','none', 'FaceLighting','gouraud',...
    'AmbientStrength',0.15,'FaceAlpha',0.4);
material('dull')
view([0 270]);
h = camlight('headlight');
set(gca,'XColor','none','Ycolor','none','Zcolor','none')
set(gcf,'color','w');
set(gca,'color','w');
%axis equal
legend('groun truth pins','estimated pins');
legend('Location','northwest')
camlight(h,'headlight');
axis('image')
camorbit(gca, 20, 0, 'data', [0, 1, 0])
hold off



