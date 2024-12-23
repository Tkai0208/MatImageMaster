function transform_image(image_path)

    % 读取图像
    img = imread(image_path);

    % 创建一个新的图形窗口
    figure;

    % 第一个subplot显示原始图像
    subplot(2, 2, 1); % 1行2列的第1个位置
    imshow(img);
    title('原始图像');

    % 第二个subplot显示原始图像和缩放后的图像
    subplot(2, 2, 2); % 1行2列的第2个位置
    scaled_img = imresize(img, 0.5); % 缩放图像
    imshowpair(img, scaled_img, 'montage');
    title('原始图像与缩放后的图像');

    % 旋转
    rotated_img = imrotate(img, 45, 'bilinear', 'crop');
    subplot(2, 2, 3);
    imshow(rotated_img);
    title('旋转后的图像');

    % 亮度调整
    adjusted_brightness_img = imadjust(img, [0.2 0.8], [], 1);
    subplot(2, 2, 4);
    imshow(adjusted_brightness_img);
    title('亮度调整后的图像');
end