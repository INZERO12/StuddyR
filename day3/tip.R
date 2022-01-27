#############################################################
## 교제 189p
## 종업원의 팁 계산하기
### 자료파악 : 변수의 성격과 해설
### total_bill : 전체지불비용
### tip : tip비용
### sex : 성별(누구의 성별인지 알아야한다)
### smoker : 흡연석/비흡연석
### day : 요일
### time : 방문시간
### size : 방문인원
install.packages('reshape2')
library(reshape2)
tips				# reshape2안에 있는 tip 데이터셋 불러오기
head(tips)			# 처음 6개의 관측값 출력
				# => 타이틀 확인 / 데이터셋이 잘 들어왔는지 확인

str(tips)			# 데이터구조확인 => day는 factor라는 것을 확인 
unique(tips$day)		# 항목 개수 확인1 => 4개(Sun  Sat  Thur Fri)
levels(tips$day)		# 항목 개수 확인2 =>4개("Fri"  "Sat"  "Sun"  "Thur")
				# levels의 문자형 순서는 나온순서

sum(is.na(tips))		# 결측치 개수 확인

unique(tips[,3])


for(i in 1:length(tips)){
	if(class (tips[,i])=='factor'){	# factor형이 맞다면 출력
	 print(unique(tips[,i]))
	}
}


#############################################################
#### 가설과 검증
####
#############################################################
# 1번가설: 성별(독립변수,x값)에 따르는 tip(종속변수, y값, 레이블)의 비용은 같다
#	    0가설(귀무가설)
#	    검증을 통해서 비용은 같다 => 귀무가설 선택
#	    비용이 다르다 => 귀무가설 기각 / 대립가설 선택
#	    pvalue통해서 확인함.(통계에서는)
# =>통계가설
# 일반적인 가설검증은 데이터집계를 통해서 비교

table(tips[,3])	# 성별의 빈도수, 전체데이터의 발생횟수
table(tips[,4])

# 보고서화 - 성별,흡연석,요일,방문시간, 방문인원 빈도수 한번에 확인(명목형)
# size는 int형이지만 카운팅하는 것이기 때문에 명목형이라고 친다 / 그 외는 factor
for(i in 3:7){
	print(paste('---',names(tips)[i],'---'))
	print(table(tips[i]))			# for안에는 항상 print
}


# dinner와 lunch의 팁의 평균
din = subset(tips, time =='Dinner')
lun = subset(tips, time =='Lunch')	# Dinner와 Lunch 분리

table(tips$day)			# 요일별 확인
table(din$day)
table(lun$day)			
head(din)		# 디너하고 런치데이터를 숫자로만 구성되게 만들어서 평균구해야한다

table(tips$time)

# colMeans 사용하면 문자제거하지 않고 평균구하기 가능
colMeans(din[c('total_bill','tip','size')])
colMeans(lun[c('total_bill','tip','size')])


colSums(din[c('total_bill','tip','size')])
colSums(lun[c('total_bill','tip','size')])
# 평균은 차이가 안나는데, 합계는 차이가 난다 
# => lunch에 단체손님이 tip을 많이 지불했을거라 예상

par(mfrow=c(2, 1))
plot(din$tip)
plot(lun$tip) # dinner와 lunch tip 비교
# 평균이 유의미한게 아니다 => 편차와 분산이 중요

setwd("C:/Sources/StuddyR/day3")
savePlot("dinner와 lunch tip 비교",type="png")

summary(lun)	# 인원수에서 이슈발견
tmp = subset(lun,tip>=4)	# tip을 많이주는 사람들은 규모가 큰 사람들인걸 알수있다
summary(tmp)

summary(lun)

subset(tips,tips$day=='Fri') # 금요일에는 단체손님이 거의 없다
summary(subset(tips,tips$day=='Fri'))
# size      
# Min.   :1.000  
# 1st Qu.:2.000  
# Median :2.000  
# Mean   :2.105  
# 3rd Qu.:2.000  # 75퍼센트가 2명(소규모) 
# Max.   :4.000 


