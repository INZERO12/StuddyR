# 교재 141p)
# R 카페의 매출액 분석하기
# 1. 리스트를 생성해 메뉴별 판매량, 메뉴별 가격, 메뉴 이름 저장
# 리스트사용 방법1
# list 장점 : 막나온다
cafe = list(espresso = c(4,5,3,6,5,4,7),
americano = c(63,68,64,68,72,89,94),
latte = c(61,70,59,71,71,92,88),
price = c(2.0,2.5,3.0),
menu = c('espresso','americano','latte'))
cafe
str(cafe)
summary(cafe)

# 리스트사용 방법2
espresso = c(4,5,3,6,5,4,7)
americano = c(63,68,64,68,72,89,94)
latte = c(61,70,59,71,71,92,88)
price = c(2.0,2.5,3.0)
menu = c('espresso','americano','latte')

cafe = list(espresso,americano,latte,price,menu)
cafe
str(cafe)

# 데이터프레임사용
cafe = data.frame(espresso = c(4,5,3,6,5,4,7),
americano = c(63,68,64,68,72,89,94),
latte = c(61,70,59,71,71,92,88),
price = c(2.0,2.5,3.0),
menu = c('espresso','americano','latte'))
cafe
str(cafe)
summary(cafe)

# 2.생성한 리스트에서 메뉴만 추출해 팩터로 변경
cafe$menu=factor(cafe$menu)
str(cafe)
cafe[[1]] # 인덱싱


# 3.리스트 내 가격 벡터를 선택해 값의 이름을 메뉴명으로 설정
names(cafe$price) = cafe$menu
cafe

cafe$price
names(cafe$price)
str(cafe)

str(cafe$price)
cafe$price[1] # espresso 가격



# R에는 내장데이터를 많이 제공
# 자동차 연비와 관련된 mtcars
mtcars	# read없는 자료는 내장자료
str(mtcars)
#'data.frame':   32 obs. of  11 variables: 		# => 32개의 자료 11개의 변수

head(mtcars, 3)	#상위 3개만 보자
# 인덱스 열 : 맨 첫열/ 호출하는 용도 /데이터에는 포함 x
summary(mtcars) # 자동차 연비와 관련된 작업
plot(mtcars$mpg) # 산점도 => 중앙값과 평균로 분포 알 수 있다

mtcars

# 차량(mpg)과 실린더 갯수(cyl)가 관련이 있을까?
# cyl에 따른 mpg분류 => 명목형변수로 보겠다
# vs, am은 0또는 1 => 'yes' or 'no' 명목형변수

summary(mtcars$cyl)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  4.000   4.000   6.000   6.188   8.000   8.000 

summary(factor(mtcars$cyl))
# 4  6  8 
# 11  7 14 # cyl 4개짜리 11개 / 6개짜리 7개 / 8개짜리 14개



names(summary(factor(mtcars$cyl))) # 위에 있는 제목을 불러오는 것
# [1] "4" "6" "8"
levels(factor(mtcars$cyl))
# [1] "4" "6" "8"
unique(mtcars$cyl)
#[1] 6 4 8
# => 3개 모두 같은 명령
# names,levels는 데이터를 유니크한 다음 솔팅
# unique는 맨위에 있는 데이터셋부터 중복제거



# wordcloud(names(전체데이터), 실제데이터 값)
tmp=summary(factor(mtcars$cyl))
tmp
names(tmp)=c('cyl:4','cyl:6','cyl:8') # 이름 붙이기
tmp





### 리스트작업(자료, 기준) 작업하면 리스트화됨
tmp=split(mtcars, mtcars$cyl)
str(tmp)
tmp[[1]] # cyl 4의 데이터셋
split(tmp[[1]],tmp[[1]]$am) # am단위 로 나누기

# test
