## 교제 343p
## 상자그림을 이용하여 자동차 데이터 분석하기

mtcars

### 기어의 수(gear)에 따른 연비 분포
par(mfrow=c(2,1))
boxplot(mtcars$mpg~mtcars$gear)
plot(mtcars$mpg,mtcars$gear)
cor(mtcars$mpg,mtcars$gear)	# 피어슨상관계수 : 0.4802848

### 엔진 형태(vs)에 따른 연비 분포
boxplot(mtcars$mpg~mtcars$vs)
plot(mtcars$mpg,mtcars$vs)
cor(mtcars$mpg,mtcars$vs)		# 피어슨상관계수 : 0.6640389


### 변속기 종류(am)에 따른 연비 분포
boxplot(mtcars$mpg~mtcars$am)
plot(mtcars$mpg,mtcars$am)
cor(mtcars$mpg,mtcars$am)		# 피어슨상관계수 : 0.5998324


boxplot(mtcars)
# disp값만 너무 커서 다른 값들 찌그러져서 나옴 -> 스케일링 필요(표준화)

tmp = scale(mtcars)
summary(tmp)
boxplot(tmp)

setwd("C:/Sources/StuddyR/day3")
savePlot("mtcars 스케일링 후",type="png")






