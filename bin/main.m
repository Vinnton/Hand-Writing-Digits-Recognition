% 数字识别
% 生成输入向量和目标向量
clear all;
'LOADING......'
training_digits = 10;
row_min=1;
col_min=1;
row_max = 10;
col_max = 10;
features=[];
count=1;
for k = 0:training_digits-1
    m=strcat('AfterAppr_',int2str(k),'.bmp');
    bw=imread(m,'bmp');
    for i = row_min-1:row_max-1
        for j = col_min-1:col_max-1
            bw2 = bw(i*64+1:i*64+64,j*64+1:j*64+64);
            %将处理的源样本输入供神经网络训练的样本
            [feature,pic,flag]=getFeature(bw2);
            features(:,count)=feature;
            labels(count)=k;
            count=count+1;
        end     %建立与训练样本对应的输出值t
    end
end

'Loaded.'
labels;
save FandL features labels;
% 创建和训练BP网络

clear all;
load FandL features labels;   %加载样本

for i=1:15
pr(i,1)=min(features(i,:));
pr(i,2)=max(features(i,:));
end;

%创建BP网络 
net=newff(pr,[100 1],{'logsig' 'purelin'}, 'traingda', 'learngdm'); 
net.trainParam.epochs=100000;  %设置最大迭代次数
net.trainParam.goal=0.01;    %设置训练目标 
net.trainParam.show=1000;     %设置训练表现显示格数 
net.trainParam.lr=0.05;      %设置训练步长
net=train(net,features,labels);          %训练BP网络  
'Training Complete.'

save FLnet net;

% 识别
for times=0:10
    clear all;
    load FLnet net;
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