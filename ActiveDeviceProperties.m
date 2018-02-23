
function DevProp=ActiveDeviceProperties(vid);
%vid = videoinput('winvideo',2,'MJPG_640x480');
src_obj = getselectedsource(vid);

a=propinfo(src_obj);
b=fieldnames(a);
a_count=numel(b);
k=0;

for i=1:a_count
    
    c=propinfo(src_obj,b(i));
    d= c{1,1}.ConstraintValue;
    e=isempty(d);
    if e==0
        k=k+1;
        DevProp.list(k)=b(i);
        DevProp.ConstraintValue{k}=d;
        DevProp.DefaultValue{k}=c{1,1}.DefaultValue;
        
    end
end
end