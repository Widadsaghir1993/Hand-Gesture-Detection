function CameraSettings

% Get the Screen Size Display%
screen_size=get(0,'ScreenSize');
screen_size_height = screen_size(4);
screen_size_width =screen_size(3);
%Set the Figure Size%
set_height = screen_size_height*.8;
set_width = screen_size_width*.8;
offset_x=screen_size_height*.1;
offset_y=screen_size_width*.1;
%Main Figure%
main_fig= figure('Visible','on','Name','Hand Gesture Recognition','MenuBar','none',...
    'Position',[offset_y,offset_x,set_width,set_height ],'NumberTitle','off','Alphamap',.1,'WindowStyle','modal');

%Camera Preview%
cam_prev= uipanel('Parent',main_fig,'Title','',...
    'Position',[0.47/2 0.0195 0.5219 0.9723],'FontSize',8,'BorderType','none');%[0.47 0.0195 0.5219 0.9723]
video_prev= uipanel('Parent',cam_prev,'Title','',...
    'Position',[0.0371 0.26 0.9293 0.6793],'FontSize',8,'BorderType','none','BackgroundColor',[.3 .3 .3]);
ah2 = axes('Parent',video_prev,'Position',[0.01 0.01 0.98 0.98],'XTick',[],'YTick',[],'Color',[.3 .3 .3],'Visible','off');
axis ij
camprev_txt_control = uicontrol('Parent',cam_prev,'Style','text','String','Camera Preview','Units','Normalize',...
    'Position',[0.0371 0.955 0.2296 0.0310],'HorizontalAlignment','left','FontSize',11,'FontAngle','Italic');
Preview_buttongroup= uipanel('Parent',cam_prev,'Title','Camera Preview',...
    'Position',[0.0371 0.0227 0.4275 0.2058],'FontSize',8);
pre_start_button = uicontrol('Parent',Preview_buttongroup,'Style','pushbutton','String','Start Preview','Units','Normalize',...
    'Position',[0.0546 0.1491 0.4243 0.7894],'HorizontalAlignment','center','FontSize',8,'Enable','off','Callback',@prestart_button);
pre_stop_button = uicontrol('Parent',Preview_buttongroup,'Style','pushbutton','String','Stop Preview','Units','Normalize',...
    'Position',[0.5294 0.1491 0.4243 0.7894],'HorizontalAlignment','center','FontSize',8,'Enable','off','Callback',@prestop_button);

StartAcq_buttongroup= uipanel('Parent',cam_prev,'Title','Start Acquisation',...
    'Position',[0.54 0.0227 0.4275 0.2058],'FontSize',8);
acq_start_button = uicontrol('Parent',StartAcq_buttongroup,'Style','pushbutton','String','Start Preview','Units','Normalize',...
    'Position',[0.0546 0.1491 0.4243 0.7894],'HorizontalAlignment','center','FontSize',8,'Enable','off','Callback',@acqstart_button);
acq_stop_button = uicontrol('Parent',StartAcq_buttongroup,'Style','pushbutton','String','Stop Preview','Units','Normalize',...
    'Position',[0.5294 0.1491 0.4243 0.7894],'HorizontalAlignment','center','FontSize',8,'Enable','off','Callback',@acqstop_button);

%Device Acquisation%
dev_acq= uipanel('Parent',main_fig,'Title','',...
    'Position',[0.0082 0.0195 0.225 0.9175],'FontSize',8,'BorderType','none');
% devacq_txt_control = uicontrol('Parent',dev_acq,'Style','text','String','Device Acquisation','Units','Normalize',...
%     'Position',[0.0290 0.9 0.5394 0.0746],'HorizontalAlignment','center','FontSize',11,'FontAngle','Italic');
refreshbutton_control = uicontrol('Parent',dev_acq,'Style','pushbutton','String','Refresh','Units','Normalize',...
    'Position',[0.6721 0.8545 0.2946 0.1244],'HorizontalAlignment','center','FontSize',8);
deviceacqui_panelbutton = uicontrol('Parent',main_fig,'Style','text','String','Device Acquisation','Units','Normalize',...
    'Position',[0.0082 0.937 0.06 0.055],'HorizontalAlignment','center','FontSize',8,'BackgroundColor',[.941 .941 .941],'ButtonDownFcn',@devacq_buttondown);

