classdef MatlmageMaster_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure        matlab.ui.Figure
        HOGButton       matlab.ui.control.Button
        LBPButton       matlab.ui.control.Button
        Button_7        matlab.ui.control.Button
        Button_6        matlab.ui.control.Button
        EditField       matlab.ui.control.EditField
        EditFieldLabel  matlab.ui.control.Label
        Button_5        matlab.ui.control.Button
        DropDown        matlab.ui.control.DropDown
        DropDownLabel   matlab.ui.control.Label
        Button_2        matlab.ui.control.Button
        Button_4        matlab.ui.control.Button
        Button_3        matlab.ui.control.Button
        Button          matlab.ui.control.StateButton
        imageAxes       matlab.ui.control.UIAxes
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: Button
        function ButtonValueChanged(app, event)
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

        % Button pushed function: Button_3
        function Button_3Pushed(app, event)
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

        % Button pushed function: Button_4
        function Button_4Pushed(app, event)
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

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
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

        % Value changed function: DropDown
        function DropDownValueChanged(app, event)
            % 获取存储的图像路径
            imagePath = getappdata(app.UIFigure, 'ImagePath');
            if isempty(imagePath)
                warning('没有选择图片');
                return;
            end

            % 获取用户选择的噪声类型
            noiseType = app.DropDown.Value;

            % 获取用户输入的噪声参数
            noiseParam = str2double(app.EditField.Value);
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

        % Button pushed function: Button_5
        function Button_5Pushed(app, event)
            % 获取存储的图像路径
            imagePath = getappdata(app.UIFigure, 'ImagePath');
            if isempty(imagePath)
                warning('没有选择图片');
                return;
            end

            % 获取用户选择的噪声类型
            noiseType = app.DropDown.Value;

            % 获取用户输入的噪声参数
            noiseParam = str2double(app.EditField.Value);
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

        % Button pushed function: Button_6
        function Button_6Pushed(app, event)
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

        % Button pushed function: Button_7
        function Button_7Pushed(app, event)
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

        % Button pushed function: LBPButton
        function LBPButtonPushed(app, event)
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

        % Button pushed function: HOGButton
        function HOGButtonPushed(app, event)
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
            app.UIFigure.Position = [100 100 804 610];
            app.UIFigure.Name = 'MATLAB App';

            % Create imageAxes
            app.imageAxes = uiaxes(app.UIFigure);
            title(app.imageAxes, '图片显示')
            app.imageAxes.Position = [1 43 485 562];

            % Create Button
            app.Button = uibutton(app.UIFigure, 'state');
            app.Button.ValueChangedFcn = createCallbackFcn(app, @ButtonValueChanged, true);
            app.Button.Text = '打开图像';
            app.Button.FontSize = 18;
            app.Button.FontWeight = 'bold';
            app.Button.Position = [516 549 100 30];

            % Create Button_3
            app.Button_3 = uibutton(app.UIFigure, 'push');
            app.Button_3.ButtonPushedFcn = createCallbackFcn(app, @Button_3Pushed, true);
            app.Button_3.FontSize = 18;
            app.Button_3.FontWeight = 'bold';
            app.Button_3.Position = [516 507 105 30];
            app.Button_3.Text = '直方图操作';

            % Create Button_4
            app.Button_4 = uibutton(app.UIFigure, 'push');
            app.Button_4.ButtonPushedFcn = createCallbackFcn(app, @Button_4Pushed, true);
            app.Button_4.FontSize = 18;
            app.Button_4.FontWeight = 'bold';
            app.Button_4.Position = [516 465 105 30];
            app.Button_4.Text = '对比度增强';

            % Create Button_2
            app.Button_2 = uibutton(app.UIFigure, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.FontSize = 18;
            app.Button_2.FontWeight = 'bold';
            app.Button_2.Position = [516 424 207 30];
            app.Button_2.Text = '变换图像(旋转，缩小等)';

            % Create DropDownLabel
            app.DropDownLabel = uilabel(app.UIFigure);
            app.DropDownLabel.HorizontalAlignment = 'right';
            app.DropDownLabel.FontSize = 18;
            app.DropDownLabel.FontWeight = 'bold';
            app.DropDownLabel.FontColor = [0 0.4471 0.7412];
            app.DropDownLabel.Position = [516 360 77 23];
            app.DropDownLabel.Text = '噪声类型';

            % Create DropDown
            app.DropDown = uidropdown(app.UIFigure);
            app.DropDown.Items = {'gaussian', 'salt & pepper', 'speckle'};
            app.DropDown.ValueChangedFcn = createCallbackFcn(app, @DropDownValueChanged, true);
            app.DropDown.FontSize = 18;
            app.DropDown.FontWeight = 'bold';
            app.DropDown.FontColor = [0 0.4471 0.7412];
            app.DropDown.Position = [608 359 100 24];
            app.DropDown.Value = 'gaussian';

            % Create Button_5
            app.Button_5 = uibutton(app.UIFigure, 'push');
            app.Button_5.ButtonPushedFcn = createCallbackFcn(app, @Button_5Pushed, true);
            app.Button_5.FontSize = 18;
            app.Button_5.FontWeight = 'bold';
            app.Button_5.FontColor = [0 0.4471 0.7412];
            app.Button_5.Position = [516 291 141 30];
            app.Button_5.Text = '添加噪声和过滤';

            % Create EditFieldLabel
            app.EditFieldLabel = uilabel(app.UIFigure);
            app.EditFieldLabel.HorizontalAlignment = 'right';
            app.EditFieldLabel.FontSize = 18;
            app.EditFieldLabel.FontWeight = 'bold';
            app.EditFieldLabel.FontColor = [0 0.4471 0.7412];
            app.EditFieldLabel.Position = [516 330 77 23];
            app.EditFieldLabel.Text = '噪声参数';

            % Create EditField
            app.EditField = uieditfield(app.UIFigure, 'text');
            app.EditField.FontSize = 18;
            app.EditField.FontWeight = 'bold';
            app.EditField.FontColor = [0 0.4471 0.7412];
            app.EditField.Position = [608 326 100 27];

            % Create Button_6
            app.Button_6 = uibutton(app.UIFigure, 'push');
            app.Button_6.ButtonPushedFcn = createCallbackFcn(app, @Button_6Pushed, true);
            app.Button_6.FontSize = 18;
            app.Button_6.FontWeight = 'bold';
            app.Button_6.Position = [516 232 100 30];
            app.Button_6.Text = '边缘检测';

            % Create Button_7
            app.Button_7 = uibutton(app.UIFigure, 'push');
            app.Button_7.ButtonPushedFcn = createCallbackFcn(app, @Button_7Pushed, true);
            app.Button_7.FontSize = 18;
            app.Button_7.FontWeight = 'bold';
            app.Button_7.Position = [516 188 100 30];
            app.Button_7.Text = '提取目标';

            % Create LBPButton
            app.LBPButton = uibutton(app.UIFigure, 'push');
            app.LBPButton.ButtonPushedFcn = createCallbackFcn(app, @LBPButtonPushed, true);
            app.LBPButton.FontSize = 18;
            app.LBPButton.FontWeight = 'bold';
            app.LBPButton.FontColor = [0.4941 0.1843 0.5569];
            app.LBPButton.Position = [516 144 123 30];
            app.LBPButton.Text = '提取LBP特征';

            % Create HOGButton
            app.HOGButton = uibutton(app.UIFigure, 'push');
            app.HOGButton.ButtonPushedFcn = createCallbackFcn(app, @HOGButtonPushed, true);
            app.HOGButton.FontSize = 18;
            app.HOGButton.FontWeight = 'bold';
            app.HOGButton.FontColor = [0.4941 0.1843 0.5569];
            app.HOGButton.Position = [516 101 128 30];
            app.HOGButton.Text = '提取HOG特征';

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