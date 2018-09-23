function [pos,A] = Chooseblock(f,winLength,winStep)
A=0;
B=0;
c=0;
pos=1;
L=length(f);  
Output(winLength)=0;
numOfBlocks = (L-winLength)/winStep + 1;
numOfBlocks=floor(numOfBlocks);
curPos = 1;
E(numOfBlocks)=0;

curBlock = f(curPos:curPos+winLength-1);
    l=length(curBlock);
    Y=fft(curBlock);
    for(j=1:l)
    E(1)=E(1)+ log10(Y(j));
    end 
    A=abs(E(1));
for (i=2:numOfBlocks)
    curBlock = f(curPos:curPos+winLength-1);
    l=length(curBlock);
    Y=fft(curBlock);
    
    
for(j=1:l)
    E(i)=E(i)+ log10(Y(j));
end


B=abs(E(i));
if(B<A)
    c=c+1;
    pos=curPos;
    A=abs(E(i));
end
curPos=curPos+winStep;

end 
disp(A);
    
    
   

