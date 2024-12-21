function histogram_operations(image_path)
    % 读取图像并转换为灰度图像
    img = imread(image_path);
    gray_img = rgb2gray(img);

    % 显示原始图像
    figure;
    subplot(2, 3, 1);
    imshow(gray_img);
    title('原始图像');

    % 计算灰度直方图
    [counts, bins] = imhist(gray_img);
    subplot(2, 3, 4);
    bar(bins, counts);
    title('灰度直方图');

    % 直方图均衡化
    eq_img = histeq(gray_img);
    subplot(2, 3, 2);
    imshow(eq_img);
    title('直方图均衡化后的图像');

    % 直方图匹配
    ref_img = imread('D:\MATLAB_Test\MatImageMaster\1.2.png'); % 替换为参考图像路径
    matched_img = adapthisteq(gray_img, 'ReferenceImage', ref_img);
    subplot(2, 3, 5);
    imshow(matched_img);
    title('直方图匹配后的图像');
end