path='D:\Anirudh\matlab\Programs\Test\Final Programs\PROJECT_AFTERNOON_DELETE_AFTER_TODAY\sounds_for_testing_classifier'; 
folder=path;
dirListing = dir(folder);

LEN=(length(dirListing)-2);
thresh=zeros(LEN,1);

EEMean=zeros(LEN,1);

DetStd=zeros(LEN,1);

i=1;

   for d = 3:length(dirListing) 
       fileName = fullfile(folder,dirListing(d).name);
       disp(i)

       [audio,Fs]=audioread(fileName);
       audio = Denoise(audio,Fs);
       if (Fs == 44100)
           winLength = (44100*0.1);
       else 
           winLength = (8000*0.1);
       end
       [pos,thresh(i)] = Chooseblock(audio,winLength,2000);    
       audio=audio(pos:pos+winLength-1);
       
       
       win=0.025;
       step=0.003125;
       
       EE = Energy_Entropy_Block(audio, win*Fs, step*Fs, 10);

        [app,det]=discrete_wavelet_transform(audio);
        
      
       EEMean(i) = statistic(EE, 1, length(EE), 'mean');

        DetStd(i)= statistic(det, 1, length(det), 'std');
       
       i=i+1;
   
   end  

   T=table(EEMean,DetStd);
   clc;
   load('trainedClassifier_lorry.mat');
   yfit = trainedClassifier_lorry.predictFcn(T);
   disp(yfit)
   
   
   
   
   
%    XLsheet={EEmean,EEmedian,EEstd,STEmean,STEmedian,STEstd,ZCRmean,ZCRmedian,ZCRstd,SpectralRollOFFmean,SpectralRollOFFmedian,SpectralRollOFFstd,SpectralCentroidmean,SpectralCentroidmedian,SpectralCentroidstd,SpectralFluxmean,SpectralFluxmedian,SpectralFluxstd,PSDmean,PSDmedian,PSDstd,Appmean,Appmedian,Appstd,Detmean,Detmedian,Detstd};
% 
%   
%    celllen=length(XLsheet);
% 
%    range={'A1','B1','C1','D1','E1','F1','G1','H1','I1','J1','K1','L1','M1','N1','O1','P1','Q1','R1','S1','T1','U1','V1','W1','X1','Y1','Z1','AA1'};
%    for i = 1:celllen
%        xlswrite('with_lorry_testing.xlsx',XLsheet{1,i},1,range{1,i}); 
%    end
   
   %disp(thresh)   