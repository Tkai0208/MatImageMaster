function extractLBPFeatures(image_path, target_image_path)
    % 读取原始图像
    img = imread(image_path);
    
    % 确保图像是灰度图像
    if size(img, 3) == 3
        gray_img = rgb2gray(img);
    else
        gray_img = img;
    end
    
    % 读取目标图像
    target_img = imread(target_image_path);
    
    % 确保目标图像是灰度图像
    if size(target_img, 3) == 3
        gray_target_img = rgb2gray(target_img);
    else
        gray_target_img = target_img;
    end
    
    % 对原始图像进行特征提取
    [original_lbp_features, original_lbp_hist] = computeLBP(gray_img);
    
    % 对目标图像进行特征提取
    [target_lbp_features, target_lbp_hist] = computeLBP(gray_target_img);
    
    % 显示结果
    figure;
    subplot(2, 3, 1); imshow(gray_img); title('原始图像');
    subplot(2, 3, 2); imshow(original_lbp_features, []); title('原始图像 LBP 特征');
    subplot(2, 3, 4); imshow(gray_target_img); title('目标图像');
    subplot(2, 3, 5); imshow(target_lbp_features, []); title('目标图像 LBP 特征');
    subplot(2, 3, 3); bar(original_lbp_hist); title('原始图像 LBP 直方图');
    subplot(2, 3, 6); bar(target_lbp_hist); title('目标图像 LBP 直方图');
end

% 计算 LBP 特征和直方图的辅助函数
function [lbpFeatures, lbpHist] = computeLBP(grayImage)
    [rows, cols] = size(grayImage);
    lbpFeatures = zeros(rows - 2, cols - 2);
    lbpHist = zeros(1, 256); % 初始化直方图
    
    for i = 2:rows-1
        for j = 2:cols-1
            center = grayImage(i, j);
            binaryString = '';
            
            neighbors = [i-1 j-1; i-1 j; i-1 j+1; i j-1; i j+1; i+1 j-1; i+1 j; i+1 j+1];
            
            for k = 1:8
                neighbor = grayImage(neighbors(k, 1), neighbors(k, 2));
                if neighbor >= center
                    binaryString = [binaryString '1'];
                else
                    binaryString = [binaryString '0'];
                end
            end
            
            lbpValue = bin2dec(binaryString);
            lbpFeatures(i-1, j-1) = lbpValue;
            lbpHist(lbpValue + 1) = lbpHist(lbpValue + 1) + 1; % 索引从1开始
        end
    end
end