adap_name= uipanel('Parent',dev_acq,'Title','Adaptor Name:',...
    'Position',[0.025 0.7556 0.95 0.09],'FontSize',8);
adap_name_control = uicontrol('Parent',adap_name,'Style','popup','String','h','Units','Normalize',...
    'Position',[0.0379 0.1599 0.9336 0.660],'HorizontalAlignment','center','FontSize',8,'Callback',@InstalledAdaptor_popup);

dev_name= uipanel('Parent',dev_acq,'Title','Device Name:',...
    'Position',[.025 0.65 0.95 0.09],'FontSize',8);
dev_name_control = uicontrol('Parent',dev_name,'Style','popup','String','---Select Active Device---','Units','Normalize',...
    'Position',[0.0379 0.1599 0.9336 0.660],'HorizontalAlignment','center','FontSize',8,'Enable','off','Callback',@DeviceName_popup);

Res_name= uipanel('Parent',dev_acq,'Title','Resolution:',...
    'Position',[.025 0.55 0.95 0.09],'FontSize',8);
Res_name_control = uicontrol('Parent',Res_name,'Style','popup','String','---Select Resolution---','Units','Normalize',...
    'Position',[0.0379 0.1599 0.9336 0.660],'HorizontalAlignment','center','FontSize',8,'Enable','off');

colorspace_name= uipanel('Parent',dev_acq,'Title','ColorSpace:',...
    'Position',[.025 0.45 0.95 0.09],'FontSize',8);
colorspace_name_control = uicontrol('Parent',colorspace_name,'Style','popup','String','h','Units','Normalize',...
    'Position',[0.0379 0.1599 0.9336 0.660],'HorizontalAlignment','center','FontSize',8,'Enable','off');
%%%%%%%%%%%%%%Acquisation Setting%%%%%%%%%%%%%%%%%
devpro_name= uipanel('Parent',main_fig,'Title','',...
    'Position',[0.0082 0.0195 0.45 0.9175],'FontSize',8,'Visible','off','BorderType','none');


%%%%%%%%%%%%%%Panel Group%%%%%%%%%%%%%%
devicepro_panelbutton = uicontrol('Parent',main_fig,'Style','text','String','Device Properties','Units','Normalize',...
    'Position',[0.07 0.937 0.06 0.055],'HorizontalAlignment','center','FontSize',8,...
    'BackgroundColor',[.395 .475 .635],'ForegroundColor',[1 1 1],'ButtonDownFcn',@devpro_buttondown);

    function devpro_buttondown(hObject,eventData)
        set(devicepro_panelbutton ,'BackgroundColor',[.941 .941 .941],'ForegroundColor',[0 0 0])
        set(deviceacqui_panelbutton ,'BackgroundColor',[.395 .475 .635],'ForegroundColor',[1 1 1])
        set(dev_acq,'Visible','off')
        set(devpro_name,'Visible','on')
        %         for mn=0.025:.025:0.45
        %              pause(.00000001)
        %             set(devpro_name,'Position',[0.0082 0.0195 mn 0.9175])
        %         end
        %         set(cam_prev,'Position',[0.47 0.0195 0.5219 0.9175])
    end
    function devacq_buttondown(hObject,eventData)
        set(devicepro_panelbutton ,'BackgroundColor',[.395 .475 .635],'ForegroundColor',[1 1 1])
        set(deviceacqui_panelbutton ,'BackgroundColor',[.941 .941 .941],'ForegroundColor',[0 0 0])
        set(dev_acq,'Visible','on')
        set(devpro_name,'Visible','off')
        %         set(cam_prev,'Position',[0.24 0.0195 0.5219 0.9175])
    end

%%%%%%%%%%%%%%Check Installed Active Adaptor%%%%%%

