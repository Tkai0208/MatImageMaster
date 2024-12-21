function contrast_enhancement(image_path)
    % 读取图像并转换为灰度图像
    img = imread(image_path);
    gray_img = rgb2gray(img);

    % 线性变换
    linear_transformed = imadjust(gray_img, [0.2 0.8], []);
    subplot(2, 2, 1);
    imshow(linear_transformed);
    title('线性变换');

    % 对数变换
    log_transformed = log(1 + double(gray_img));
    log_transformed = imadjust(log_transformed, [], []);
    subplot(2, 2, 2);
    imshow(uint8(log_transformed * 255)); % 将结果转换为uint8格式
    title('对数变换');

    % 指数变换
    exp_transformed = exp(double(gray_img) - 1);
    exp_transformed = imadjust(exp_transformed, [], []);
    subplot(2, 2, 3);
    imshow(uint8(exp_transformed * 255)); % 将结果转换为uint8格式
    title('指数变换');
    
    % 显示原始灰度图像
    subplot(2, 2, 4);
    imshow(gray_img);
    title('原始灰度图像');
end