function Adaptor=ActiveAdaptor(val)%%%%%%%%%%%%%%%Check the Adaptor%%%%%%%%%
Adap=imaqhwinfo;
Adaptor.Name=Adap.InstalledAdaptors;% To get the list of Installeed Adaptor
Adaptor_Count=numel(Adaptor.Name);%To get the Total No. of Listed Installed Adaptor
%val=1;%Use for count looping in Active Installed Adaptor

%%%%%%%%%%%%%%%Check the Active Adaptor%%%%%%%%
for i=1:Adaptor_Count%Check each Adaptor using For Loop
    b=char(Adaptor.Name(i));%Convert to Charater Value
    a=imaqhwinfo(b);%Get the information in current looped Adaptor
    Adaptor.DevicesCount(i)=numel(a.DeviceIDs);%Count the Active Device in Each Adaptor
    adaptor_sum=sum(Adaptor.DevicesCount);
    if adaptor_sum >= 1
      if Adaptor.DevicesCount(i)>=1%Check the No of Active Device in  Adaptor
       val=val+1;%Start Counting
       Adaptor.ActiveAdaptor(1)={'---Select Active Adaptor---'};
       Adaptor.ActiveAdaptor(val)=Adaptor.Name(i);%Set Acitve Adaptor Name
      end
    elseif adaptor_sum==0 
        Adaptor.ActiveAdaptor={'---No Available Adaptor---'};
    end
end
end