val=1;%Set one as Input to run the Function
Adaptor=ActiveAdaptor(val);%Function that can Check the Active Adaptor
set(adap_name_control,'String', Adaptor.ActiveAdaptor);%Input in Pop-up Menu Listof Active Adaptor

    function InstalledAdaptor_popup(hObject,eventData)
        global s
        adaptor_selected_value=get(hObject,'Value');
        if adaptor_selected_value>= 2
            set(dev_name_control,'Enable','on');
            set(Res_name_control,'Enable','off');
        else
            set(Res_name_control ,'Value',1);
            set(dev_name_control,'Enable','off');
            set(Res_name_control,'Enable','off');
        end
        s=ActiveDevice(dev_name_control,Adaptor,adaptor_selected_value);
        set(dev_name_control ,'String',s.Name)
        
    end
    function DeviceName_popup(hObject,eventData)
        global s
        device_selected_value=get(hObject,'Value');
        res=s.Resolution;
        if device_selected_value>= 2
            set(Res_name_control,'Enable','on');
            set(Res_name_control,'String',res{device_selected_value});
            set(Res_name_control ,'Value',1);
            set(pre_start_button,'Enable','on');
            set(acq_start_button,'Enable','on');
            
            
        else
            
            set(Res_name_control ,'Value',1);
            set(Res_name_control,'Enable','off');
            set(pre_start_button,'Enable','off');
            set(acq_start_button,'Enable','off');
            
        end
    end
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
    function prestop_button(hObject,eventData)
        prestop_button_state=get(hObject,'Value');
        
        global vidpre
        global hImage
        stoppreview(vidpre);
        set(ah2,'Visible','off');
        set(hImage,'Visible','off');
        set(ah2,'Color',[0.3 0.3 0.3])
        if prestop_button_state==get(hObject,'Max')
            set(pre_start_button,'Enable','on')
            set(pre_stop_button,'Enable','off')
            
        end
        
        
    end
    function acqstart_button(hObject,eventData)
        global image_database
        global bw_image
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for image_sample=1:26;
            
       
            
            imagename=sprintf('feature_rgb_%d.jpg',image_sample);
            image=imread(imagename);
            % gray_image=rgb2gray(image);
            gray_level=graythresh(image);
            bw_image1=im2bw(image,gray_level);
            seg_image=imcomplement(bw_image1);
            seg_image_holes=imfill(seg_image,'holes');
            image_resize=imresize(seg_image_holes,[ 12 8]);
            orig_image_resize=imresize(image,[ 12 8]);
            orig_image_resize1=reshape(orig_image_resize,[ 1 96])
            filename=sprintf('feature_bw_%d.jpg',image_sample);
            image_database(image_sample,:)=orig_image_resize1
            imwrite(image_resize,filename);
            %imshow(image_resize)
            s = regionprops(image_resize,orig_image_resize, {'Centroid','WeightedCentroid','Area','BoundingBox','Orientation','Eccentricity'});
            %  count=numel(bw_image.area)
            %      count=count+1
            
            bw_image.area(image_sample,1)=s.Area;
            bw_image.weightedarea(image_sample,1)=bw_image.area(image_sample,1)/96;
           
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %
        %               bw_image=open('bw_image.mat')
        %                 area=bw_image.bw_image(1)
        %
        %                 weighted=open('weighted.mat')
        acqstart_button_state=get(hObject,'Value');
        if acqstart_button_state==get(hObject,'Max')
            set(acq_start_button,'Enable','off');
            set(acq_stop_button,'Enable','on');
            
            
            
        end
        vid_adaptor_value=get(adap_name_control,'Value');
        vid_adaptor_string=get(adap_name_control,'String');
        vid_adaptor_selected=char(vid_adaptor_string(vid_adaptor_value));
        
        vid_dev_value=get(dev_name_control,'Value');
        vid_dev_string=get(dev_name_control,'String');
        vid_dev_selected=vid_dev_value -1;
        
        vid_Res_value=get(Res_name_control,'Value');
        vid_Res_string=get(Res_name_control,'String');
        vid_Rev_selected=char(vid_Res_string(vid_Res_value)); global vidpre
        
        bbbbb=isempty(vidpre)
        if bbbbb==1;
            
            stoppreview(vidpre);
            delete (vidpre);
            global hImage
            set(hImage,'Visible','off');
            
        end
        
        set(ah2,'Visible','off');
        
        set(ah2,'Color',[0.3 0.3 0.3])
        set(pre_start_button,'Enable','on')
        set(pre_stop_button,'Enable','off')
        
        global vid
        global keeplooping
        %         global hImage
        set(ah2,'Visible','on');
        
        
        
        vid = imaq.VideoDevice(vid_adaptor_selected,vid_dev_selected, vid_Rev_selected);
        keeplooping=true;
        while keeplooping;
            frame = step(vid);
            a1=rgb2gray(frame);
            graythresh1=graythresh(a1)
            a3=im2bw(a1,.7);
            a3=imcomplement(a3);
