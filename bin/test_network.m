for times=0:10
    clear all;
    load E52net net;
    z=input('FileNo:', 's');
    x=str2num(input('LineNo:', 's'));
    y=str2num(input('colmNo:', 's'));
    test=strcat('NewAppr_',z,'.bmp');
    x=imread(test,'bmp');
    bw=x((x-1)*64+1:(x-1)*64+64,(y-1)*64+1:(y-1)*64+64);
    [pp,bwp]=getFeature(bw);
    [a,Pf,Af]=sim(net,pp);   %测试网络 
    imshow(bwp);
    a=round(a)     %输出网络识别结果 
end