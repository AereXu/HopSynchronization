x = [1:10 9:-1:1]; y = resample(x,3,1);
subplot(2,1,1)
plot(1:19,x,'*',(0:56)*1/3 + 1,y,'o')
title('Edge Effects Not Noticeable')
lg = legend('Original','Resampled');
set(lg,'box','off','location','south')
x = [10:-1:1 2:10]; y = resample(x,3,1); z = resample(y,1,3);
subplot(2,1,2)
plot(1:19,x,'*',(0:56)*1/3 + 1,y,'o',1:19,z,'^')
title('Edge Effects Very Noticeable')
lg = legend('Original','Resampled');
set(lg,'box','off','location','north')