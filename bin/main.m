% ����ʶ��
% ��������������Ŀ������
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
            %�������Դ�������빩������ѵ��������
            [feature,pic,flag]=getFeature(bw2);
            features(:,count)=feature;
            labels(count)=k;
            count=count+1;
        end     %������ѵ��������Ӧ�����ֵt
    end
end

'Loaded.'
labels;
save FandL features labels;
% ������ѵ��BP����

clear all;
load FandL features labels;   %��������

for i=1:15
pr(i,1)=min(features(i,:));
pr(i,2)=max(features(i,:));
end;

%����BP���� 
net=newff(pr,[100 1],{'logsig' 'purelin'}, 'traingda', 'learngdm'); 
net.trainParam.epochs=100000;  %��������������
net.trainParam.goal=0.01;    %����ѵ��Ŀ�� 
net.trainParam.show=1000;     %����ѵ��������ʾ���� 
net.trainParam.lr=0.05;      %����ѵ������
net=train(net,features,labels);          %ѵ��BP����  
'Training Complete.'

save FLnet net;

% ʶ��
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
    [a,Pf,Af]=sim(net,pp);   %�������� 
    imshow(bwp);
    a=round(a)     %�������ʶ���� 
end