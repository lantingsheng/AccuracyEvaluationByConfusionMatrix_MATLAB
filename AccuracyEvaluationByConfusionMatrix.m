function [ CM, OveAcc, Kappa, ProAcc, UserAcc, AveAcc ] = AccuracyEvaluationByConfusionMatrix( ImgResult, ImgTruth, Numofclass )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION��ʵ�ֹ��ܣ��� given the classification maps and the groundtruth, compute the confusion matrix and other evaluation metrics
%                                          ������������ͼ�͵���ʵ��ͼ��ͳ�Ƴ���������CM,CM(ij)��ʾ��i�౻��
%                                          ����j�����Ŀ,��ͨ����������CM�õ��������ྫ�ȵĸ���ָ�꣩           
% INPUU ARGUMENTS�� �������˵����:  
%           ��������ͼ����ImgResult                      classification results
%           ������ʵ��ͼ��: ImgTruth                       groundtruth
%           �������Ŀ��:   Numberofclass                  number of the classes
% OUTPUT ARGUMENTS���������˵����:
%           ���õ��Ļ������󣩣�CM                         confusion matrix
%           ��������ྫ�ȣ�:OveAcc                        overall accuracy
%           ��Kappaϵ������Kappa                           Kappa coefficient
%           �������߾�����������ProAcc                     producer accuracy
%           ���û�������������UserAcc                      user accuracy
%           ��ƽ����������(2ά)��: AveAcc                  average accuracy
% EXAMPLE��ʹ�þ�����:
%           ���Լ�����ø��־��󼴿ɣ�
%           [ CM, OveAcc, Kappa, ProAcc, UserAcc, AveAcc ] = AccuracyEvaluationByConfusionMatrix( ImgResult, ImgTruth, Numofclass )
% SYMBOL INSTRUCTION������˵������
%           see the code�������룩                      
% AUTHOR�����ߣ�:
%           Hui Qv           
%           Beihang University, School of Astronautics, Center of Image Processing
%          ���������պ����ѧ �ѧԺ ͼ������ ����  2016.6.14��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% OBTAIN INFORMATION����ȡ��Ϣ��
  [m,n] = size(ImgTruth);
  CM = zeros(Numofclass,Numofclass);                        %initialize the confusion matrix����ʼ����������

%% OBTAIN THE CONFUSION MATRIX����ȡ��������   
  for i=1:m
      for j=1:n
          if(ImgTruth(i,j)==0)
              continue;
          end
          t=ImgResult(i,j);                                  %obtain the  label from the classification result����ȡ���ͼ����ֵ��
          k=ImgTruth(i,j);                                   %obtain the true label����ȡ����ʵ��ͼʵ��ֵ��
          CM(k,t)=CM(k,t)+1;                                 %confusion matrix assignment����������ֵ��
      end
             
  end
%% CALCULATE EVALUATION METRICS������������۾��ȣ�
 [m,n] = size(CM);
  r=m;                                                       %number of the classes�����������r=m=n��
  rowsum=zeros(1,m);                                         %it is used to store the sum of the row valus�����ڴ洢�кͣ�
  columnsum=zeros(1,n);                                      %it is used to store the sum of the column valus�����ڴ洢�кͣ�
  N=0;                                                       %it is used to store the total number of the pixels�����ڴ洢����������
  Diagsum=0;                                                 %sum of the diag���Խ��ߺͣ�
  ProAcc=zeros(m,1);                                         %store the producer accuracy for every class�����ڴ洢������������߷��ྫ��(������)��
  UserAcc=zeros(m,1);                                        %store the user accuracy for every class�����ڴ洢�������ʹ���߷��ྫ��(������)��
  AveAcc=zeros(2,1);                                         %store the average producer and user accuracy ����һ��洢ƽ�������߾��ȣ��ڶ���洢ƽ��ʹ���߾��ȣ�
  for i=1:m                                                           
      for j=1:n
          rowsum(i)=rowsum(i)+CM(i,j);                       % sum of the rows and columns�����к�ͳ�ƣ�
          columnsum(j)=columnsum(j)+CM(i,j);
          N=N+CM(i,j);                                       % compute the total number of the pixels����������������
          if(i==j)
              Diagsum=Diagsum+CM(i,i);                       % compute the sum of the pixels which are rightly classified ��ͳ�Ʒ�����ȷ������������
          end
      end
  end
  
  Pc=0;                                                              
  for i=1:r
      Pc=Pc+rowsum(i)*columnsum(i);
  end
 %% CALCULATE THE METRICS�����㾫��ָ�꣩
  Kappa=(N*Diagsum-Pc)/(N*N-Pc);
  OveAcc=Diagsum/N;
 for i=1:m
     ProAcc(i)=CM(i,i)/rowsum(i);
     UserAcc(i)=CM(i,i)/columnsum(i);
 end
 AveAcc(1)=sum(ProAcc)/Numofclass;
 AveAcc(2)=sum(UserAcc)/Numofclass;
end

