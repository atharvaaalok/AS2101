function A_inv = invert_matrix_function(A)
    [m ~] = size(A);
    I = eye(m);
    
    for i  = 1:m
        % when last element is being dealt with
        if i == m
            last_ele = A(i:end,i:end);
            A(i:end,:) = A(i:end,:)/last_ele;
            I(i:end,:) = I(i:end,:)/last_ele;
            for j =  1:(m-1)
                col = A(:,i);
                val = col(j);
                
                A(j,:) = A(j,:) - val*A(i,:);
                I(j,:) = I(j,:) - val*I(i,:);
            end
            break
        end
        A_smaller = A(i:end,i:end);
        
        col = A_smaller(:,1);
        
        logical_col = (col ~= 0);
        contains1 = 0;
        index = 0;
        for j = 1:length(logical_col)
            if logical_col(j) == 1
                contains1 = 1;
                index = j;
                break
            end
        end
        if contains1 == 0
            continue
        end
        entry = col(index);
        
        row1 = A(i,:);
        row1_I = I(i,:);
        
        
        row_change = A(i+index-1,:);
        row_change_I = I(i+index-1,:);
        
        row_change = row_change / entry;
        row_change_I = row_change_I / entry;
        
        A(i,:) = row_change;
        I(i,:) = row_change_I;
        
        
        if i ~= i+index-1
            A(i+index-1,:) = row1;
            I(i+index-1,:) = row1_I;
        end
        
        for j =  1:m
            if j == i
                continue
            end
            col = A(:,i);
            val = col(j);
            
            A(j,:) = A(j,:) - val*A(i,:);
            I(j,:) = I(j,:) - val*I(i,:);
        end

    end
 
    A_inv = I;
    
end