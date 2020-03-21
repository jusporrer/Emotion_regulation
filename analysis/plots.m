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