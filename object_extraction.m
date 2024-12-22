function object_extraction(image_path)
    % 读取图像
    img = imread(image_path);

    % 使用阈值分割提取目标
    gray_img = rgb2gray(img);
    threshold = graythresh(gray_img);
    bw_img = imbinarize(gray_img, threshold);
    labeled_img = bwlabel(bw_img);
    stats = regionprops(labeled_img, 'BoundingBox');
    for i = 1:length(stats)
        bbox = stats(i).BoundingBox;
        subplot(2, 2, i);
        imshow(img);
        hold on;
        rectangle('Position', bbox, 'EdgeColor', 'r', 'LineWidth', 2);
        hold off;
        title(['目标区域']);
    end
end