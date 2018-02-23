function HandTraining
% Get the Screen Size Display%
screen_size=get(0,'ScreenSize');
screen_size_height = screen_size(4);
screen_size_width =screen_size(3);
%Set the Figure Size%
set_height = screen_size_height*.8;
set_width = screen_size_width*.8;
offset_x=screen_size_height*.1;
offset_y=screen_size_width*.1;
trainhand_fig= figure('Visible','on','Name','Train Hand','MenuBar','none',...
    'Position',[offset_y,offset_x,set_width*.75,set_height ],'NumberTitle','off','Alphamap',.1,'WindowStyle','modal');
%%%%%%%%%%%Hand Information Panel%%%%%%%%%%%5
HandData_panel= uipanel('Parent',trainhand_fig,'Title','',...
    'Position',[0.0082 0.0195 0.225*1.5 0.9723],'FontSize',8,'BorderType','none');
%%%%%%%%%%%%%%Camera Panel%%%%%%%%%5
cam_prev= uipanel('Parent',trainhand_fig,'Title','',...
    'Position',[0.3539 0.0195 .6379  0.9723],'FontSize',8,'BorderType','none');%[0.47 0.0195 0.5219 0.9723]
video_prev= uipanel('Parent',cam_prev,'Title','',...
    'Position',[0.0371 0.26 0.9293 0.6793],'FontSize',8,'BorderType','none','BackgroundColor',[.3 .3 .3]);
ah2 = axes('Parent',video_prev,'Position',[0.01 0.01 0.98 0.98],'XTick',[],'YTick',[],'Color',[.3 .3 .3],'Visible','off');
axis ij
camprev_txt_control = uicontrol('Parent',cam_prev,'Style','text','String','Camera Preview','Units','Normalize',...
    'Position',[0.0371 0.955 0.2296 0.0310],'HorizontalAlignment','left','FontSize',11,'FontAngle','Italic');
Preview_buttongroup= uipanel('Parent',cam_prev,'Title','Camera Preview',...
    'Position',[0.0371 0.0227 0.4275 0.2058],'FontSize',8);
pre_start_button = uicontrol('Parent',Preview_buttongroup,'Style','pushbutton','String','Start Preview','Units','Normalize',...
    'Position',[0.0546 0.1491 0.4243 0.7894],'HorizontalAlignment','center','FontSize',8,'Enable','on','Callback',@prestart_button);
pre_stop_button = uicontrol('Parent',Preview_buttongroup,'Style','pushbutton','String','Stop Preview','Units','Normalize',...
    'Position',[0.5294 0.1491 0.4243 0.7894],'HorizontalAlignment','center','FontSize',8,'Enable','off','Callback',@prestop_button);

StartAcq_buttongroup= uipanel('Parent',cam_prev,'Title','Start Acquisation',...
    'Position',[0.54 0.0227 0.4275 0.2058],'FontSize',8);
acq_start_button = uicontrol('Parent',StartAcq_buttongroup,'Style','pushbutton','String','Start Preview','Units','Normalize',...
    'Position',[0.0546 0.1491 0.4243 0.7894],'HorizontalAlignment','center','FontSize',8,'Enable','of','Callback',@acqstart_button);
acq_stop_button = uicontrol('Parent',StartAcq_buttongroup,'Style','pushbutton','String','Stop Preview','Units','Normalize',...
    'Position',[0.5294 0.1491 0.4243 0.7894],'HorizontalAlignment','center','FontSize',8,'Enable','off','Callback',@acqstop_button);
%%%%%%%%%%%%Start Preview%%%%%%%%%%
 function prestart_button(hObject,eventData)
        prestart_button_state=get(hObject,'Value');
        if prestart_button_state==get(hObject,'Max')
            set(pre_start_button,'Enable','off');
            set(pre_stop_button,'Enable','on');
        end
        vid_adaptor_value=get(adap_name_control,'Value');
        vid_adaptor_string=get(adap_name_control,'String');
        vid_adaptor_selected=char(vid_adaptor_string(vid_adaptor_value));
        
        vid_dev_value=get(dev_name_control,'Value');
        vid_dev_string=get(dev_name_control,'String');
        vid_dev_selected=vid_dev_value -1;
        
        vid_Res_value=get(Res_name_control,'Value');
        vid_Res_string=get(Res_name_control,'String');
        vid_Rev_selected=char(vid_Res_string(vid_Res_value));
        
        global vid
        
        aaaaa=isempty(vid)
        if aaaaa==0;
            global keeplooping
            keeplooping=false;
            release(vid);
            clear vid;
        end
        set(acq_start_button,'Enable','on')
        set(acq_stop_button,'Enable','off')
        
        global vidpre
        global hImage
        set(ah2,'Visible','on');
        
        
        
        vidpre = videoinput(vid_adaptor_selected,vid_dev_selected, vid_Rev_selected);
        
        %         DevProp=ActiveDeviceProperties(vid)
        % only capture one frame per trigger, we are not recording a video
        vidpre.FramesPerTrigger = 1;
        % output would image in RGB color space
        vidpre.ReturnedColorspace = 'rgb';
        % tell matlab to start the webcam on user request, not automatically
        triggerconfig(vidpre, 'manual');
        % we need this to know the image height and width
        vidRes = get(vidpre, 'VideoResolution');
        % image width
        imWidth = vidRes(1);
        % image height
        imHeight = vidRes(2);
        % number of bands of our image (should be 3 because it's RGB)
        nBands = get(vidpre, 'NumberOfBands');
        % create an empty image container and show it on axPreview
        hImage = image(zeros(imHeight, imWidth, nBands), 'parent', ah2,'Visible','on');
        % begin the webcam preview
        preview(vidpre, hImage);
end
end