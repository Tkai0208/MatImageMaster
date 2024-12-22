function extract_objects(image_path)
    % 读取图像
    img = imread(image_path);
    
    % 确保图像是灰度图像
    if size(img, 3) == 3 % 检查是否是彩色图像
        gray_img = rgb2gray(img); % 将彩色图像转换为灰度图像
    else
        gray_img = img; % 如果已经是灰度图像，则保持不变
    end
    
    % 边缘检测
    edge_img = edge(gray_img, 'Canny');
    
    % 连通区域标记
    labeled_img = logical(edge_img);
    
    % 获取每个连通区域的属性
    stats = regionprops(labeled_img, 'BoundingBox', 'Area', 'Centroid');
    
    % 过滤掉面积过小的区域
    min_area = 1000; % 设置最小面积阈值
    valid_stats = [stats([stats.Area] > min_area)];
    
    % 提取并展示目标区域
    figure;
    subplot(2, 2, 1); imshow(img); title('原始图像');
    subplot(2, 2, 2); imshow(edge_img); title('边缘检测结果');
    
    for i = 1:length(valid_stats)
        bbox = round(valid_stats(i).BoundingBox); % 四舍五入边界框坐标
        
        % 确保索引不会超出图像尺寸
        rows = size(img, 1);
        cols = size(img, 2);
        x_start = max(1, bbox(1));
        y_start = max(1, bbox(2));
        x_end = min(cols, bbox(1) + bbox(3) - 1);
        y_end = min(rows, bbox(2) + bbox(4) - 1);
        
        % 提取目标区域
        if x_end >= x_start && y_end >= y_start
            extracted_region = img(y_start:y_end, x_start:x_end, :);
            
            subplot(2, 2, 3); imshow(extracted_region); title(['目标区域 ', num2str(i)]);
        end
    end
end