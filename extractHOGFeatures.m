function extractHOGFeatures(imagePath1, imagePath2)
    % 读取原始图像和目标图像
    originalImage = imread(imagePath1);
    targetImage = imread(imagePath2);
    
    % 转换为灰度图像
    grayOriginal = rgb2gray(originalImage);
    grayTarget = rgb2gray(targetImage);
    
    % 计算梯度
    [GxOriginal, GyOriginal] = gradient(double(grayOriginal));
    [GxTarget, GyTarget] = gradient(double(grayTarget));
    
    % 计算梯度幅度和方向
    GradMagnitudeOriginal = sqrt(GxOriginal.^2 + GyOriginal.^2);
    GradMagnitudeTarget = sqrt(GxTarget.^2 + GyTarget.^2);
    GradOrientationOriginal = atan2(GyOriginal, GxOriginal);
    GradOrientationTarget = atan2(GyTarget, GxTarget);
    
    % 梯度方向量化
    numBins = 9;
    binWidth = (pi / numBins);
    GradOrientationOriginal = mod((GradOrientationOriginal + pi) / binWidth, numBins);
    GradOrientationTarget = mod((GradOrientationTarget + pi) / binWidth, numBins);
    
    % 梯度直方图
    HistOriginal = histcounts(GradOrientationOriginal(:), 0:1:numBins-1);
    HistTarget = histcounts(GradOrientationTarget(:), 0:1:numBins-1);
    
    % 归一化
    HistOriginal = HistOriginal / sum(HistOriginal);
    HistTarget = HistTarget / sum(HistTarget);
    
    % 显示原始图像和目标图像
    figure;
    subplot(2,2,1), imshow(grayOriginal), title('原始图像');
    subplot(2,2,3), imshow(grayTarget), title('目标提取图像');
    
    % 显示 HOG 特征直方图
    subplot(2,2,2), bar(HistOriginal), title('原始图像 HOG 特征');
    subplot(2,2,4), bar(HistTarget), title('目标图像 HOG 特征');
end