%this program is written by hadi farhadi.
%this program carries out one of several decision making in the name of
%electre
%this program is able to evaluate several criteria for several options

%%%how to run the program?
%inputs from Excel file:
     
    %decision matrix
    %weight matrix
    
%export
        % best option.
        
%% start Program

format short
clear all;close all;clc;

decision_matrix=xlsread('decision_matrix1');
criteria_Negative=[2,4,5];
disp('-----------------------------------------------------------------------------')

weight1=xlsread('wazn1');
disp('-----------------------------------------------------------------------------')


[a b]=size(decision_matrix);

matrix_normal=[];
matrix_weighted=[];
for i=1:a j=1:b ;
 matrix_normal=[matrix_normal;decision_matrix(i,j)./(sqrt(sum(decision_matrix.^2)))];
 matrix_weighted=[matrix_weighted;matrix_normal(i,j).*weight1];
end
matrix_normal;
disp('-----------------------------------------------------------------------------')
matrix_weighted;



 m=matrix_weighted(:,criteria_Negative)*(-1);
matrix_weighted(:,criteria_Negative)=m;
disp('-----------------------------------------------------------------------------')

[r c]=size(matrix_weighted);
Concordance=[];
Discordance=[];
for i=1:r
    for j=1:r
       if i~=j
           Concordance=[Concordance;matrix_weighted(i,:)>=matrix_weighted(j,:)];
           Discordance=abs([Discordance;matrix_weighted(i,:)-matrix_weighted(j,:)]);
           end   
    end
end
Concordance;
Discordance;
[col,row]=find(Concordance);
 a=[col,row]';
a=a';
[k l]=size(Concordance);
weight_normal=[];
d=[];
zero=[];
Concordance_Dominance=[];
Discordance_Dominance=[];
 max_loss=[];
for w=1:k q=1:l;
    weight_normal=[weight_normal;weight1];
    
    d=find(Concordance(w,:)); 

  zero= find(Concordance(w,:)==0);
   Concordance_Dominance=[Concordance_Dominance; sum(weight_normal(w,d))];
  meyar_mokhalef= Discordance(w,zero);
  max_loss=[max_loss;max(meyar_mokhalef')'];
end

 max_loss;
 while numel( max_loss)<w
     
     
  
     disp('********the matrix values are not reasonable***********')
 break,end


Concordance_Dominance;
weight_normal;
tershold_movafeg=mean(Concordance_Dominance);
matrix_tasalot_movafeg=[Concordance_Dominance>=tershold_movafeg]';
  max_row=max(Discordance')';
matrix_mokhlef=max_loss./max_row;
tershold_mokhlef=mean(matrix_mokhlef);
matrix_tasalot_mokhalef=[matrix_mokhlef<=tershold_mokhlef]';

Final_dominance_matrix=[matrix_tasalot_movafeg].*[matrix_tasalot_mokhalef]; 
[t y ]=size(decision_matrix);
f=t*t;
r=0;
for i=1:f
    if mod(i,t+1)==1
    b(i)=nan;
    r=r+1;
    else
        p=i-r;
        b(i)=Final_dominance_matrix(p);
    end 
end
for i=1:t
    for j=1:t
            s=j+(i-1)*t;
            B(i,j)=b(s);
    end
end
Final_dominance_matrix =B
[k l]=size(Final_dominance_matrix);
Number_of_dominance=[];
for o=1:k
      number_of_tasalot_F=[ find(Final_dominance_matrix(o,:))];
     satr= o;
     
      number_of_tasalot_F=number_of_tasalot_F;
      x=numel(number_of_tasalot_F)-1;
      Number_of_dominance=[Number_of_dominance;x];
     
end
Number_of_dominance;
disp('-----------------------------------------------------------------------------')
 Number_of_defeats=[];
for o=1:k
     
       Number_of_defeats_F=[ find(Final_dominance_matrix(:,o))];
     
     soton=o;
     
      
    Number_of_defeats_F = Number_of_defeats_F;
     y= numel(Number_of_defeats_F)-1;
           Number_of_defeats=[Number_of_defeats;y];

end

Difference=Number_of_dominance-Number_of_defeats

%end program