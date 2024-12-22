function feature_extraction(image_path)
    % 读取图像
    img = imread(image_path);

    % LBP特征提取
    lbp_img = localBinaryPattern(gray_img, 8, 1);
    subplot(2, 1, 1);
    imshow(lbp_img);
    title('LBP特征');

    % HOG特征提取
    hog_features = extractHOGFeatures(gray_img);
    subplot(2, 1, 2);
    plot(hog_features);
    title('HOG特征');
end