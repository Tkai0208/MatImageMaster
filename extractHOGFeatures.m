function extractHOGFeatures(imagePath1, imagePath2)
    % 读取原始图像和目标图像
    originalImage = imread(imagePath1);
    targetImage = imread(imagePath2);
    
    % 转换为灰度图像
    grayOriginal = rgb2gray(originalImage);
    grayTarget = rgb2gray(targetImage);
    
    % 图像归一化
    grayOriginal = imadjust(grayOriginal);
    grayTarget = imadjust(grayTarget);
    
    % 计算梯度
    [Gx, Gy] = gradient(double(grayOriginal));
    [GxTarget, GyTarget] = gradient(double(grayTarget));
    
    % 计算梯度幅度和方向
    GradOriginal = sqrt(Gx.^2 + Gy.^2);
    GradTarget = sqrt(GxTarget.^2 + GyTarget.^2);
    PhaseOriginal = atan2(Gy, Gx);
    PhaseTarget = atan2(GyTarget, GxTarget);
    
    % 梯度方向量化
    numBins = 9;
    angle = 180 / numBins;
    PhaseOriginal = mod(PhaseOriginal + pi, 2*pi) * (numBins / (2*pi));
    PhaseTarget = mod(PhaseTarget + pi, 2*pi) * (numBins / (2*pi));
    
    % 梯度直方图
    [HistOriginal, ~] = histcounts(PhaseOriginal(:), 0:angle:angle*numBins);
    [HistTarget, ~] = histcounts(PhaseTarget(:), 0:angle:angle*numBins);
    
    % 归一化
    HistOriginal = HistOriginal / sum(HistOriginal);
    HistTarget = HistTarget / sum(HistTarget);
    
    % 显示 HOG 特征
    figure;
    subplot(1,2,1), bar(HistOriginal), title('Original Image HOG Features');
    subplot(1,2,2), bar(HistTarget), title('Target Image HOG Features');
end