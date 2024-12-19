function detectLanesUsingEdges(imagePath)
    % 读取图像
    I = imread(imagePath);
    figure,imshow(I),title('原图');
    % 转换为灰度图像
    I_gray = rgb2gray(I);

    % 使用高斯滤波去除噪声
    I_blur = imgaussfilt(I_gray, 2);

    % 使用Canny算法进行边缘检测
    BW = edge(I_blur, 'canny');

    % 显示边缘检测结果
    figure,subplot(1,2,2);
    imshow(BW), title('边缘检测结果');

    % 使用霍夫变换检测直线
    [H, theta, rho] = hough(BW);
    peaks = houghpeaks(H, 5); % 寻找5个最显著的峰值

    % 根据峰值提取直线
    lines = houghlines(BW, theta, rho, peaks, 'FillGap', 5, 'MinLength', 7);

    % 显示原始图像
    subplot(1,2,1),imshow(I), hold on;

    % 在图像上绘制检测到的车道线
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'green');
       
       % 绘制直线的起点和终点
       plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'yellow');
       plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');
    end

    % 显示图像
    title('检测到的车道线');
    hold off;
e
