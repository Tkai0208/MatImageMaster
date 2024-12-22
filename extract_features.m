function extract_features(imagePath1, imagePath2)
    % 读取原始图像和目标图像
    originalImage = imread(imagePath1);
    targetImage = imread(imagePath2);
    
    % 转换为灰度图像
    grayOriginal = rgb2gray(originalImage);
    grayTarget = rgb2gray(targetImage);
    
    % 提取 LBP 特征
    P = 8; % LBP 邻域点数
    R = 1; % LBP 邻域半径
    lbpOriginal = extractLBPFeatures(grayOriginal, P, R);
    lbpTarget = extractLBPFeatures(grayTarget, P, R);
    
    % 提取 HOG 特征
    [hogFeaturesOriginal, hogVisualizationOriginal] = extractHOGFeatures(grayOriginal);
    [hogFeaturesTarget, hogVisualizationTarget] = extractHOGFeatures(grayTarget);
    
    % 显示 HOG 可视化结果
    figure;
    subplot(2,2,1), imshow(grayOriginal), title('Original Image');
    subplot(2,2,2), imshow(grayTarget), title('Target Image');
    subplot(2,2,3), imshow(hogVisualizationOriginal, []), title('Original Image HOG');
    subplot(2,2,4), imshow(hogVisualizationTarget, []), title('Target Image HOG');
end

function lbpFeatures = extractLBPFeatures(grayImage, P, R)
    % 获取图像尺寸
    [rows, cols] = size(grayImage);
    % 初始化 LBP 图像
    lbpFeatures = zeros(rows - 2 * R, cols - 2 * R);
    
    % 定义邻域偏移量
    offsets = [0 -1 1 -1 -1 0 1 1; -1 0 1 0 1 -1 1 0] * R;
    
    % 计算 LBP 值
    for i = R+1:rows-R
        for j = R+1:cols-R
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
            lbpFeatures(i-R, j-R) = bin2dec(binaryString);
        end
    end
end

function [hogFeatures, hogVisualization] = extractHOGFeatures(grayImage)
    % 参数设置
    cellSize = 8; % 单元格大小
    blockSize = 2 * cellSize; % 块大小
    numBins = 9; % 直方图的bin数量
    
    % 计算图像梯度
    [Ix, Iy] = gradient(grayImage);
    mag = sqrt(Ix.^2 + Iy.^2);
    angle = atan2(Iy, Ix);
    
    % 初始化HOG特征向量
    [rows, cols] = size(grayImage);
    numCellsRows = floor((rows - blockSize) / cellSize);
    numCellsCols = floor((cols - blockSize) / cellSize);
    hogFeatures = zeros(numCellsRows * numCellsCols * numBins, 1);
    
    % 计算每个单元格的梯度直方图
    for i = 1:numCellsRows
        for j = 1:numCellsCols
            cellStartRow = (i-1) * cellSize + 1;
            cellEndRow = cellStartRow + cellSize - 1;
            cellStartCol = (j-1) * cellSize + 1;
            cellEndCol = cellStartCol + cellSize - 1;
            
            for x = cellStartRow:cellEndRow
                for y = cellStartCol:cellEndCol
                    bin = floor((angle(x,y) + pi) / (2 * pi / numBins)) + 1;
                    hogFeatures((i-1)*numCellsCols*numBins + (j-1)*numBins + bin) = hogFeatures((i-1)*numCellsCols*numBins + (j-1)*numBins + bin) + mag(x,y);
                end
            end
        end
    end
    
    % 可视化HOG特征
    hogVisualization = grayImage;
end