# lunch 금요일, 인원수 빈도수 확인
table(tmp$size)
# 2 3 4 5 6 
# 5 1 4 1 3 



## 성별에 따라 tip의 차이가 없다
# tips 성별별 빈도수 확인
table(tips[,3])

fe = subset(tips, tips[,3] =='Female')
ma = subset(tips, sex =='Male')
summary(fe)
summary(ma)

tmp = subset(fe,size>=4)
summary(tmp)
table(tmp$size)
summary(lun)

summary(din)	
tmp = subset(ma, size>=4)
summary(tmp)
table(tmp$size)


par(mfrow=c(2,1))
plot(fe$tip,main='F sum of Tips')
plot(ma$tip,main='M sum of Tips')

savePlot("성별의 tip 비교",type="png")


par(mfrow=c(2,1))
plot(fe$size,main='F - size')
plot(ma$size,main='M - size')
# 여자 고객이 남자고객보다 단체고객이 많다
# 여자가 남자보다 덜 왔지만 한번에 많이 온다
# 성별과 인원수는 상관관계가 있다 => 상관도분석 필요

savePlot("성별의 인원수 비교",type="png")


##################################################
## 344p
# 산점도
tips

plot(tips[,1])
plot(tips[,1],tips[,2])
plot(tips[,7],tips[,1]) # 인원수대비 가격(전체 지불비용)

savePlot("인원수대비 가격(전체 지불비용)",type="png")


str(tips)
colNum=c(1,2,7)
par(mfrow=c(3,1))


for (i in colNum){
plot(tips[,i],main=names(tips)[i])
}
savePlot("산점도그래프",type="png")
plot(iris[,3])


# 347p
mtcars
str(mtcars)
plot(mtcars)
plot(mtcars[,c(1,3,5,6)])
# 그래프에서 왼쪽 아래그래프 해석 시,mpg(연비)가 y변수
# 그림이 몰려있을수록 데이터의 연관성 높다



# 피어슨상관계수 (-1~1사이값) => cor
# 문자데이터 들어가 있으면 에러남


cor(mtcars[,c(1,3,5,6)])
#            mpg       disp       drat         wt
# mpg   1.0000000 -0.8475514  0.6811719 -0.8676594
# disp -0.8475514  1.0000000 -0.7102139  0.8879799
# drat  0.6811719 -0.7102139  1.0000000 -0.7124406
# wt   -0.8676594  0.8879799 -0.7124406  1.0000000
# 보통 0.7이상이면 연관도가 있다 => mpg와 disp,drat,wt는 모두 연관도가 있다

cor(mtcars)



############################################################
### * 인공지능
#### 머신러닝(기계가 학습하여 모델을 생성하고 새로운 데이터를 예측하거나 분류)
#### 그중 사진, 오디오, 비디오등의 비정형데이터는 양이 엄청 많음.
#### 이러한 비정형데이터에 특화된 분석은 인공신경망을 이용하고 이를 딥러닝이라고 함
####
### *머신러닝(기계학습)
####  기계를 이용한 독립변수들과 종속변수의 분석을 통한 예측, 분류
#### (이때 x값과 연관있는 y값을 찾아내야 함)
#### 독립변수(x)끼리는 상관도가 너무 높으면 안됨.
#### 상관도가 너무 높은 경우는 다중공선성이라함.
#### 다중공선성은 VIF(분산팽창지수)로 결과 숫자값이 10이상나오는 것을 의미
#### 이런경우 x변수를 제고하고, VIF보고, x변수 제거하고 VIF보고
####
############################################################
# 상관관계
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(mtcars, histogram=TRUE, pch=19)
# mtcars의 상관관계



tmp = tips[,c(2,1,7)]		
chart.Correlation(tmp,histogram=TRUE, pch=19)
# tip, total_bill,size의 상관관계(상관계수)

savePlot("Correlation_mtcars",type="png")













