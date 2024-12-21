function noise_and_filter(image_path)
    % 读取图像
    img = imread(image_path);

    % 添加噪声
    noisy_img = imnoise(img, 'gaussian', 0, 0.01);
    subplot(2, 2, 1);
    imshow(noisy_img);
    title('加噪后的图像');

    % 空域滤波
    filtered_img = medfilt2(noisy_img);
    subplot(2, 2, 2);
    imshow(filtered_img);
    title('空域滤波后的图像');

    % 频域滤波
    fft_img = fft2(noisy_img);
    fft_shifted = fftshift(fft_img);
    lowpass_mask = fspecial('average', 15);
    filtered_fft = ifft2(ifftshift(fft_shifted .* lowpass_mask));
    filtered_img_freq = real(filtered_fft);
    subplot(2, 2, 3);
    imshow(filtered_img_freq);
    title('频域滤波后的图像');
end