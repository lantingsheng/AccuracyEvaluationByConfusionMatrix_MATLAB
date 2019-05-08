function [ CM, OveAcc, Kappa, ProAcc, UserAcc, AveAcc ] = AccuracyEvaluationByConfusionMatrix( ImgResult, ImgTruth, Numofclass )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION（实现功能）： given the classification maps and the groundtruth, compute the confusion matrix and other evaluation metrics
%                                          （给出分类结果图和地面实况图，统计出混淆矩阵CM,CM(ij)表示第i类被分
%                                          到第j类的数目,并通过混淆矩阵CM得到衡量分类精度的各个指标）           
% INPUT ARGUMENTS（ 输入参数说明）:  
%           （分类结果图）：ImgResult                      classification results
%           （地面实况图）: ImgTruth                       groundtruth
%           （类别数目）:   Numberofclass                  number of the classes
% OUTPUT ARGUMENTS（输出参数说明）:
%           （得到的混淆矩阵）：CM                         confusion matrix
%           （总体分类精度）:OveAcc                        overall accuracy
%           （Kappa系数）：Kappa                           Kappa coefficient
%           （制造者精度向量）：ProAcc                     producer accuracy
%           （用户精度向量）：UserAcc                      user accuracy
%           （平均精度向量(2维)）: AveAcc                  average accuracy
% EXAMPLE（使用举例）:
%           （自己构造好各种矩阵即可）
%           [ CM, OveAcc, Kappa, ProAcc, UserAcc, AveAcc ] = AccuracyEvaluationByConfusionMatrix( ImgResult, ImgTruth, Numofclass )
% SYMBOL INSTRUCTION（符号说明）：
%           see the code（见代码）                      
% AUTHOR（作者）:
%           Hui Qv           
%           Beihang University, School of Astronautics, Center of Image Processing
%          （北京航空航天大学 宇航学院 图像中心 曲徽  2016.6.14）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% OBTAIN INFORMATION（获取信息）
  [m,n] = size(ImgTruth);
  CM = zeros(Numofclass,Numofclass);                        %initialize the confusion matrix（初始化混淆矩阵）

%% OBTAIN THE CONFUSION MATRIX（获取混淆矩阵）   
  for i=1:m
      for j=1:n
          if(ImgTruth(i,j)==0)
              continue;
          end
          t=ImgResult(i,j);                                  %obtain the  label from the classification result（获取结果图分类值）
          k=ImgTruth(i,j);                                   %obtain the true label（获取地面实况图实际值）
          CM(k,t)=CM(k,t)+1;                                 %confusion matrix assignment（混淆矩阵赋值）
      end
             
  end
%% CALCULATE EVALUATION METRICS（计算各个评价精度）
 [m,n] = size(CM);
  r=m;                                                       %number of the classes（类别数，即r=m=n）
  rowsum=zeros(1,m);                                         %it is used to store the sum of the row valus（用于存储行和）
  columnsum=zeros(1,n);                                      %it is used to store the sum of the column valus（用于存储列和）
  N=0;                                                       %it is used to store the total number of the pixels（用于存储像素总数）
  Diagsum=0;                                                 %sum of the diag（对角线和）
  ProAcc=zeros(m,1);                                         %store the producer accuracy for every class（用于存储各个类的制造者分类精度(列向量)）
  UserAcc=zeros(m,1);                                        %store the user accuracy for every class（用于存储各个类的使用者分类精度(列向量)）
  AveAcc=zeros(2,1);                                         %store the average producer and user accuracy （第一项存储平均制造者精度，第二项存储平均使用者精度）
  for i=1:m                                                           
      for j=1:n
          rowsum(i)=rowsum(i)+CM(i,j);                       % sum of the rows and columns（行列和统计）
          columnsum(j)=columnsum(j)+CM(i,j);
          N=N+CM(i,j);                                       % compute the total number of the pixels（计算像素总数）
          if(i==j)
              Diagsum=Diagsum+CM(i,i);                       % compute the sum of the pixels which are rightly classified （统计分类正确的像素总数）
          end
      end
  end
  
  Pc=0;                                                              
  for i=1:r
      Pc=Pc+rowsum(i)*columnsum(i);
  end
 %% CALCULATE THE METRICS（计算精度指标）
  Kappa=(N*Diagsum-Pc)/(N*N-Pc);
  OveAcc=Diagsum/N;
 for i=1:m
     ProAcc(i)=CM(i,i)/rowsum(i);
     UserAcc(i)=CM(i,i)/columnsum(i);
 end
 AveAcc(1)=sum(ProAcc)/Numofclass;
 AveAcc(2)=sum(UserAcc)/Numofclass;
end

