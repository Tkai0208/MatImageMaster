function transform_image(image_path, brightness_factor)

    % 读取图像
    img = imread(image_path);

    % 创建一个新的图形窗口
    figure;

    % 第一个subplot显示原始图像
    subplot(2, 3, 1); 
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
    if nargin > 1 && isnumeric(brightness_factor) && ~isempty(brightness_factor)
        % 根据亮度调整因子调整亮度
        % 这里使用了亮度调整因子来修改gamma值
        adjusted_brightness_img = imadjust(img, [], [], brightness_factor);
    else
        % 如果没有提供亮度调整因子或提供的不是数值，则使用默认的亮度调整
        adjusted_brightness_img = imadjust(img, [0.2 0.8], [], 1);
    end
    subplot(2, 3, 4);
    imshow(adjusted_brightness_img);
    title(['亮度调整后的图像 (Gamma: ', num2str(brightness_factor), ')']);

    % 镜像翻转（这里我们进行水平翻转）
    flipped_img = flip(img, 2); 
    subplot(2, 3, 5);
    imshow(flipped_img);
    title('水平翻转后的图像');
    
    % 垂直翻转
    vertical_flipped_img = flip(img, 1); 
    subplot(2, 3, 6);
    imshow(vertical_flipped_img);
    title('垂直翻转后的图像');
end