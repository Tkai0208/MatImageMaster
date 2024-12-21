function enhancedImages = contrast_enhancement(image_path)
    % 读取图像
    originalImage = imread(image_path); ...

    % 灰度化
    grayImage = rgb2gray(originalImage); ...

    % 线性对比度增强
    linearEnhancedImage = imadjust(grayImage); ...

    % 非线性对比度增强 - 对数变换
    logEnhancedImage = imadjust(mat2gray(grayImage), [], []); ... % 归一化并调整对比度
    logEnhancedImage = log(1 + logEnhancedImage); ...            % 应用对数变换
    logEnhancedImage = mat2gray(logEnhancedImage); ...           % 重新归一化到[0,1]

    % 非线性对比度增强 - 指数变换
    expEnhancedImage = imadjust(mat2gray(grayImage), [], []); ... % 归一化并调整对比度
    expEnhancedImage = exp(expEnhancedImage - 1); ...            % 应用指数变换
    expEnhancedImage = mat2gray(expEnhancedImage); ...           % 重新归一化到[0,1]

    % 将结果存储在cell数组中，方便返回多个图像
    enhancedImages = {
        grayImage;           % 原始灰度图像
        linearEnhancedImage; % 线性对比度增强图像
        logEnhancedImage;    % 对数对比度增强图像
        expEnhancedImage     % 指数对比度增强图像
    };

    % 显示结果
    figure;
    subplot(2,2,1), imshow(enhancedImages{1}), title('原始灰度图像'); ...
    subplot(2,2,2), imshow(enhancedImages{2}), title('线性对比度增强'); ...
    subplot(2,2,3), imshow(enhancedImages{3}), title('对数对比度增强'); ...
    subplot(2,2,4), imshow(enhancedImages{4}), title('指数对比度增强'); ...

    % 确保图像窗口立即显示
    drawnow;
end