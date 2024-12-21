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
    log_transformed = imadjust(log(1 + double(gray_img)), [], []);
    subplot(2, 2, 2);
    imshow(log_transformed);
    title('对数变换');

    % 指数变换
    exp_transformed = imadjust(exp(double(gray_img) - 1), [], []);
    subplot(2, 2, 3);
    imshow(exp_transformed);
    title('指数变换');
end