classdef MatlmageMaster_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
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
        open_pictureButton             matlab.ui.control.StateButton
        imageAxes                      matlab.ui.control.UIAxes
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: open_pictureButton
        function open_pictureButtonValueChanged(app, event)
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
                % 调用你的现有函数，并传递必要的参数
                transform_image(imagePath);

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
            app.UIFigure.Position = [100 100 752 506];
            app.UIFigure.Name = 'MATLAB App';

            % Create imageAxes
            app.imageAxes = uiaxes(app.UIFigure);
            title(app.imageAxes, '图片显示')
            app.imageAxes.Position = [11 1 382 493];

            % Create open_pictureButton
            app.open_pictureButton = uibutton(app.UIFigure, 'state');
            app.open_pictureButton.ValueChangedFcn = createCallbackFcn(app, @open_pictureButtonValueChanged, true);
            app.open_pictureButton.Text = 'open_picture';
            app.open_pictureButton.Position = [414 428 100 23];

            % Create histogramOperations_CallbackButton
            app.histogramOperations_CallbackButton = uibutton(app.UIFigure, 'push');
            app.histogramOperations_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @histogramOperations_CallbackButtonPushed, true);
            app.histogramOperations_CallbackButton.Position = [414 391 179 23];
            app.histogramOperations_CallbackButton.Text = 'histogramOperations_Callback';

            % Create contrastEnhancement_CallbackButton
            app.contrastEnhancement_CallbackButton = uibutton(app.UIFigure, 'push');
            app.contrastEnhancement_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @contrastEnhancement_CallbackButtonPushed, true);
            app.contrastEnhancement_CallbackButton.Position = [414 357 184 23];
            app.contrastEnhancement_CallbackButton.Text = 'contrastEnhancement_Callback';

            % Create transformImage_CallbackButton
            app.transformImage_CallbackButton = uibutton(app.UIFigure, 'push');
            app.transformImage_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @transformImage_CallbackButtonPushed, true);
            app.transformImage_CallbackButton.Position = [414 320 152 23];
            app.transformImage_CallbackButton.Text = 'transformImage_Callback';

            % Create noiseTypeDropDownLabel
            app.noiseTypeDropDownLabel = uilabel(app.UIFigure);
            app.noiseTypeDropDownLabel.HorizontalAlignment = 'right';
            app.noiseTypeDropDownLabel.Position = [414 273 116 22];
            app.noiseTypeDropDownLabel.Text = 'noiseTypeDropDown';

            % Create noiseTypeDropDown
            app.noiseTypeDropDown = uidropdown(app.UIFigure);
            app.noiseTypeDropDown.Items = {'gaussian', 'salt & pepper', 'speckle'};
            app.noiseTypeDropDown.ValueChangedFcn = createCallbackFcn(app, @noiseTypeDropDownValueChanged, true);
            app.noiseTypeDropDown.Position = [545 273 100 22];
            app.noiseTypeDropDown.Value = 'gaussian';

            % Create noiseAndFilter_CallbackButton
            app.noiseAndFilter_CallbackButton = uibutton(app.UIFigure, 'push');
            app.noiseAndFilter_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @noiseAndFilter_CallbackButtonPushed, true);
            app.noiseAndFilter_CallbackButton.Position = [414 210 144 23];
            app.noiseAndFilter_CallbackButton.Text = 'noiseAndFilter_Callback';

            % Create noiseParamEditFieldLabel
            app.noiseParamEditFieldLabel = uilabel(app.UIFigure);
            app.noiseParamEditFieldLabel.HorizontalAlignment = 'right';
            app.noiseParamEditFieldLabel.Position = [414 243 116 22];
            app.noiseParamEditFieldLabel.Text = 'noiseParamEditField';

            % Create noiseParamEditField
            app.noiseParamEditField = uieditfield(app.UIFigure, 'text');
            app.noiseParamEditField.Position = [545 243 100 22];

            % Create edgeDetection_CallbackButton
            app.edgeDetection_CallbackButton = uibutton(app.UIFigure, 'push');
            app.edgeDetection_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @edgeDetection_CallbackButtonPushed, true);
            app.edgeDetection_CallbackButton.Position = [414 159 145 23];
            app.edgeDetection_CallbackButton.Text = 'edgeDetection_Callback';

            % Create extractTarget_CallbackButton
            app.extractTarget_CallbackButton = uibutton(app.UIFigure, 'push');
            app.extractTarget_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @extractTarget_CallbackButtonPushed, true);
            app.extractTarget_CallbackButton.Position = [414 121 140 23];
            app.extractTarget_CallbackButton.Text = ' extractTarget_Callback';

            % Create extractLBPFeatures_CallbackButton
            app.extractLBPFeatures_CallbackButton = uibutton(app.UIFigure, 'push');
            app.extractLBPFeatures_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @extractLBPFeatures_CallbackButtonPushed, true);
            app.extractLBPFeatures_CallbackButton.Position = [414 85 174 23];
            app.extractLBPFeatures_CallbackButton.Text = 'extractLBPFeatures_Callback';

            % Create extractHOGFeatures_CallbackButton
            app.extractHOGFeatures_CallbackButton = uibutton(app.UIFigure, 'push');
            app.extractHOGFeatures_CallbackButton.ButtonPushedFcn = createCallbackFcn(app, @extractHOGFeatures_CallbackButtonPushed, true);
            app.extractHOGFeatures_CallbackButton.Position = [414 46 178 23];
            app.extractHOGFeatures_CallbackButton.Text = 'extractHOGFeatures_Callback';

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