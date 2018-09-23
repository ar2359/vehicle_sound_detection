function clean = Denoise(s,Fs) 

l_s = length(s);
%[cA1,cD1] = dwt(s,'db1');
%A1 = upcoef('a',cA1,'db1',1,l_s);
%D1 = upcoef('d',cD1,'db1',1,l_s);
%subplot(1,2,1); 
%plot(A1);
%title('Approximation A1')
%subplot(1,2,2);
%plot(D1);
%title('Detail D1');
%A0 = idwt(cA1,cD1,'db1',l_s); 
%err = max(abs(s-A0))
[C,L] = wavedec(s,3,'db1');
cA3 = appcoef(C,L,'db1',3);
cD3 = detcoef(C,L,3); 
cD2 = detcoef(C,L,2);
cD1 = detcoef(C,L,1);
A3 = wrcoef('a',C,L,'db1',3);
D1 = wrcoef('d',C,L,'db1',1);
D2 = wrcoef('d',C,L,'db1',2);
D3 = wrcoef('d',C,L,'db1',3);
%subplot(2,2,1)
%plot(A3); 
%title('Approximation A3')
%subplot(2,2,2)
%plot(D1);
%title('Detail D1') 
%subplot(2,2,3)
%plot(D2);
%title('Detail D2')
%subplot(2,2,4)
%plot(D3);
%title('Detail D3')
%A0 = waverec(C,L,'db1');
%err = max(abs(s-A0))
%subplot(2,1,1);
%plot(s);
%title('Original'); 
%axis off
%subplot(2,1,2);
%plot(A3);
%title('Level 3 Approximation');
%axis off
[thr,sorh,keepapp] = ddencmp('den','wv',s);
clean = wdencmp('gbl',C,L,'db1',3,thr,sorh,keepapp);
%subplot(2,1,1);
%plot(s);
% title('Original')
% subplot(2,1,2);
% plot(clean);
% title('De-noised')

