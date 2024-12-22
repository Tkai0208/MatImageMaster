function extract_target(imagePath)

    % 读入图像
    Image = imread(imagePath);
    gray = im2double(rgb2gray(Image));

    % 形态学梯度
    se = strel('disk', 2);
    edgeI = imdilate(gray, se) - imerode(gray, se);

    % 对比度增强
    enedgeI = imadjust(edgeI);

    % 梯度图像二值化
    BW = zeros(size(gray));
    BW(enedgeI > 0.1) = 1;

    % 闭运算闭合边界
    BW1 = imclose(BW, se);

    % 区域填充
    BW2 = imfill(BW1, 'holes');

    % 目标模板
    template = cat(3, BW2, BW2, BW2);

    % 目标提取
    result = template .* im2double(Image);

    % 显示结果
    figure;
    subplot(231), imshow(Image), title('原图');
    subplot(232), imshow(edgeI), title('形态学梯度图像');
    subplot(233), imshow(enedgeI), title('对比度增强');
    subplot(234), imshow(BW), title('梯度图像二值化');
    subplot(235), imshow(BW2), title('目标模板');
    subplot(236), imshow(result), title('目标提取');
end