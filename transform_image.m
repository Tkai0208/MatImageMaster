function transform_image(image_path)
    % 读取图像
    img = imread(image_path);

    % 缩放
    scaled_img = imresize(img, 0.5);
    subplot(2, 2, 1);
    imshow(scaled_img);
    title('缩放后的图像');

    % 旋转
    rotated_img = imrotate(img, 45, 'bilinear', 'crop');
    subplot(2, 2, 2);
    imshow(rotated_img);
    title('旋转后的图像');
end