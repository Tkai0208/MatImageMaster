function transform_image(image_path)

    % 读取图像
    img = imread(image_path);

    % 创建一个新的图形窗口
    figure;

    % 第一个subplot显示原始图像
    subplot(2, 3, 1); % 修改为2行3列布局，以便容纳新的翻转图像
    imshow(img);
    title('原始图像');

    % 第二个subplot显示原始图像和缩放后的图像
    subplot(2, 3, 2); 
    scaled_img = imresize(img, 0.5); % 缩放图像
    imshowpair(img, scaled_img, 'montage');
    title('原始图像与缩放后的图像');
    
    % 旋转
    rotated_img = imrotate(img, 45, 'bilinear', 'crop');
    subplot(2, 3, 3);
    imshow(rotated_img);
    title('旋转后的图像');

    % 亮度调整
    adjusted_brightness_img = imadjust(img, [0.2 0.8], [], 1);
    subplot(2, 3, 4);
    imshow(adjusted_brightness_img);
    title('亮度调整后的图像');

    % 镜像翻转（这里我们进行水平翻转）
    flipped_img = flip(img, 2); % 参数2表示沿第二维度（列方向）翻转，即水平翻转
    subplot(2, 3, 5);
    imshow(flipped_img);
    title('水平翻转后的图像');
    
    %垂直翻转
    vertical_flipped_img = flip(img, 1); % 参数1表示沿第一维度（行方向）翻转，即垂直翻转
    subplot(2, 3, 6);
    imshow(vertical_flipped_img);
    title('垂直翻转后的图像');
end