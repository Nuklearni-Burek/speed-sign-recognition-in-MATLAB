
image = 'H:\Downloads\Speeds\image (6).jpg';

img1 = imread(image);
img2 = imread(image);

load('acfDetector.mat');
load('acfDetectorNew.mat');

[bboxes,scores] = detect(acfDetector,img1);
for i = 1:length(scores)
   annotation = sprintf('Confidence = %.1f',scores(i));
    %if scores(i) > 90 
    img1 = insertObjectAnnotation(img1,'rectangle',bboxes(i,:),annotation);
    %end
end

figure(1)
imshow(img1)

[bboxes,scores] = detect(acfDetectorNew,img2);
for i = 1:length(scores)
   annotation = sprintf('Confidence = %.1f',scores(i));
    %if scores(i) > 90 
    img2 = insertObjectAnnotation(img2,'rectangle',bboxes(i,:),annotation);
    %end
end
figure(2)
imshow(img2)