%             se90 = strel('line', 9, 90);
%             se0 = strel('line', 9, 0);
%             BWsdil = imdilate(a3, [se90 se0]);
            a4=imfill(a3,'holes');
            pos=[30,30,200,256]/2;
            rectangle('Position',pos,'EdgeColor','r' )
            im_roi=imcrop(a4,pos);
            im_roi2=imcrop(a1,pos);
            input_image_resize=imresize(im_roi2,[ 12 8]);
            s1 = regionprops(im_roi,im_roi2, {'Centroid','WeightedCentroid','Area','BoundingBox','Orientation','Eccentricity'});
            sStd = [s1.Area]
            ab=numel(sStd)
            aa=isempty(sStd);
            if aa==1
                figure(1),imshow(  frame,'Parent',ah2,'InitialMagnification','fit');
            else
                [~,idx]=max(sStd);
                areapos1=(s1(idx).BoundingBox);
                %                 eccent=s1.Eccentricity
                if ab>= 2 && sStd(idx)<=2000
                    figure(1),imshow( frame,'Parent',ah2,'InitialMagnification','fit');
                else
                    
                    im_crop9=imcrop(im_roi2,areapos1);
                    rectangle('Position',areapos1,'EdgeColor','g' )
                    bw_image19=im2bw(im_crop9,.7);
                    seg_image9=imcomplement(bw_image19);
                       se90 = strel('line', 3, 90);
            se0 = strel('line', 3, 0);
            BWsdil = imdilate(seg_image9, [se90 se0]);
                    seg_image_holes9=imfill(BWsdil,'holes');
                    image_resize=imresize(seg_image_holes9,[ 12 8]);
                    input_image=imresize(im_crop9,[ 12 8])
%                     count_image=count(input_image)
                    input_image2=reshape(input_image.*255,[1 96])
                    input_image3=transpose(input_image2);
                    s1 = regionprops(image_resize, {'Area'});
                   input_image_area=s.Area;
                   input_weightedarea=input_image_area/96;
                   a=image_database
                    win=(negdist(image_database, input_image3))
                    
                    emd=(bw_image.weightedarea.*win)/input_weightedarea
                    
%                     win=transpose(emd);
                    winner1=compet(win)
                    winner=vec2ind(winner1);
                    alpha(1,1)='a';
                    alpha(2,1)='b';
                    alpha(3,1)='c';
                    alpha(4,1)='d';
                    alpha(5,1)='e';
                    alpha(6,1)='f';
                    alpha(7,1)='g';
                    alpha(8,1)='h';
                    alpha(9,1)='i';
                    alpha(10,1)='j';
                    alpha(11,1)='k';
                    alpha(12,1)='l';
                    alpha(13,1)='m';
                    alpha(14,1)='n';
                    alpha(15,1)='o';
                    alpha(16,1)='p';
                    alpha(17,1)='q';
                    alpha(18,1)='r';
                    alpha(19,1)='s';
                    alpha(20,1)='t';
                    alpha(21,1)='u';
                    alpha(22,1)='v';
                    alpha(23,1)='w';
                    alpha(24,1)='x';
                    alpha(25,1)='y';
                    alpha(26,1)='z';
                    winner_letter=alpha(winner)
                    %%%%%%%%%%%%%%%%%%%%%%%%
                    position=[30 ,350];
                    value= winner_letter;
                    text('Position',position,'EdgeColor','r','String',value,'Units','pixels','Color',[.7 .7 .7],'FontSize',20)
                   figure(1),imshow( frame,'Parent',ah2,'InitialMagnification','fit');
                    %                 a222=weighted(1)
                end
                
            end
            
            
            
        end
        figure(2),imshow(seg_image_holes9);
        
    end



    function acqstop_button(hObject,eventData)
        acqstop_button_state=get(hObject,'Value');
        
        global vid
        global keeplooping
        %            global hImage
        keeplooping=false;
        release(vid);
        clear vid;
        set(ah2,'Visible','off');
        %         set(hImage,'Visible','off');
        set(ah2,'Color',[0.3 0.3 0.3])
        if acqstop_button_state==get(hObject,'Max')
            set(acq_start_button,'Enable','on')
            set(acq_stop_button,'Enable','off')
            
        end
        
        
    end
end
