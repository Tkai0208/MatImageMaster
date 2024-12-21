function noise_and_filter(image_path, noise_type, noise_param)
    % 读取图像
    img = imread(image_path);

    % 添加噪声
    if strcmp(noise_type, 'gaussian')
        noisy_img = imnoise(img, 'gaussian', 0, noise_param);
    elseif strcmp(noise_type, 'salt & pepper')
        noisy_img = imnoise(img, 'salt & pepper', noise_param);
    elseif strcmp(noise_type, 'speckle')
        noisy_img = imnoise(img, 'speckle', noise_param);
    else
        error('Unsupported noise type. Supported types are: gaussian, salt & pepper, speckle.');
    end

    % 创建一个新的图形窗口，并设置为2x2布局
    figure;

    % 显示加噪后的图像
    subplot(2, 2, 1);
    imshow(noisy_img);
    title(['加噪后的图像 (', noise_type, ')']);

    % 空域滤波
    filtered_img_spatial = medfilt2(noisy_img);
    subplot(2, 2, 2);
    imshow(filtered_img_spatial);
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

    % 显示原始图像
    subplot(2, 2, 4);
    imshow(img);
    title('原始图像');
end