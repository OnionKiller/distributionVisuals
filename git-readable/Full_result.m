clear all
close all
clc
%%
data = readtable("..\NoCmake\result\all_data.csv");
%%
figure
boxplot([data.param_0_,data.param_1_,data.param_2_,data.param_3_])
%%
accepted = data(data.accepted == 1,:);
figure
boxplot([accepted.param_0_,accepted.param_1_,accepted.param_2_,accepted.param_3_],["beta" "eta" "a_p" "a_r"])
title("Elfogadott minták eloszlása")
%%
figure
title("Elfogadott minták hisztogrammja")
subplot(2,2,1)
histogram(accepted.param_0_)
title("\beta")
subplot(2,2,2)
histogram(accepted.param_1_)
title("\eta")
subplot(2,2,3)
histogram(accepted.param_2_)
title("a_{p}")
subplot(2,2,4)
histogram(accepted.param_3_)
title("a_{r}")
%%
%results
beta_ = mean(accepted.param_0_)
eta_ = mean(accepted.param_1_)
a_r_ = mean(accepted.param_2_)
a_p_ = mean(accepted.param_3_)
beta_sigm = sqrt(var(accepted.param_0_))
eta_sigm = sqrt(var(accepted.param_1_))
a_r_sigm = sqrt(var(accepted.param_2_))
a_p_sigm = sqrt(var(accepted.param_3_))
%%
%Distribution guess comparsion
figure
x = 0:0.1:10;
original_pdf = wblpdf(x,2.2,1);
plot(original_pdf)
hold  on
plot(wblpdf(x,beta_,eta_))
title("Weibull eloszlások összehasonlítása")
xlabel t
ylabel f(t)
legend(["Szimuláció " "Becsült "])