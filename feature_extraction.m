function feature_extraction(image_path)
    % 读取图像
    img = imread(image_path);
    
    % 确保图像是灰度图像，如果不是，则转换为灰度图像
    if size(img, 3) == 3 % 检查是否是彩色图像
        gray_img = rgb2gray(img); % 将彩色图像转换为灰度图像
    else
        gray_img = img; % 如果已经是灰度图像，则保持不变
    end
    
    % LBP特征提取
    lbp_img = localBinaryPattern(gray_img, 8, 1);
    figure;
    subplot(2, 1, 1);
    imshow(mat2gray(lbp_img)); % 使用 mat2gray 来保证显示正确
    title('LBP特征');
    
    % HOG特征提取
    [hog_features, visualization] = extractHOGFeatures(gray_img, 'CellSize', [8 8]);
    subplot(2, 1, 2);
    plot(hog_features);
    title('HOG特征');

    % 显示HOG特征可视化
    figure;
    imshow(img);
    hold on;
    plot(visualization);
    title('HOG特征可视化');
end