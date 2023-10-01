close all
clc
clear all

colordef black

load('data4.mat','C0_t','C1_t','C2_t','C3_t','C4_t','C5_t','EE_t_5', 'Oj1_t','Oj2_t','Oj3_t','Oj4_t','Oj5_t', 'com','thetas');

thetas = rad2deg(thetas);

x_position = 200;   % X position of the figure
y_position = 50;   % Y position of the figure
width = 1280;        % Width of the figure
height = 720;       % Height of the figure

% Create a new figure with the desired size
figure('Position', [x_position, y_position, width, height], 'Color','black');
xlabel('X-axis')
ylabel('Y-axis')

% Create a VideoWriter object
video_name = 'animation_video.mp4'; 
video = VideoWriter(video_name, 'MPEG-4');
video.FrameRate = 30;  
% Set the video quality 
video.Quality = 100; 
open(video);

% Loop through each time step
for t = 1:size(thetas, 1)
    clf
    hold on
    grid minor

    % Plot the trajectories
    plot(C0_t(1:t,1),C0_t(1:t,2), '-w', 'LineWidth',1.5);
    plot(C1_t(1:t,1),C1_t(1:t,2), '-r', 'LineWidth',1.5);
    plot(C2_t(1:t,1),C2_t(1:t,2), '-b', 'LineWidth',1.5);
    plot(C3_t(1:t,1),C3_t(1:t,2), '-g', 'LineWidth',1.5);
    plot(C4_t(1:t,1),C4_t(1:t,2), '-y', 'LineWidth',1.5);
    plot(C5_t(1:t,1),C5_t(1:t,2), '-m', 'LineWidth',1.5);
       
    x_center0 = C0_t(t,1);
    y_center0 = C0_t(t,2);
    
    N.x_v1 = Oj1_t(t,1);
    N.y_v1 = Oj1_t(t,2);
    N.x_v2 = Oj2_t(t,1);
    N.y_v2 = Oj2_t(t,2);
    N.x_v3 = Oj3_t(t,1);
    N.y_v3 = Oj3_t(t,2);
    N.x_v4 = Oj4_t(t,1);
    N.y_v4 = Oj4_t(t,2);
    N.x_v5 = Oj5_t(t,1);
    N.y_v5 = Oj5_t(t,2);
    N.x_v6 = EE_t_5(t,1);
    N.y_v6 = EE_t_5(t,2);

    % Size of the region to zoom in
    region_size = 10; % Size of the region around the center point

    % Compute axis limits
    x_min = x_center0 - region_size/2;
    x_max = x_center0 + region_size/2;
    y_min = y_center0 - region_size/2;
    y_max = y_center0 + region_size/2;

    % Set the axis limits
    xlim([x_min, x_max]);
    ylim([y_min, y_max]);
    

    % Plot the base and links of the robotic arm
    plotBase2(x_center0, y_center0, Oj1_t(t,1), Oj1_t(t,2))
    plotLinks(N);
    axis("equal")
        
    % Display the actual time
    [minutes, seconds] = actual_time(t);
    annotation_time = annotation('textbox', [0.2, 0.85, 0.1, 0.1], 'Color', 'white', 'BackgroundColor', 'none', 'FitBoxToText', 'on', 'FontSize', 15, 'EdgeColor','none', 'Interpreter','latex');
    annotation_time.String = sprintf('Actual time: %d:%02d\n', minutes, seconds);
    
    % Display the angles
    annotation_angles = annotation('textbox', [0.85, 0.9, 0.1, 0.1], 'Color', 'white', 'BackgroundColor', 'none', 'FitBoxToText', 'on', 'FontSize', 15, 'EdgeColor','none', 'Interpreter','latex');
    annotation_angles.String = sprintf('$\\theta_{0}$: %.3f$^\\circ$\n$\\theta_{1}$: %.3f$^\\circ$\n$\\theta_{2}$: %.3f$^\\circ$\n$\\theta_{3}$: %.3f$^\\circ$\n$\\theta_{4}$: %.3f$^\\circ$\n$\\theta_{5}$: %.3f$^\\circ$\n', thetas(t,1), thetas(t,2), thetas(t,3),thetas(t,4),thetas(t,5),thetas(t,6));
    
    drawnow

    % Capture the current figure as a frame in the video
    frame = getframe(gcf);
    writeVideo(video, frame);
    
end

% Close the video file
close(video);
