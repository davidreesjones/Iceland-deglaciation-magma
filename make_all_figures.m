close all
clear
if ~exist('./figures/','dir')
    mkdir './figures/';
end
fig_dir='./figures/';
addpath('src','utilities/')
figure_init

fnum=1; fig=figure(fnum);
size_scale=9.64/19.0; create_3by2_figure
figure_timeseries

fnum=2; fig=figure(fnum);
size_scale=3.3/9.5; create_2by1_figure
figure_nonlinear_lambda_equiv_example

fnum=3; fig=figure(fnum);
size_scale=6.49/19.0; create_1by2_figure
figure_nonlinear_lambda_equiv

fnum=4; fig=figure(fnum);
size_scale=6.49/19.0; create_1by2_figure
figure_characteristics

fnum=5; fig=figure(fnum);
size_scale=9.6800/19.0; create_1by3_figure
figure_geometry