function [ output_args ] = KFOLD_PCA( k, filePathTrainData,p )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
filePathTrainData1=filePathTrainData(2:size(filePathTrainData,1),:);
    %k = 2;
    size(filePathTrainData1)
[U,S,PC] = svd(filePathTrainData1,'econ');
%p=40; 
Uk=U(:, 1:p); 
X=Uk'*filePathTrainData1;
Ytrain=double(filePathTrainData(1, :));
s=size(X,1)
Xtrain=vertcat(Ytrain,X);
Xtrain=Xtrain';
% KFOLD(5,Y);
   % XYtrain = load(filePathTrainData);
  % Xtrain=double(Xtrain)';

   % Xtrain = double(XYtrain(1:size(XYtrain, 1), :))';

    %Ytrain = double(XYtrain(1, :))';
    
    %SwapColumn = Xtrain(:, 1);
    %A = Xtrain(: , (2:size(Xtrain, 2)));
    %for i=1:size(A,1)
        %A(i,:) = bsxfun(@rdivide,A(i,:),sum(A(i,:)));
    %end 
    %sum(A(1,:));
    %Xtrain =horzcat(A,SwapColumn); 
    
    OutPutMatrix = cell(2,k)

    for m = 1:k
        OutPutMatrix(1,m) = mat2cell(rand( 40 * (10 - floor(10/k)), s), [40 * (10 - floor(10/k))],[s]);
        OutPutMatrix(2,m) = mat2cell(rand(40 * (floor(10/k)), s), [40 * (floor(10/k))],[s]);
    end
    
    a = 1;
    for i = 1 : k
        Test = rand((size(Xtrain, 1)/10) * (floor(10/k)), size(Xtrain,2));
        Train = rand((size(Xtrain, 1)/10) * (10 - floor(10/k)), size(Xtrain,2));
        testIncrementor = 1;
        trainIncrementor = 1;
        for j = 0:10:(size(Xtrain,1) - (k*floor(10/k)))
            for l = 1:10
                if(l >= a && l < a + floor(10/k))
                    Test(testIncrementor , :) = Xtrain(j+l , :);
                    testIncrementor = testIncrementor + 1;
                else
                    Train(trainIncrementor , :) = Xtrain(j+l , :);
                    trainIncrementor = trainIncrementor + 1;
                end
            end
        end
        a = a + floor(10/k);
        size(Train)
        size(Test)
        OutPutMatrix( 1 , i ) =  mat2cell(Train, size(Train,1),[s+1]);
        OutPutMatrix( 2, i) = mat2cell(Test, size(Test,1),[s+1]);
    end

    output_args = OutPutMatrix
end

