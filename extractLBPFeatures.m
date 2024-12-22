function extractLBPFeatures(imagePath1, imagePath2)
    % 读取原始图像和目标图像
    originalImage = imread(imagePath1);
    targetImage = imread(imagePath2);
    
    % 转换为灰度图像
    grayOriginal = rgb2gray(originalImage);
    grayTarget = rgb2gray(targetImage);
    
    % 提取 LBP 特征
    lbpOriginal = customLocalBinaryPattern(grayOriginal);
    lbpTarget = customLocalBinaryPattern(grayTarget);
    
    % 显示 LBP 特征图
    figure;
    subplot(1,2,1), imshow(uint8(lbpOriginal)), title('Original Image LBP Features');
    subplot(1,2,2), imshow(uint8(lbpTarget)), title('Target Image LBP Features');
    
    % 显示第一个 8x8 子区域的 LBP 直方图
    subImOriginal = lbpOriginal(1:8, 1:8);
    subImTarget = lbpTarget(1:8, 1:8);
    figure;
    subplot(1,2,1), imhist(subImOriginal), title('Original Sub-Image LBP Histogram');
    subplot(1,2,2), imhist(subImTarget), title('Target Sub-Image LBP Histogram');
end

function lbp = customLocalBinaryPattern(grayImage)
    % 获取图像尺寸
    [rows, cols] = size(grayImage);
    % 初始化 LBP 图像
    lbp = zeros(rows-2, cols-2);
    
    % 定义邻域偏移量
    offsets = [0 -1 1; -1 0 1; -1 1 0] * 1; % 3x3 邻域偏移量
    
    % 计算 LBP 值
    for i = 2:rows-1
        for j = 2:cols-1
            center = grayImage(i, j);
             binaryString = '';
             for k = 1:size(offsets, 1)
                 neighbor = grayImage(i + offsets(k, 1), j + offsets(k, 2));
                 if neighbor >= center
                     binaryString = [binaryString '1'];
                 else
                     binaryString = [binaryString '0'];
                 end
             end
             lbp(i-1, j-1) = bin2dec(binaryString);
         end
     end
end