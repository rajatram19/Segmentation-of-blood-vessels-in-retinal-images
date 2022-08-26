function level=Threshold_Level(Image)

Image=im2uint8(Image(:));
[Histogram_count,Bin_Number]=imhist(Image);

i=1;

Cumulative_Sum = cumsum(Histogram_count);
T(i)=(sum(Bin_Number.*Histogram_count))/Cumulative_Sum(end);
T(i)=round(T(i));

Cumulative_Sum_2= cumsum(Histogram_count(1:T(i)));
MBT=sum(Bin_Number(1:T(i)).*Histogram_count(1:T(i)))/Cumulative_Sum_2(end);

Cumulative_Sum_3= cumsum(Histogram_count(T(i):end));
MAT=sum(Bin_Number(T(i):end).*Histogram_count(T(i):end))/Cumulative_Sum_3(end);

i=i+1;
T(i)=round((MAT+MBT)/2);

while abs(T(i)-T(i-1))>=1
    
    Cumulative_Sum_2= cumsum(Histogram_count(1:T(i)));
    MBT=sum(Bin_Number(1:T(i)).*Histogram_count(1:T(i)))/Cumulative_Sum_2(end);
    
    Cumulative_Sum_3= cumsum(Histogram_count(T(i):end));
    MAT=sum(Bin_Number(T(i):end).*Histogram_count(T(i):end))/Cumulative_Sum_3(end);
    
    i=i+1;
    T(i)=round((MAT+MBT)/2);

Threshold = T(i);

end

level=(Threshold-1)/(Bin_Number(end)-1);

end


