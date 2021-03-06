function [ output_args ] = KFOLD_HandWritten_lda( k, filePathTrainData,p )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

 X=filePathTrainData(2:size(filePathTrainData,1),:)';
L=double(filePathTrainData(1, :))';
[U,W]=lda_new(X,L,p);
size(U')
Ytrain=double(filePathTrainData(1, :));
Xtrain=vertcat(Ytrain,U')';
s=size(Xtrain,2);
    
    SwapColumn = Xtrain(:, 1);
    A = Xtrain(: , (2:size(Xtrain, 2)));
    for i=1:size(A,1)
        % A(i,:) = A(i,:)/sum(A(i,:)); % Manhatten norm
        A(i,:) = A(i,:)/norm(A(i,:)); % EuclideancNorm
        %A(:, i) = A(:, i)/sum(A(:, i));
    end 
    
%     for j=1:size(A,2)
%         A(:,j) = A(:,j)/sum(A(:,j));
%     end 
    %norm(A1- A2,'fro')
    
    
    
    sum(A(1,:));
    Xtrain =horzcat(A,SwapColumn); 
    
    OutPutMatrix = cell(2,k)

    for m = 1:k
        OutPutMatrix(1,m) = mat2cell(rand( 26 * (39 - floor(39/k)), s), [26 * (39 - floor(39/k))],[s]);
        OutPutMatrix(2,m) = mat2cell(rand(26 * (floor(39/k)), s), [26 * (floor(39/k))],[s]);
    end
            
    a = 1;
    for i = 1 : k
        Test = rand(26 * (floor(39/k)), size(Xtrain,2));
        Train = rand(26 * (39 - floor(39/k)), size(Xtrain,2));
        testIncrementor = 1;
        trainIncrementor = 1;
        for j = 0:39:(size(Xtrain,1) - (k*floor(39/k)))
            for l = 1:39
                if(l >= a && l < a + floor(39/k))
                    Test(testIncrementor , :) = Xtrain(j+l , :);
                    testIncrementor = testIncrementor + 1;
                else
                    Train(trainIncrementor , :) = Xtrain(j+l , :);
                    trainIncrementor = trainIncrementor + 1;
                end
            end
        end
        a = a + floor(39/k);
        OutPutMatrix( 1 , i ) =  mat2cell(Train,  size(Train,1),[s]);
        OutPutMatrix( 2, i) = mat2cell(Test,  size(Test,1),[s]);
    end

    output_args = OutPutMatrix;
end

