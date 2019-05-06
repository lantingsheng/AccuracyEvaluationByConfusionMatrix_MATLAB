# AccuracyEvaluationByConfusionMatrix_MATLAB

MATLAB版本，依据图像的分类图标和实际的图标，计算混淆矩阵，并根据混淆矩阵计算各种常见分类指标，如OA,AA,KAPPA等。
(A MATLAB version, compute the classification confusion matrix according to the classification result and the groundtruth, and then obtain the common accuracy metrics, such as OA, AA and KAPPA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION（实现功能）： given the classification maps and the groundtruth, compute the confusion matrix and other evaluation metrics
%                                          （给出分类结果图和地面实况图，统计出混淆矩阵CM,CM(ij)表示第i类被分
%                                          到第j类的数目,并通过混淆矩阵CM得到衡量分类精度的各个指标）           
% INPUU ARGUMENTS（ 输入参数说明）:  
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
%           [ CM, OveAcc, Kappa, ProAcc, UserAcc, AveACC ] = AccuracyEvaluationByConfusionMatrix( ImgResult, ImgTruth, Numofclass )
% SYMBOL INSTRUCTION（符号说明）：
%           see the code（见代码）                      
% AUTHOR（作者）:
%           Hui Qv           
%           Beihang University, School of Astronautics, Center of Image Processing
%          （北京航空航天大学 宇航学院 图像中心 曲徽  2016.6.14）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
