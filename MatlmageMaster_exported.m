classdef MatlmageMaster_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure            matlab.ui.Figure
        Button              matlab.ui.control.Button
        contrastEnhancement_CallbackButton  matlab.ui.control.Button
        histogramOperations_CallbackButton  matlab.ui.control.Button
        open_pictureButton  matlab.ui.control.StateButton
        imageAxes           matlab.ui.control.UIAxes
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
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 684 506];
            app.UIFigure.Name = 'MATLAB App';

            % Create imageAxes
            app.imageAxes = uiaxes(app.UIFigure);
            title(app.imageAxes, '图片显示')
            app.imageAxes.Position = [10 14 382 480];

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

            % Create Button
            app.Button = uibutton(app.UIFigure, 'push');
            app.Button.Position = [414 323 100 23];

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