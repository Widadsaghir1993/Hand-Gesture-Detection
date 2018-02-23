function [s,a]=ActiveDevice(dev_name_control,Adaptor,adaptor_selected_value)
if adaptor_selected_value>= 2
    
    
    Selected_Adaptor=Adaptor.ActiveAdaptor(adaptor_selected_value);
    Selected_Device=imaqhwinfo(char(Selected_Adaptor));
    Selected_Device_info=Selected_Device.DeviceInfo;
    Device_installed_count=numel(Selected_Device_info);
    k=1;
    s.Name{1}='---Select Active Device---';
    s.Resolution{1}=[];
    for device_count=1:Device_installed_count
        a=Selected_Device_info(device_count);
        k=k+1;
        s.Name{k}=a.DeviceName;
        s.Resolution{k}=a.SupportedFormats
    end
    
else
   errordlg('Select Active Adaptor','File Error');
    set(dev_name_control ,'Value',1);
   
    
end
end