P=xlsread('eldat.xlsx',1,'A1:L7'); %Training x data
T=xlsread('eldat.xlsx',1,'A8:L8'); %Training y data
TestInput=xlsread('eldat.xlsx',1,'A9:L15'); %Testing x data
TestOutput=xlsread('eldat.xlsx',1,'A16:L16'); %Testing y data
% preprocessing data
[pn,minp,maxp, tn,mint,maxt]=premnmx(P,T);
%Normalization of data
p2= tramnmx(TestInput,minp,maxp);
% setting up neural 
netnet_1 = newelm(minmax(pn), [8,1],{'tansig','purelin'},'traingdm');
%training parameters
net_1.trainParam.show = 50;
net_1.trainParam.lr = 0.01;
net_1.trainParam.mc = 0.9;
net_1.trainParam.epochs =10000;
net_1.trainParam.goal = 1e-3;
min=10000000000;
tot = 0;
mi = i;
%Train NN for 100 times
for i = 1:100
    net=init(net_1);%initiating neural net
    %training neural net
    net = train(net,pn,tn);
    PN = sim(net,p2);
    %Denormalize
    TestResult= postmnmx(PN,mint,maxt);
    %Calculating Error value
    E =TestOutput - TestResult;
    MSE=mse(E);
    Rmse=sqrt (MSE);
    for kk=1:12
        tot=tot+abs(E(kk));
    end
    %Finding the one with least error
    if tot<min
        min=tot;
        Result=TestResult;
        mnet = net;
        mi=i;
    end
    tot = 0;
end