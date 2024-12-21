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
    ref_img_path = 'D:\MATLAB_Test\MatImageMaster\1.4.jpg'; % 替换为参考图像路径
    ref_img = imread(ref_img_path);
    ref_gray_img = rgb2gray(ref_img); % 确保参考图像也是灰度图像

    matched_img = histogram_matching_single_channel(double(gray_img), double(ref_gray_img));
    subplot(2, 3, 5);
    imshow(uint8(matched_img)); % 转换回uint8类型以便显示
    title('直方图匹配后的图像');
end

function matched_channel = histogram_matching_single_channel(source_channel, ref_channel)
    % 计算两个图像的直方图
    [source_hist, ~] = imhist(uint8(source_channel));
    [ref_hist, ~] = imhist(uint8(ref_channel));

    % 计算累积直方图
    source_cdf = cumsum(source_hist);
    ref_cdf = cumsum(ref_hist);

    % 归一化累积直方图
    source_cdf = source_cdf / max(source_cdf);
    ref_cdf = ref_cdf / max(ref_cdf);

    % 创建映射表
    mapping = interp1(ref_cdf, 0:255, source_cdf, 'nearest');

    % 应用映射表
    matched_channel = interp1(0:255, mapping, double(source_channel), 'nearest');
end