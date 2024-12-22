function extractLBPFeatures(image_path, target_image_path)
    % 读取原始图像
    img = imread(image_path);
    
    % 确保图像是灰度图像
    if size(img, 3) == 3 % 检查是否是彩色图像
        gray_img = rgb2gray(img); % 将彩色图像转换为灰度图像
    else
        gray_img = img; % 如果已经是灰度图像，则保持不变
    end
    
    % 读取目标图像
    target_img = imread(target_image_path);
    
    % 确保目标图像是灰度图像
    if size(target_img, 3) == 3 % 检查是否是彩色图像
        gray_target_img = rgb2gray(target_img); % 将彩色图像转换为灰度图像
    else
        gray_target_img = target_img; % 如果已经是灰度图像，则保持不变
    end
    
    % 对原始图像进行特征提取
    original_lbp_features = computeLBP(gray_img);
    
    % 对目标图像进行特征提取
    target_lbp_features = computeLBP(gray_target_img);
    
    % 显示结果
    figure;
    subplot(2, 2, 1); imshow(gray_img); title('原始图像');
    subplot(2, 2, 2); imshow(original_lbp_features, []); title('原始图像 LBP 特征');
    subplot(2, 2, 3); imshow(gray_target_img); title('目标图像');
    subplot(2, 2, 4); imshow(target_lbp_features, []); title('目标图像 LBP 特征');
end

% 计算 LBP 特征的辅助函数
function lbpFeatures = computeLBP(grayImage)
    % 获取图像尺寸
    [rows, cols] = size(grayImage);
    
    % 初始化 LBP 图像
    lbpFeatures = zeros(rows - 2, cols - 2);
    
    % 计算 LBP 值
    for i = 2:rows-1
        for j = 2:cols-1
            center = grayImage(i, j);
            binaryString = '';
            
            % 定义邻域像素的索引
            neighbors = [i-1 j-1; i-1 j; i-1 j+1; i j-1; i j+1; i+1 j-1; i+1 j; i+1 j+1];
            
            for k = 1:8
                neighbor = grayImage(neighbors(k, 1), neighbors(k, 2));
                if neighbor >= center
                    binaryString = [binaryString '1'];
                else
                    binaryString = [binaryString '0'];
                end
            end
            
            % 将二进制字符串转换为十进制数
            lbpFeatures(i-1, j-1) = bin2dec(binaryString);
        end
    end
end