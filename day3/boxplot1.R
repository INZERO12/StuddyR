## 338p
## 상자그림(boxplot)
## 이상치
dist = cars[,2]
boxplot(dist, main = '자동차 제동거리')
boxplot.stats(dist)
# $stats
# [1]  2 26 36 56 93	# 정상 범위의 데이터 내에서 사분위수에 해당하는값
#     # ㄴ최솟값, 1사분위수, 중앙값, 사분위수, 최댓값 순
# $n
# [1] 50
#
# $conf
# [1] 29.29663 42.70337
#
# $out
# [1] 120
###############################################################3
str(tips)
boxplot(tip~day, data=tips) 	 # Sat 이상치

tmp = subset(tips, day=='Sat')
par(mfrow=c(2,2))
boxplot(tip~size, data=tmp)
boxplot(tip~sex, data=tmp)
boxplot(tip~smoker, data=tmp)
boxplot(tip~time, data=tmp)

setwd("C:/Sources/StuddyR/day3")
savePlot("토요일 boxplot",type="png")




boxplot(tips$tip)	# 대략 6이상은 이상치
tt = subset(tips,tip<5)
summary(tt)
boxplot(tt$tip)
savePlot("boxplot 이상치제거",type="png")



str(tt)
boxplot(tip~day, data=tt)	# 이상치 제거

tmp = subset(tips, day=='Fri')
par(mfrow=c(2,2))
boxplot(tip~size, data=tmp)
boxplot(tip~sex, data=tmp)
boxplot(tip~smoker, data=tmp)
boxplot(tip~time, data=tmp)














