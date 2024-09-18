%% Tracking Pedestrians Live - ACF vs. Yolo
%

%% Init
clearvars; close all; clc;

load('acfDetector.mat');

detector1 = acfDetector;

v = videoinput("winvideo", 1, "MJPG_320x240");
v.ReturnedColorspace = "rgb";


%% Elements
% Init Figures
F1 = figure(1); 
set(F1,'Position',[10 50 600 400]); % get(0,'screensize') --> Beschränkung auf MacBook !
% Init control elements
button_ende = uicontrol('Style', 'pushbutton', 'String', 'Ende','Position', [10 20 100 40], 'Callback', 'ende = 1;');
ende = 0; k_alt = 0;

%scale = 1280/720;
%scale = 480/360;
scale = (320/240)*1.5;

%  Init image1 axes
ax1_1 = axes('Position',[0.10 0.35 0.42*scale 0.84]);
%  Init image2 axes
%ax1_2 = axes('Position',[0.05 0.1 0.42*scale 0.42]);

%% Detection
% Detect people and track them across video frames.

while ende == 0

    frame = getsnapshot(v);
 
    % Detect objects with ACF people detector in the test image
     [bboxes,scores] = detect(detector1,frame);
     if bboxes
         for i = 1:length(scores)
             I1 = frame;
             if scores(i) > 90 
             annotation = sprintf('Confidence = %.1f',scores(i));
             I1 = insertObjectAnnotation(frame,'rectangle',bboxes(i,:),annotation);
             end
         end
         image(I1, 'Parent', ax1_1);
        %I1 = insertObjectAnnotation(frame,'rectangle',bboxes,scores);
        %image(I1, 'Parent', ax1_1);
     else
         image(frame, 'Parent', ax1_1);
     end

%     % Detect objects with Yolo in the test image
%     [bboxes,scores,labels] = detect(detector2,frame);
% % [bboxes,scores] = detect(detector2,frame);
% 
%     results = table(bboxes,scores);
%     % I2 = insertObjectAnnotation(frame,'Rectangle',bboxes,scores);
%     I2 = insertObjectAnnotation(frame,'Rectangle',bboxes,labels);
%     image(I2, 'Parent', ax1_2);
end


