% RTs par conditions & rewards
subplot(2,2,3)
hold on;
bar([nanmean(rt_DC_smallRwd) 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
bar([0 nanmean(rt_DC_largeRwd) 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
bar([0 0 nanmean(rt_CC_smallRwd) 0 0 0],'FaceColor',[0.85 0.85 0.85]);
bar([0 0 0 nanmean(rt_CC_largeRwd) 0 0],'FaceColor',[0.65 0.65 0.65]);
bar([0 0 0 0 nanmean(rt_BC_smallRwd) 0],'FaceColor',[0.50 0.65 0.50]);
bar([0 0 0 0 0 nanmean(rt_BC_largeRwd)],'FaceColor',[0.30 0.45 0.30]);
errorbar(1, nanmean(rt_DC_smallRwd), nanstd(rt_DC_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(2, nanmean(rt_DC_largeRwd), nanstd(rt_DC_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(3, nanmean(rt_CC_smallRwd), nanstd(rt_CC_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(4, nanmean(rt_CC_largeRwd), nanstd(rt_CC_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(5, nanmean(rt_BC_smallRwd), nanstd(rt_BC_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(6, nanmean(rt_BC_largeRwd), nanstd(rt_BC_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
xticks([1 2 3 4 5 6])
xticklabels({'DC SR','DC LR','CC SR','CC LR','BC SR',' BC LR'})
ylabel('log(RTs)','fontsize', 10)
title('RTs According to Rewards and Conditions','fontsize', 10)
axis([0 7 -.8 .8])
grid minor
box on
hold off

% Performance par lag
subplot(2,4,4)
hold on;
bar([mean(perf_lag2) 0],'FaceColor',[.9, .8, .9]);
bar([0 mean(perf_lag4)],'FaceColor',[.9, .7, .7]);
errorbar(1, mean(perf_lag2), perf_lag2_sem, 'k.','LineWidth',1)
errorbar(2, mean(perf_lag4), perf_lag4_sem, 'k.','LineWidth',1);
xticks([1 2])
xticklabels({'Lag 2','Lag 4'})
ylabel('Performance','fontsize', 10)
title('Performance According to Lag Size','fontsize', 10)
axis([0 3 50 100])
grid minor
box on
hold off




bar([smallRwd_rate 0],'FaceColor',[.45, .75, .80]);
bar([0 largeRwd_rate],'FaceColor',[.00, .45, .55]);
errorbar(1, smallRwd_rate, smallRwd_rate_sem, 'k.','LineWidth',1)
errorbar(2, largeRwd_rate, largeRwd_rate_sem, 'k.','LineWidth',1);

% first performance box plots 
subplot(2,3,1)
hold on;
perf_plotY = [perf_DC.', perf_CC_DC.', perf_CC.' ,perf_CC_BC.' ,perf_BC.'];
perf_plotX = [1, 2, 3, 4, 5];
perf_plot_color = {[.40 .55 .40], [.75 .85 .75], [.75 .75 .75], [.85 .75 .75], [.55 .25 .35]};
B = boxplot(perf_plotY, perf_plotX,'Widths',.7);
get (B, 'tag'); 
set(B(1,:), 'color', 'k'); set(B(2,:), 'color', 'k');
set(B(6,:), 'color', 'k', 'linewidth', 2);
scatter(perf_plotX,mean(perf_plotY),'k','filled','d')
h = findobj(gca,'Tag','Box');
 for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),perf_plot_color{j},'FaceAlpha',.7);
 end
xticks([1 2 3 4 5])
xticklabels({'DC','CC/DC', 'CC', 'CC/BC','BC'})
ylabel('Performance','fontsize', 10)
title('Performance According to Conditions','fontsize', 10)
axis([0 6 50 105])
grid minor
box on
hold off

% Performance par conditions & rewards
subplot(2,2,3)
hold on;
bar([perf_DC_smallRwd 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
bar([0 perf_DC_largeRwd 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
bar([0 0 perf_CC_smallRwd 0 0 0],'FaceColor',[0.85 0.85 0.85]);
bar([0 0 0 perf_CC_largeRwd 0 0],'FaceColor',[0.65 0.65 0.65]);
bar([0 0 0 0 perf_BC_smallRwd 0],'FaceColor',[0.50 0.65 0.50]);
bar([0 0 0 0 0 perf_BC_largeRwd],'FaceColor',[0.30 0.45 0.30]);
errorbar(1, perf_DC_smallRwd, perf_DC_smallRwd_sem, 'k.','LineWidth',1)
errorbar(2, perf_DC_largeRwd, perf_DC_largeRwd_sem, 'k.','LineWidth',1)
errorbar(3, perf_CC_smallRwd, perf_CC_smallRwd_sem, 'k.','LineWidth',1)
errorbar(4, perf_CC_largeRwd, perf_CC_largeRwd_sem, 'k.','LineWidth',1)
errorbar(5, perf_BC_smallRwd, perf_BC_smallRwd_sem, 'k.','LineWidth',1)
errorbar(6, perf_BC_largeRwd, perf_BC_largeRwd_sem, 'k.','LineWidth',1)
xticks([1 2 3 4 5 6])
xticklabels({'DC SR','DC LR','CC SR','CC LR','BC SR',' BC LR'})
ylabel('Performance','fontsize', 10)
title('Performance According to Rewards and Conditions','fontsize', 10)
axis([0 7 50 100])
grid minor
box on
hold off

