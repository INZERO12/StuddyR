# 6. 데이터 가공하기
# 데이터 전처리
# 함수명 : 기능
# filter() : 행 추출
# select() : 열(변수) 추출
# arrange() : 정렬
# mutate() :  변수 추가
# summarise() : 통계치 산출
# group_by() : 집단별로 나누기
# left_join() : 데이터 합치기(열)
# bind_row():데이터 합치기(행)



exam

# exam 에서 class가 1인 경우만 추출하여 출력
exam %>% filter(class ==1)  # %>% => '~ 중에서' 라는 의미
# 참고) [Ctrl+Shit+M]으로 %>% 기호 입력


# 1반이 아닌 경우
exam %>% filter(class!=1)



# 여러 조건을 충족하는 행 추출하기
# 1반이면서 수학 점수가 50점 이상인 경우 / 그리고 => &
exam %>% filter(class ==1 & math >= 50)

# 또는=>|
exam %>% filter(math >= 90 | english >= 60)


# 목록에 해당하는 행 추출하기
# 1, 3, 5반에 해당되면 추출
exam %>% filter(class ==1 | class ==3 | class ==5)

exam %>% filter(class %in% c(1,2,3))


# 추출한 행으로 데이터 만들기
class1 <- exam %>% filter(class == 1) # class가 1인 행 추출, class1에 할당
class2 <- exam %>% filter(class == 2) # class가 2인 행 추출, class2에 할당

mean(class1$math)                     # 1반 수학 점수 평균 구하기
mean(class2$math)                     # 2반 수학 점수 평균 구하기


# R에서 사용하는 기호
# - 논리연산자
# 논리 연산자 기준 -> 왼쪽
# - 산술연산자



# mpg 데이터를 이용해 분석 문제를 해결해 보세요
mpg

# Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다.
# displ(배기량)이 4이하인 자동차와 5이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요
class1 <- mpg %>% filter(displ <= 4)
class2 <- mpg %>% filter(displ >= 5)
class2
mean(class1$hwy)
mean(class2$hwy)


#Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. "audi"와 "toyota"중 어느 
#manufacture(자동차제조회사)의 cty(도시연비)가 평균적으로 더 높은지 알아보세요
class3 <- mpg %>% filter(manufacturer == "audi")
class4 <- mpg %>% filter(manufacturer == "toyota")
mean(class3$cty)
mean(class4$cty)


# Q3. "chevrolet","ford","honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다.
# 이 회사들의 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요

mpg_new <- mpg %>% filter(manufacturer %in% c("chevrolet","ford","honda"))
mean(mpg_new$hwy)




# 변수 추출하기
exam %>% select(math)   # math만 추출


# 여러 변수 추출하기
exam %>% select(math,science)

# 변수 제외하기 
exam %>% select(-math)  # math 제외
exam %>% select(-math, -english)  # math, english 제외


# dplyr 함수 조합하기
# class가 1인 행만 추출한 다음 english 
# 행 추출 : filter()
# 열(변수) 추출 : select()
exam %>% filter(class == 1) %>% select(english)

# 들여쓰기
exam %>%
  filter(class == 1) %>% 
  select(english)

# mpg 데이터를 이용해서 분석 문제를 해결해보세요
# Q1. mpg데이터는 11개 변수로 구성되어 있습니다. 이 중 일부만 추출해서 분석에 활용하려고 합니다
# mpg데이터에서 class(자동차종류), cty(도시연비)변수를 추출해 새로운 데이터를 만드세요. 새로 만든
# 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인

a <- mpg %>%  select(class,cty)
head(a)

# Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다. 앞에서 추출한 데이터를 이용해서
# class가 "suv"인 자동차와 "compact"인 자동차 중 어떤 자동차의 cty가 더 높은지 알아보세요
b <- a %>% filter(class == "suv")
c <- a %>% filter(class == "compact")
suv_mean <- mean(b$cty)
compact_mean<-mean(c$cty)

