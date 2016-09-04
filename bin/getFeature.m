function [Feature,bwp,flag]=getFeature(A)
A=ones(64,64)-A;
[x,y]=find(A==1);
xymin=min(min(x),min(y));
xymax=max(max(x),max(y));
A=A(min(x):max(x),min(y):max(y));  
flag=(max(y)-min(y)+1)/(max(x)-min(x)+1);
if flag<0.5
    flag=0;
elseif flag >=0.5 & flag <0.75
    flag=1;
elseif flag >=0.75 & flag <1
    flag=2;
else flag=3;
end
        
rate=64/max(size(A));
A=imresize(A,rate);  %对输入文件变尺寸处理
[x,y]=size(A);
if x~=64
    A=[zeros(ceil((64-x)/2)-1,y);A;zeros(floor((64-x)/2)+1,y)];
end;
if y~=64
    A=[zeros(64,ceil((64-y)/2)-1),A,zeros(64,floor((64-y)/2)+1)];
end

%竖直中线交点数，
        Vc=32;
        VcNum=0;
        for i=1:64
          VcNum=VcNum+A(i,Vc);
        end
        F(1)=VcNum;
 
%竖直5/12处
        Vc=round(64*5/12);
        VcNum=0;
        for i=1:64
          VcNum=VcNum+A(i,Vc);
        end
        F(2)=VcNum; 

%竖直7/12处，
        Vc=round(64*7/12);
        VcNum=0;
        for i=1:64
          VcNum=VcNum+A(i,Vc);
        end
        F(3)=VcNum; 
%水平中线交点数	
        Hc=32;
        HcNum=0;
        for i=1:64
          HcNum=HcNum+A(Hc,i);
        end
        F(4)=HcNum;
%水平1/3处交点数，
        Hc=round(64/3);
        HcNum=0;
        for i=1:64
          HcNum=HcNum+A(Hc,i);
        end
        F(5)=HcNum;

%水平2/3处交点数，
        Hc=round(2*64/3);
        HcNum=0;
        for i=1:64
          HcNum=HcNum+A(Hc,i);
        end
        F(6)=HcNum;
%左对角线交点数，
        x3=1;
        y3=1;
        sum3=0;
        for i=0:63
        sum3=sum3+A(x3+i,y3+i);
        end
        F(7)=sum3;
%右对角线交点数     
        x4=1;
        y4=64;
        sum4=0;
        for i=0:63
        sum4=sum4+A(x4+i,y4-i);
        end
        F(8)=sum4;

        x1=32;
        y1=64;
        sum1=0;
        for i=0:32
        sum1=sum1+A(x1+i,y1-i);
        end
%         F(1+k,9)=sum1;
        
        x2=48;
        y2=64;
        sum2=0;
        for i=0:16
        sum2=sum2+A(x2+i,y2-i);
        end
        F(9)=sum1+sum2;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        sum5=0;
        for i=32:64
            for r=32:64
              sum5=sum5+A(i,r);
            end
        end
        F(10)=sum5/10;
     
        sum8=0;
        for i3=1:32
            for r3=1:32
              sum8=sum8+A(i3,r3);
            end
        end
        F(11)=sum8/10;
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sum9=0;
        for i4=1:32
            for r4=32:64
              sum9=sum9+A(i4,r4);
            end
        end
        F(12)=sum9/10;
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sum10=0;
        for i5=32:64
            for r5=1:32
              sum10=sum10+A(i5,r5);
            end
        end
        F(13)=sum10/10;
        
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sum6=0;
        for i1=1:64
            for r1=16:48
              sum6=sum6+A(i1,r1);
            end
        end
        F(14)=sum6/20;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sum7=0;
        for i2=16:48
            for r2=1:64
              sum7=sum7+A(i2,r2);
            end
        end
        F(15)=sum7/20;
        %[FN,minp,maxp] = premnmx(F);
        Feature=F';
        flag;
        bwp=A;