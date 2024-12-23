function extract_target(imagePath)
    % 读入图像并显示
    Image = imread(imagePath);
    imshow(Image);
    title('请在图像上绘制目标区域');

    % 等待用户绘制目标区域
    drawn = drawfreehand;
    wait(drawn);
    drawnBW = createMask(drawn, Image);

    % 将用户绘制的区域作为前景
    foreground = drawnBW;

    % 形态学梯度
    se = strel('disk', 2);
    edgeI = imdilate(foreground, se) - imerode(foreground, se);

    % 对比度增强
    enedgeI = imadjust(edgeI);

    % 梯度图像二值化
    BW = imbinarize(enedgeI);

    % 闭运算闭合边界
    BW1 = imclose(BW, se);

    % 区域填充
    BW2 = imfill(BW1, 'holes');

    % 目标模板
    template = cat(3, BW2, BW2, BW2);

    % 目标提取
    result = template .* im2double(Image);

    % 保存提取的目标图像到当前目录
    savePath = 'extracted_target.png'; % 您可以根据需要更改文件名
    imwrite(result, savePath);

    % 显示结果
    figure;
    subplot(231), imshow(Image), title('原图');
    subplot(232), imshow(foreground), title('用户绘制的ROI');
    subplot(233), imshow(edgeI), title('形态学梯度图像');
    subplot(234), imshow(enedgeI), title('对比度增强');
    subplot(235), imshow(BW), title('梯度图像二值化');
    subplot(236), imshow(result), title('目标提取');
end