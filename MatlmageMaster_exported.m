classdef MatlmageMaster_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        BrightnessEditField            matlab.ui.control.EditField
        BrightnessEditFieldLabel       matlab.ui.control.Label
        Label_11                       matlab.ui.control.Label
        Label_10                       matlab.ui.control.Label
        HOGLabel                       matlab.ui.control.Label
        LBPLabel                       matlab.ui.control.Label
        Label_9                        matlab.ui.control.Label
        Label_8                        matlab.ui.control.Label
        Label_7                        matlab.ui.control.Label
        Label_6                        matlab.ui.control.Label
        Label_5                        matlab.ui.control.Label
        Label_4                        matlab.ui.control.Label
        Label_3                        matlab.ui.control.Label
        Label_2                        matlab.ui.control.Label
        extractHOGFeatures_CallbackButton  matlab.ui.control.Button
        extractLBPFeatures_CallbackButton  matlab.ui.control.Button
        extractTarget_CallbackButton   matlab.ui.control.Button
        edgeDetection_CallbackButton   matlab.ui.control.Button
        noiseParamEditField            matlab.ui.control.EditField
        noiseParamEditFieldLabel       matlab.ui.control.Label
        noiseAndFilter_CallbackButton  matlab.ui.control.Button
        noiseTypeDropDown              matlab.ui.control.DropDown
        noiseTypeDropDownLabel         matlab.ui.control.Label
        transformImage_CallbackButton  matlab.ui.control.Button
        contrastEnhancement_CallbackButton  matlab.ui.control.Button
        histogramOperations_CallbackButton  matlab.ui.control.Button
        openImage_CallbackButton       matlab.ui.control.StateButton
        imageAxes                      matlab.ui.control.UIAxes
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: openImage_CallbackButton
        function openImage_CallbackButtonValueChanged(app, event)
            [file, path] = uigetfile({'*.png;*.jpg;*.jpeg', 'Images'});
            if isequal(file, 0)
                return;
            end
            imagePath = fullfile(path, file);

            % 显示原始图像
            imshow(imread(imagePath), 'Parent', app.imageAxes);
            drawnow;

            % 更新全局变量
            setappdata(app.UIFigure, 'ImagePath', imagePath);
        end

        % Button pushed function: histogramOperations_CallbackButton
        function histogramOperations_CallbackButtonPushed(app, event)
            % 获取存储的图像路径
            imagePath = getappdata(app.UIFigure, 'ImagePath');
            if isempty(imagePath)
                warning('没有选择图片');
                return;
            end

            try
                % 调用你的现有函数，并传递必要的参数
                histogram_operations(imagePath);

            catch ME
                % 错误处理
                warndlg(['发生错误: ', ME.message], '错误');
            end
        end

        % Button pushed function: contrastEnhancement_CallbackButton
        function contrastEnhancement_CallbackButtonPushed(app, event)
            % 获取存储的图像路径
            imagePath = getappdata(app.UIFigure, 'ImagePath');
            if isempty(imagePath)
                warning('没有选择图片');
                return;
            end

            try
                % 调用你的现有函数，并传递必要的参数
                contrast_enhancement(imagePath);

            catch ME
                % 错误处理
                warndlg(['发生错误: ', ME.message], '错误');
            end
        end

        % Button pushed function: transformImage_CallbackButton
        function transformImage_CallbackButtonPushed(app, event)
            % 获取存储的图像路径
            imagePath = getappdata(app.UIFigure, 'ImagePath');
            if isempty(imagePath)
                warning('没有选择图片');
                return;
            end

            try
                % 从 BrightnessEditField 获取亮度调整因子
                brightness_factor = str2double(app.BrightnessEditField.Value);

                % 直接调用图像变换函数，并传递必要的参数
                transform_image(imagePath, brightness_factor);

            catch ME
                % 错误处理
                warndlg(['发生错误: ', ME.message], '错误');
            end
        end

        % Value changed function: noiseTypeDropDown
        function noiseTypeDropDownValueChanged(app, event)
            % 获取存储的图像路径
            imagePath = getappdata(app.UIFigure, 'ImagePath');
            if isempty(imagePath)
                warning('没有选择图片');
                return;
            end

            % 获取用户选择的噪声类型
            noiseType = app.noiseTypeDropDown.Value;

            % 获取用户输入的噪声参数
            noiseParam = str2double(app.noiseParamEditField.Value);
            if isnan(noiseParam)
                warndlg('请输入有效的噪声参数', '无效参数');
                return;
            end

            try
                % 调用噪声处理函数
                noise_and_filter(imagePath, noiseType, noiseParam);
            catch ME
                % 错误处理
                warndlg(['发生错误: ', ME.message], '错误');
            end
        end

        % Button pushed function: noiseAndFilter_CallbackButton
        function noiseAndFilter_CallbackButtonPushed(app, event)
            % 获取存储的图像路径
            imagePath = getappdata(app.UIFigure, 'ImagePath');
            if isempty(imagePath)
                warning('没有选择图片');
                return;
            end

            % 获取用户选择的噪声类型
            noiseType = app.noiseTypeDropDown.Value;

            % 获取用户输入的噪声参数
            noiseParam = str2double(app.noiseParamEditField.Value);
            if isnan(noiseParam)
                warndlg('请输入有效的噪声参数', '无效参数');
                return;
            end

            try
                % 调用噪声处理函数
                noise_and_filter(imagePath, noiseType, noiseParam);
            catch ME
                % 错误处理
                warndlg(['发生错误: ', ME.message], '错误');
            end
        end

        % Button pushed function: edgeDetection_CallbackButton
        function edgeDetection_CallbackButtonPushed(app, event)
            % 获取存储的图像路径
            imagePath = getappdata(app.UIFigure, 'ImagePath');
            if isempty(imagePath)
                warning('没有选择图片');
                return;
            end

            try
                % 调用边缘检测函数，这将打开新的图形窗口并显示结果
                edge_detection(imagePath);

            catch ME
                % 错误处理
                warndlg(['发生错误: ', ME.message], '错误');
            end
        end

        % Button pushed function: extractTarget_CallbackButton
        function extractTarget_CallbackButtonPushed(app, event)
            % 获取存储的图像路径
            imagePath = getappdata(app.UIFigure, 'ImagePath');
            if isempty(imagePath)
                warning('没有选择图片');
                return;
            end

            try
                % 调用目标提取函数
                extract_target(imagePath);

            catch ME
                % 错误处理
                warndlg(['发生错误: ', ME.message], '错误');
            end
        end

        % Button pushed function: extractLBPFeatures_CallbackButton
        function extractLBPFeatures_CallbackButtonPushed(app, event)
            % 获取存储的图像路径和提取的目标图像路径
            originalImagePath = getappdata(app.UIFigure, 'ImagePath');
            targetImagePath = fullfile(fileparts(originalImagePath), 'extracted_target.png');

            if isempty(originalImagePath) || ~isfile(targetImagePath)
                warning('缺少原始图片或提取的目标图片');
                return;
            end

            try
                % 调用LBP特征提取函数
                extractLBPFeatures(originalImagePath, targetImagePath);

            catch ME
                % 错误处理
                warndlg(['发生错误: ', ME.message], '错误');
            end
        end

        % Button pushed function: extractHOGFeatures_CallbackButton
        function extractHOGFeatures_CallbackButtonPushed(app, event)
            % 获取存储的图像路径和提取的目标图像路径
            originalImagePath = getappdata(app.UIFigure, 'ImagePath');
            targetImagePath = fullfile(fileparts(originalImagePath), 'extracted_target.png');

            if isempty(originalImagePath) || ~isfile(targetImagePath)
                warning('缺少原始图片或提取的目标图片');
                return;
            end

            try
                % 调用HOG特征提取函数
                extractHOGFeatures(originalImagePath, targetImagePath);

            catch ME
                % 错误处理
                warndlg(['发生错误: ', ME.message], '错误');
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.9216 0.8471 0.8471];
            app.UIFigure.Position = [100 100 869 599];
            app.UIFigure.Name = 'MATLAB App';

            % Create imageAxes
            app.imageAxes = uiaxes(app.UIFigure);
            title(app.imageAxes, '原图显示')
            app.imageAxes.FontName = '黑体';
            app.imageAxes.FontWeight = 'bold';
            app.imageAxes.FontSize = 14;
            app.imageAxes.Position = [11 79 419 499];

            % Create openImage_CallbackButton
            app.openImage_CallbackButton = uibutton(app.UIFigure, 'state');
            app.openImage_CallbackButton.ValueChangedFcn = createCallbackFcn(app, @openImage_CallbackButtonValueChanged, true);
            app.openImage_CallbackButton.Text = 'openImage_Callback';
            app.openImage_CallbackButton.FontSize = 18;
            app.openImage_CallbackButton.FontWeight = 'bold';
            app.openImage_CallbackButton.Position = [448 548 195 30];

            % Create histogramOperations_CallbackButton
            app.histogramOperations_CallbackButton = uibutton(app.UIFigure, 'push');
            app.histogramOperations_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @histogramOperations_CallbackButtonPushed, true);
            app.histogramOperations_CallbackButton.FontSize = 18;
            app.histogramOperations_CallbackButton.FontWeight = 'bold';
            app.histogramOperations_CallbackButton.Position = [448 510 284 30];
            app.histogramOperations_CallbackButton.Text = 'histogramOperations_Callback';

            % Create contrastEnhancement_CallbackButton
            app.contrastEnhancement_CallbackButton = uibutton(app.UIFigure, 'push');
            app.contrastEnhancement_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @contrastEnhancement_CallbackButtonPushed, true);
            app.contrastEnhancement_CallbackButton.FontSize = 18;
            app.contrastEnhancement_CallbackButton.FontWeight = 'bold';
            app.contrastEnhancement_CallbackButton.Position = [448 468 291 30];
            app.contrastEnhancement_CallbackButton.Text = 'contrastEnhancement_Callback';

            % Create transformImage_CallbackButton
            app.transformImage_CallbackButton = uibutton(app.UIFigure, 'push');
            app.transformImage_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @transformImage_CallbackButtonPushed, true);
            app.transformImage_CallbackButton.FontSize = 18;
            app.transformImage_CallbackButton.FontWeight = 'bold';
            app.transformImage_CallbackButton.Position = [448 387 237 30];
            app.transformImage_CallbackButton.Text = 'transformImage_Callback';

            % Create noiseTypeDropDownLabel
            app.noiseTypeDropDownLabel = uilabel(app.UIFigure);
            app.noiseTypeDropDownLabel.HorizontalAlignment = 'right';
            app.noiseTypeDropDownLabel.FontSize = 18;
            app.noiseTypeDropDownLabel.FontWeight = 'bold';
            app.noiseTypeDropDownLabel.FontColor = [0 0.4471 0.7412];
            app.noiseTypeDropDownLabel.Position = [448 338 184 23];
            app.noiseTypeDropDownLabel.Text = 'noiseTypeDropDown';

            % Create noiseTypeDropDown
            app.noiseTypeDropDown = uidropdown(app.UIFigure);
            app.noiseTypeDropDown.Items = {'gaussian', 'salt & pepper', 'speckle'};
            app.noiseTypeDropDown.ValueChangedFcn = createCallbackFcn(app, @noiseTypeDropDownValueChanged, true);
            app.noiseTypeDropDown.FontSize = 18;
            app.noiseTypeDropDown.FontWeight = 'bold';
            app.noiseTypeDropDown.FontColor = [0 0.4471 0.7412];
            app.noiseTypeDropDown.Position = [647 337 100 24];
            app.noiseTypeDropDown.Value = 'gaussian';

            % Create noiseAndFilter_CallbackButton
            app.noiseAndFilter_CallbackButton = uibutton(app.UIFigure, 'push');
            app.noiseAndFilter_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @noiseAndFilter_CallbackButtonPushed, true);
            app.noiseAndFilter_CallbackButton.FontSize = 18;
            app.noiseAndFilter_CallbackButton.FontWeight = 'bold';
            app.noiseAndFilter_CallbackButton.FontColor = [0 0.4471 0.7412];
            app.noiseAndFilter_CallbackButton.Position = [448 244 227 30];
            app.noiseAndFilter_CallbackButton.Text = 'noiseAndFilter_Callback';

            % Create noiseParamEditFieldLabel
            app.noiseParamEditFieldLabel = uilabel(app.UIFigure);
            app.noiseParamEditFieldLabel.HorizontalAlignment = 'right';
            app.noiseParamEditFieldLabel.FontSize = 18;
            app.noiseParamEditFieldLabel.FontWeight = 'bold';
            app.noiseParamEditFieldLabel.FontColor = [0 0.4471 0.7412];
            app.noiseParamEditFieldLabel.Position = [448 291 188 23];
            app.noiseParamEditFieldLabel.Text = 'noiseParamEditField ';

            % Create noiseParamEditField
            app.noiseParamEditField = uieditfield(app.UIFigure, 'text');
            app.noiseParamEditField.FontSize = 18;
            app.noiseParamEditField.FontWeight = 'bold';
            app.noiseParamEditField.FontColor = [0 0.4471 0.7412];
            app.noiseParamEditField.Position = [651 287 100 27];

            % Create edgeDetection_CallbackButton
            app.edgeDetection_CallbackButton = uibutton(app.UIFigure, 'push');
            app.edgeDetection_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @edgeDetection_CallbackButtonPushed, true);
            app.edgeDetection_CallbackButton.FontSize = 18;
            app.edgeDetection_CallbackButton.FontWeight = 'bold';
            app.edgeDetection_CallbackButton.Position = [448 189 225 30];
            app.edgeDetection_CallbackButton.Text = 'edgeDetection_Callback';

            % Create extractTarget_CallbackButton
            app.extractTarget_CallbackButton = uibutton(app.UIFigure, 'push');
            app.extractTarget_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @extractTarget_CallbackButtonPushed, true);
            app.extractTarget_CallbackButton.FontSize = 18;
            app.extractTarget_CallbackButton.FontWeight = 'bold';
            app.extractTarget_CallbackButton.Position = [448 149 213 30];
            app.extractTarget_CallbackButton.Text = 'extractTarget_Callback';

            % Create extractLBPFeatures_CallbackButton
            app.extractLBPFeatures_CallbackButton = uibutton(app.UIFigure, 'push');
            app.extractLBPFeatures_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @extractLBPFeatures_CallbackButtonPushed, true);
            app.extractLBPFeatures_CallbackButton.FontSize = 18;
            app.extractLBPFeatures_CallbackButton.FontWeight = 'bold';
            app.extractLBPFeatures_CallbackButton.FontColor = [0.4941 0.1843 0.5569];
            app.extractLBPFeatures_CallbackButton.Position = [448 101 272 30];
            app.extractLBPFeatures_CallbackButton.Text = 'extractLBPFeatures_Callback';

            % Create extractHOGFeatures_CallbackButton
            app.extractHOGFeatures_CallbackButton = uibutton(app.UIFigure, 'push');
            app.extractHOGFeatures_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @extractHOGFeatures_CallbackButtonPushed, true);
            app.extractHOGFeatures_CallbackButton.FontSize = 18;
            app.extractHOGFeatures_CallbackButton.FontWeight = 'bold';
            app.extractHOGFeatures_CallbackButton.FontColor = [0.4941 0.1843 0.5569];
            app.extractHOGFeatures_CallbackButton.Position = [448 58 277 30];
            app.extractHOGFeatures_CallbackButton.Text = 'extractHOGFeatures_Callback';

            % Create Label_2
            app.Label_2 = uilabel(app.UIFigure);
            app.Label_2.FontSize = 14;
            app.Label_2.FontWeight = 'bold';
            app.Label_2.Position = [660 556 61 22];
            app.Label_2.Text = '打开图像';

            % Create Label_3
            app.Label_3 = uilabel(app.UIFigure);
            app.Label_3.FontSize = 14;
            app.Label_3.FontWeight = 'bold';
            app.Label_3.Position = [746 518 75 22];
            app.Label_3.Text = '直方图操作';

            % Create Label_4
            app.Label_4 = uilabel(app.UIFigure);
            app.Label_4.FontSize = 14;
            app.Label_4.FontWeight = 'bold';
            app.Label_4.Position = [750 476 75 22];
            app.Label_4.Text = '对比度增强';

            % Create Label_5
            app.Label_5 = uilabel(app.UIFigure);
            app.Label_5.FontSize = 14;
            app.Label_5.FontWeight = 'bold';
            app.Label_5.Position = [750 428 97 22];
            app.Label_5.Text = '亮度参数大于0';

            % Create Label_6
            app.Label_6 = uilabel(app.UIFigure);
            app.Label_6.FontSize = 14;
            app.Label_6.FontWeight = 'bold';
            app.Label_6.Position = [701 395 61 22];
            app.Label_6.Text = '变换图像';

            % Create Label_7
            app.Label_7 = uilabel(app.UIFigure);
            app.Label_7.FontSize = 14;
            app.Label_7.FontWeight = 'bold';
            app.Label_7.Position = [684 252 103 22];
            app.Label_7.Text = '添加噪声和过滤';

            % Create Label_8
            app.Label_8 = uilabel(app.UIFigure);
            app.Label_8.FontSize = 14;
            app.Label_8.FontWeight = 'bold';
            app.Label_8.Position = [684 197 61 22];
            app.Label_8.Text = '边缘检测';

            % Create Label_9
            app.Label_9 = uilabel(app.UIFigure);
            app.Label_9.FontSize = 14;
            app.Label_9.FontWeight = 'bold';
            app.Label_9.Position = [674 157 61 22];
            app.Label_9.Text = '提取目标';

            % Create LBPLabel
            app.LBPLabel = uilabel(app.UIFigure);
            app.LBPLabel.FontSize = 14;
            app.LBPLabel.FontWeight = 'bold';
            app.LBPLabel.Position = [736 109 89 22];
            app.LBPLabel.Text = '提取LBP特征';

            % Create HOGLabel
            app.HOGLabel = uilabel(app.UIFigure);
            app.HOGLabel.FontSize = 14;
            app.HOGLabel.FontWeight = 'bold';
            app.HOGLabel.Position = [736 66 93 22];
            app.HOGLabel.Text = '提取HOG特征';

            % Create Label_10
            app.Label_10 = uilabel(app.UIFigure);
            app.Label_10.FontSize = 14;
            app.Label_10.FontWeight = 'bold';
            app.Label_10.Position = [762 338 61 22];
            app.Label_10.Text = '噪声类型';

            % Create Label_11
            app.Label_11 = uilabel(app.UIFigure);
            app.Label_11.FontSize = 14;
            app.Label_11.FontWeight = 'bold';
            app.Label_11.Position = [762 291 61 22];
            app.Label_11.Text = '噪声参数';

            % Create BrightnessEditFieldLabel
            app.BrightnessEditFieldLabel = uilabel(app.UIFigure);
            app.BrightnessEditFieldLabel.HorizontalAlignment = 'right';
            app.BrightnessEditFieldLabel.FontSize = 18;
            app.BrightnessEditFieldLabel.FontWeight = 'bold';
            app.BrightnessEditFieldLabel.Position = [448 428 175 23];
            app.BrightnessEditFieldLabel.Text = 'BrightnessEditField';

            % Create BrightnessEditField
            app.BrightnessEditField = uieditfield(app.UIFigure, 'text');
            app.BrightnessEditField.FontSize = 18;
            app.BrightnessEditField.FontWeight = 'bold';
            app.BrightnessEditField.Position = [638 424 100 27];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = MatlmageMaster_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end