function transform_image(image_path)
    % 读取图像
    img = imread(image_path);

    % 创建一个新的图形窗口，并设置为2x2布局
    figure;

    % 显示原始图像
    subplot(2, 2, 1);
    imshow(img);
    title('原始图像');

    % 缩放
    scaled_img = imresize(img, 0.5);
    
    % 使用 imshowpair 同时显示原始图像和缩放后的图像
    subplot(2, 2, 2);
    imshowpair(img, scaled_img, 'montage');
    title('原始图像 vs 缩放后的图像');

    % 旋转
    rotated_img = imrotate(img, 45, 'bilinear', 'crop');
    subplot(2, 2, 3);
    imshow(rotated_img);
    title('旋转后的图像');
    
    % 如果需要展示更多的变换，可以使用第四个subplot
    subplot(2, 2, 4);
    % 这里可以放置其他的图像处理操作和展示结果
    % imshow(other_transformed_img);
    % title('其他变换后的图像');
end