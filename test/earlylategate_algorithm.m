
input=a;
len=length(input);
L=16;
dk=zeros(1,len/L);ek=zeros(1,len/L);ai=zeros(1,len);aq=zeros(1,len);
yi=real(input); yq=imag(input);
for i=1:len/L-1
    ai(i)=yi(i*L+dk(i))*((yi(i*L+dk(i)+L/2)))
    
end
