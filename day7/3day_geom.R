library(dplyr)
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
economics=as.data.frame(ggplot2::economics)

# 08-4. 선 그래프 - 시간에 따라 달라지는 데이터 표현
# 선그래프(Line Chart) : 데이터를 선으로 표현한 그래프
# 시계열 그래프(Time Series Chart) 
#   : 일정 시간 간격을 두고 나열된 시계열 데이터를 선으로 표현한 그래프
#     환율, 주가지수 등 경제 지표가 시간에 따라 어떻게 변하는지 표현할 때 활용


# 시계열 그래프 만들기
head(economics)
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()


# Q1. psavert(개인저축률)가 시간에 따라서 어떻게 변해왔는지 알아보려고 합니다. 시간에 따른 
# 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요
ggplot(data = economics, aes(x = date, y = psavert))+ geom_line()






# 08-5. 상자 그림 - 집단 간 분포 차이 표현하기
# 상자 그림 : 데이터 분포(퍼져 있는 형태)를 직사각형 상자 모양으로 표현한 그래프


# 상자 그림 만들기
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()
# drv가 4,f,r 3개라서 boxplot도 3개 그려짐
# 고속도로별 구동방식의 관계


# Q1. class(자동차 종류)가 "compact","subcompact","suv"인 자동차의 cty(도시연비)가
# 어떻게 다른지 비교해보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어보세요.
class_mpg = mpg %>% 
  filter(class %in%  c("compact","subcompact","suv"))
ggplot(data = class_mpg, aes(x = class, y = cty)) + geom_boxplot()

# 정리
# 1. 산점도(geom_point())
# 2. 평균막대그래프(geom_col())
# 3. 빈도 막대 그래프(geom_bar())
# 4. 선 그래프
# 5. 상자그림





