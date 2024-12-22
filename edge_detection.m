function edge_detection(image_path)
    % 读取图像并转换为灰度图像
    img = imread(image_path);
    gray_img = rgb2gray(img);

    % 使用不同算子进行边缘检测
    roberts_edges = edge(gray_img, 'roberts');
    prewitt_edges = edge(gray_img, 'prewitt');
    sobel_edges = edge(gray_img, 'sobel');
    laplacian_edges = edge(gray_img, 'log');

    % 显示结果
    figure;
    subplot(2, 2, 1);
    imshow(roberts_edges);
    title('Roberts算子');

    subplot(2, 2, 2);
    imshow(prewitt_edges);
    title('Prewitt算子');

    subplot(2, 2, 3);
    imshow(sobel_edges);
    title('Sobel算子');

    subplot(2, 2, 4);
    imshow(laplacian_edges);
    title('Laplacian算子');
end