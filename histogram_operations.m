function histogram_operations(image_path)
    % 读取图像并转换为灰度图像
    img = imread(image_path);
    gray_img = rgb2gray(img);

    % 显示原始图像
    figure;
    subplot(2, 2, 1);
    imshow(gray_img);
    title('原始图像');

    % 计算灰度直方图
    [counts, bins] = imhist(gray_img);
    subplot(2, 2, 2);
    bar(bins, counts);
    title('灰度直方图');

    % 直方图均衡化
    eq_img = histeq(gray_img);
    subplot(2, 2, 3);
    imshow(eq_img);
    title('直方图均衡化后的图像');

    % 直方图匹配
    ref_img_path = 'D:\MATLAB_Test\MatImageMaster\1.4.jpg'; % 替换为参考图像路径
    ref_img = imread(ref_img_path);
    ref_gray_img = rgb2gray(ref_img); % 确保参考图像也是灰度图像

    matched_img = histogram_matching_single_channel(double(gray_img), double(ref_gray_img));
    subplot(2, 2, 4);
    imshow(uint8(matched_img)); % 转换回uint8类型以便显示
    title('直方图匹配后的图像');
end

function matched_channel = histogram_matching_single_channel(source_channel, ref_channel)
    % 计算两个图像的直方图
    source_hist = imhist(uint8(source_channel));
    ref_hist = imhist(uint8(ref_channel));

    % 计算累积直方图
    source_cdf = cumsum(source_hist) / sum(source_hist);
    ref_cdf = cumsum(ref_hist) / sum(ref_hist);

    % 确保CDF值唯一，并且处理边界情况
    [~, idx] = unique(ref_cdf, 'first'); % 获取唯一的CDF值及其索引
    ref_cdf_unique = ref_cdf(idx);       % 使用索引获取唯一的CDF值
    ref_bins_unique = 0:255;             % 创建完整的灰度级向量
    ref_bins_unique = ref_bins_unique(idx); % 使用相同的索引选择对应的灰度级

    % 创建映射表
    mapping = interp1(ref_cdf_unique, ref_bins_unique, source_cdf, 'nearest');

    % 应用映射表
    matched_channel = interp1(0:255, mapping, double(source_channel), 'nearest');
end