function [U,S,V,w,v1,v2,v3] = class_train3(train_1,train_2,train_3,features,dim)
    n1 = size(train_1,2); n2 = size(train_2,2); n3 = size(train_3,2);
    
    [U,S,V] = svd([train_1 train_2 train_3],'econ');
    
    signal = S*V';
    U = U(:,1:features);
    
    %Category features
    cat1 = signal(1:features,1:n1);
    cat2 = signal(1:features,n1+1:n1+n2);
    cat3 = signal(1:features,n1+n2+1:end);
    
    m1 = mean(cat1,2); m2 = mean(cat2,2); m3 = mean(cat3,2); %Category Means
    
    %Total Mean
    mt = mean(signal(1:features,:),2);
    
    %Variance Within Category
    Sw = 0;
    for j = 1:n1
        Sw = Sw + (cat1(:,j)-m1)*(cat1(:,j)-m1)';
    end
    for k = 1:n2
        Sw = Sw + (cat2(:,k)-m2)*(cat2(:,k)-m2)';
    end
    for l = 1:n3
        Sw = Sw + (cat3(:,l)-m3)*(cat3(:,l)-m3)';
    end
    
    %Variance Between Categories
    Sb = (m1-mt)*(m1-mt)' + (m2-mt)*(m2-mt)' + (m3-mt)*(m3-mt)';
    
    %Selecting Principle Components
    [V2,D] = eig(Sb,Sw);
    [M,I] = max(abs(diag(D)));
    [~,I2] = max(abs(diag(D).*diag(D<M)));
    w = [V2(:,I) V2(:,I2)]; w = w(:,1:dim); w = w/norm(w,2);
    
    %LDA Projection
    v1 = w'*cat1;
    v2 = w'*cat2;
    v3 = w'*cat3;
end