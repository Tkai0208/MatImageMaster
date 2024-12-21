function contrast_enhancement(image_path)
   % 读取图像
    originalImage = imread(image_path);

    % 灰度化
    grayImage = rgb2gray(originalImage);

    % 线性对比度增强
    linearEnhancedImage = imadjust(grayImage);

    % 非线性对比度增强 - 对数变换
    logEnhancedImage = imadjust(mat2gray(grayImage), [], []); % 归一化并调整对比度
    logEnhancedImage = log(1 + logEnhancedImage); % 应用对数变换
    logEnhancedImage = mat2gray(logEnhancedImage); % 重新归一化到[0,1]

    % 非线性对比度增强 - 指数变换
    expEnhancedImage = imadjust(mat2gray(grayImage), [], []); % 归一化并调整对比度
    expEnhancedImage = exp(expEnhancedImage - 1); % 应用指数变换
    expEnhancedImage = mat2gray(expEnhancedImage); % 重新归一化到[0,1]

    % 将结果存储在cell数组中，方便返回多个图像
    enhancedImages = {grayImage, linearEnhancedImage, logEnhancedImage, expEnhancedImage};

    % 显示结果
    figure;
    subplot(2,2,1), imshow(grayImage), title('原始灰度图像');
    subplot(2,2,2), imshow(linearEnhancedImage), title('线性对比度增强');
    subplot(2,2,3), imshow(logEnhancedImage), title('对数对比度增强');
    subplot(2,2,4), imshow(expEnhancedImage), title('指数对比度增强');
end