function object_extraction(image_path)
    % 读取图像
    img = imread(image_path);
    
    % 显示原始图像
    figure;
    subplot(1,2,1); imshow(img); title('原始图像');
    
    % 预处理 - 转换为灰度图并进行高斯滤波降噪
    gray_img = rgb2gray(img);
    filtered_gray_img = imgaussfilt(gray_img, 2); % 标准差为2的高斯滤波
    
    % 自适应阈值分割以获得二值图像
    bw_img = imbinarize(filtered_gray_img, 'adaptive', 'Sensitivity', 0.4);
    
    % 形态学操作 - 填充孔洞和去除小对象
    se = strel('disk', 3); % 创建一个圆盘结构元素
    bw_filled = imfill(bw_img, 'holes'); % 填充孔洞
    bw_cleaned = bwareaopen(bw_filled, 50); % 移除面积小于50的对象
    
    % 连通区域标记与属性测量
    labeled_img = bwlabel(bw_cleaned);
    stats = regionprops(labeled_img, 'BoundingBox', 'Area', 'Centroid');

    % 过滤掉面积过小的区域
    min_area = 100; % 设置最小面积阈值
    valid_stats = [stats([stats.Area] > min_area)];

    % 绘制边界框并标注中心点
    subplot(1,2,2); imshow(img); hold on;
    for i = 1:length(valid_stats)
        bbox = valid_stats(i).BoundingBox;
        rectangle('Position', bbox, 'EdgeColor', 'r', 'LineWidth', 2);
        plot(valid_stats(i).Centroid(1), valid_stats(i).Centroid(2), 'bo'); % 绘制中心点
    end
    hold off;
    title('检测到的目标区域及中心点');
end