clear all
close all
clc

data = readtable("..\NoCmake\result\result.csv");
data.avg_run = data.runTimeInMs./data.sampleSize;
data.run(:) = "parallel";

figure
subplot(1,2,1)
boxplot(data.runTimeInMs,data.sampleSize,"LabelOrientation",'inline')
title("Párhuzamos futási idők")
set(gca, 'YScale', 'log')
ylabel("mikroszekundum")
xlabel("mintaszám")
subplot(1,2,2)
boxplot(data.avg_run,data.sampleSize,"LabelOrientation",'inline')
title("Egy minta átlagos futási ideje")
ylabel("mikroszekundum")
xlabel("mintaszám")

%%
figure
title("paraméterek becsült értéke")
subplot(2,2,1)
boxplot(data.beta,data.sampleSize,"LabelOrientation",'inline')
title("\beta becsült értéke")
ylabel("\beta")
xlabel("mintaszám")
subplot(2,2,2)
boxplot(data.eta,data.sampleSize,"LabelOrientation",'inline')
title('\eta becsült értéke')
ylabel("\eta")
xlabel("mintaszám")
subplot(2,2,3)
boxplot(data.ap,data.sampleSize,"LabelOrientation",'inline')
title('a_{p} becsült értéke')
ylabel("a_{p}")
xlabel("mintaszám")
subplot(2,2,4)
boxplot(data.ar,data.sampleSize,"LabelOrientation",'inline')
title('a_{r} becsült értéke')
ylabel("a_{r}")
xlabel("mintaszám")
%%
figure 
limit = 1000;
subplot(2,2,1)
boxplot(data.beta(data.sampleSize>limit,:),data.sampleSize(data.sampleSize>limit,:),"LabelOrientation",'inline')
title("\beta becsült értéke")
ylabel("\beta")
xlabel("mintaszám")
subplot(2,2,2)
boxplot(data.eta(data.sampleSize>limit,:),data.sampleSize(data.sampleSize>limit,:),"LabelOrientation",'inline')
title("\eta becsült értéke")
ylabel("\eta")
xlabel("mintaszám")
subplot(2,2,3)
boxplot(data.ap(data.sampleSize>limit,:),data.sampleSize(data.sampleSize>limit,:),"LabelOrientation",'inline')
title("a_{p} becsült értéke")
ylabel("a_{p}")
xlabel("mintaszám")
subplot(2,2,4)
boxplot(data.ar(data.sampleSize>limit,:),data.sampleSize(data.sampleSize>limit,:),"LabelOrientation",'inline')
title("a_{r} becsült értéke")
ylabel("a_{r}")
xlabel("mintaszám")
%%
variance_beta = sqrt(var(data.beta(data.sampleSize == 10000000)))
variance_eta = sqrt(var(data.eta(data.sampleSize == 10000000)))
variance_ap = sqrt(var(data.ap(data.sampleSize == 10000000)))
variance_ar = sqrt(var(data.ar(data.sampleSize == 10000000)))
avg_var_sqrt = (variance_ar+ variance_ap+variance_eta+variance_beta)/4

%%
data2 = readtable(".\results\single_core_result.csv");
data2.avg_run = data2.runTimeInMs./data2.sampleSize;
data2.run(:) = "serial";
%%
figure
subplot(1,2,1)
boxplot(data2.runTimeInMs,data2.sampleSize,"LabelOrientation",'inline')
set(gca, 'YScale', 'log')
title("Soros futási idők")
set(gca, 'YScale', 'log')
ylabel("mikroszekundum")
xlabel("mintaszám")
subplot(1,2,2)
boxplot(data2.avg_run,data2.sampleSize,"LabelOrientation",'inline')
title("Egy minta átlagos futási ideje")
ylabel("mikroszekundum")
xlabel("mintaszám")
%%

full = cat(1,data(data.sampleSize>100,:),data2(data2.sampleSize>100,:));
figure Name 'Összehasonlítás'
boxplot(full.avg_run,{full.run,full.sampleSize},"LabelOrientation",'inline');
title("Egy minta átlagos futási ideje")
ylabel("mikroszekundum")
xlabel("mintaszám")
%%
figure Name 'Szeparált összehasonítás'
subplot(1,2,1)
boxplot(data.avg_run(data.sampleSize>100,:),...
    data.sampleSize(data.sampleSize>100,:),"LabelOrientation",'inline')
title("párhuzamos futásidő","egy mintára számolt átlag (N=10)")
xlabel mintaszám
ylabel mikroszekundum
subplot(1,2,2)
boxplot(data2.avg_run(data2.sampleSize>100,:),...
    data2.sampleSize(data2.sampleSize>100,:),"LabelOrientation",'inline')
title("nem párhuzamosított futásidő","egy mintára számolt átlag (N=5)")
xlabel mintaszám
ylabel mikroszekundum
%%
avg_run_parralel = mean(data.avg_run)
avg_run_serial = mean(data2.avg_run)
avg_run_parralel_nbias = mean(data.avg_run(data.sampleSize>100))
avg_run_serial_nbias = mean(data2.avg_run(data2.sampleSize>100))
hB = bar([avg_run_serial avg_run_parralel;avg_run_serial_nbias avg_run_parralel_nbias]);
title("átlagos futásidő javulása párhuzamosítás esetén","N_{párhuzamos}=10         N_{soros}=5")
ylabel mikroszekundum
set(hB(1),"FaceColor",'#77AC30');
set(hB(2),"FaceColor",'#EDB120');
set(gca, 'XTickLabel',{'összes minta', ' 100-nál nagyobb minta'})
labels = {'soros','párhuzamos','soros','párhuzamos'};
hT=[];              % placeholder for text object handles
for i=1:length(hB)  % iterate over number of bar objects
   hT=[hT,text(hB(i).XData+hB(i).XOffset,hB(i).YData,labels(:,i), ...
          'VerticalAlignment','bottom','horizontalalign','center')];
end
improvement = avg_run_serial_nbias/avg_run_parralel_nbias